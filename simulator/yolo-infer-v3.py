import cv2
import time
import requests
import PySimpleGUI as sg
from ultralytics import YOLO
import mysql.connector
from mysql.connector import Error

# --- CONFIGURATION ---
API_MACHINES_CSV = "http://127.0.0.1:8082/mes/api/machines-export.php?format=csv"

DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 3304,
    'user': 'xooiduyr_root', 
    'password': '@crgKvFVGv2TUSh', 
    'database': 'xooiduyr_mes'
}

# Indices from classes.txt: 0:DEFECT_01, 1:DEFECT_02, 2:DEFECT_03, 3:X2026R1_CONE, 4:X2026R1_DRUM
DEFECT_CLASSES = [0, 1, 2]
PART_CLASS = 3      # Cone
MATERIAL_CLASS = 4  # Drum

def fetch_machines():
    """Queries the API for available machines, parses CSV, and sorts ascending."""
    try:
        response = requests.get(API_MACHINES_CSV, timeout=3)
        if response.status_code == 200 and response.text.strip():
            csv_data = response.text.strip()
            machine_ids = sorted([int(x.strip()) for x in csv_data.split(',')])
            return machine_ids
    except Exception as e:
        print(f"Failed to fetch machines from API: {e}")
    return [1]

def get_db_connection():
    try:
        return mysql.connector.connect(**DB_CONFIG)
    except Error:
        return None

def check_intersection(boxA, boxB):
    """
    Checks if two bounding boxes intersect.
    Box format: [xmin, ymin, xmax, ymax]
    """
    xA_min, yA_min, xA_max, yA_max = boxA
    xB_min, yB_min, xB_max, yB_max = boxB

    if xA_max < xB_min or xB_max < xA_min:
        return False
    if yA_max < yB_min or yB_max < yA_min:
        return False
    return True

def fetch_production_context(machine_id, window):
    """Fetches and updates the GUI with the active machine and order context"""
    conn = get_db_connection()
    if not conn:
        return

    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT Name, Status FROM machine WHERE MachineID = %s", (machine_id,))
        machine = cursor.fetchone()
        if machine:
            window['-INFO_MACHINE-'].update(f"{machine['Name']} ({machine['Status']})")
        else:
            window['-INFO_MACHINE-'].update("Not Found", text_color='salmon')
            window['-INFO_ORDER-'].update("-")
            window['-INFO_ARTICLE-'].update("-")
            window['-INFO_PROGRESS-'].update("-")
            return

        cursor.execute("""
            SELECT po.OrderID, po.TargetQuantity, po.ProducedQuantity, po.Status,
                   a.Name as ArticleName
            FROM production_order po
            JOIN production_recipes pr ON po.RecipeID = pr.RecipeID
            JOIN article a ON po.ArticleID = a.ArticleID
            WHERE po.Status = 'Active' AND pr.MachineID = %s
            LIMIT 1
        """, (machine_id,))
        order = cursor.fetchone()

        if order:
            window['-INFO_ORDER-'].update(f"#{order['OrderID']}", text_color='lightgreen')
            window['-INFO_ARTICLE-'].update(order['ArticleName'], text_color='lightgreen')
            
            target = int(order['TargetQuantity'])
            produced = int(order['ProducedQuantity'])
            pct = (produced / target * 100) if target > 0 else 0
            
            window['-INFO_PROGRESS-'].update(f"{produced} / {target} ({pct:.1f}%)", text_color='lightgreen')
        else:
            window['-INFO_ORDER-'].update("No Active Order", text_color='yellow')
            window['-INFO_ARTICLE-'].update("-", text_color='white')
            window['-INFO_PROGRESS-'].update("-", text_color='white')
            
    except Error as e:
        window['-LOG-'].update(f"[DB ERROR] Context fetch failed: {e}\n", append=True, text_color_for_value='red')
    finally:
        cursor.close()
        conn.close()

def log_reject_to_db(machine_id, category_id, reason_id, window):
    """Logs the reject directly to the DB against the active order for this machine"""
    conn = get_db_connection()
    if not conn:
        window['-LOG-'].update("[DB ERROR] Could not connect to database.\n", append=True, text_color_for_value='red')
        return

    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("""
            SELECT po.OrderID, po.ArticleID 
            FROM production_order po
            JOIN production_recipes pr ON po.RecipeID = pr.RecipeID
            WHERE po.Status = 'Active' AND pr.MachineID = %s
            LIMIT 1
        """, (machine_id,))
        active_order = cursor.fetchone()

        if not active_order:
            return

        order_id = active_order['OrderID']
        article_id = active_order['ArticleID']
        qty = 1 
        operator_id = 1 

        cursor.execute("""
            INSERT INTO reject (OrderID, ArticleID, Quantity, ReasonID, CategoryID, MachineID, OperatorID, RejectDate)
            VALUES (%s, %s, %s, %s, %s, %s, %s, NOW())
        """, (order_id, article_id, qty, reason_id, category_id, machine_id, operator_id))

        conn.commit()
        
        type_str = "PART" if category_id == 1 else "MATERIAL"
        window['-LOG-'].update(f"[{time.strftime('%H:%M:%S')}] Logged {type_str} reject (ReasonID: {reason_id}) -> Order #{order_id}\n", append=True, text_color_for_value='yellow')
        
    except Error as e:
        conn.rollback()
        window['-LOG-'].update(f"[DB ERROR] {e}\n", append=True, text_color_for_value='red')
    finally:
        cursor.close()
        conn.close()

def main():
    sg.theme('DarkGrey9')
    
    machine_ids = fetch_machines()

    try:
        model = YOLO("best.pt")
    except Exception as e:
        sg.popup_error(f"Failed to load YOLO model: {e}\nPlease ensure the path is correct.")
        return

    col_video = [
        [sg.Image(filename='', key='-IMAGE-', size=(640, 480), background_color='black')]
    ]

    col_info = [
        [sg.Frame('Production Context', [
            [sg.Text("Machine Name:", size=(12, 1)), sg.Text("-", key="-INFO_MACHINE-", size=(25, 1), font='Any 10 bold', text_color='cyan')],
            [sg.Text("Active Order:", size=(12, 1)), sg.Text("-", key="-INFO_ORDER-", size=(25, 1), font='Any 10 bold', text_color='cyan')],
            [sg.Text("Part Article:", size=(12, 1)), sg.Text("-", key="-INFO_ARTICLE-", size=(25, 1), font='Any 10 bold', text_color='cyan')],
            [sg.Text("Progress:", size=(12, 1)), sg.Text("-", key="-INFO_PROGRESS-", size=(25, 1), font='Any 10 bold', text_color='cyan')]
        ], pad=(0, (0, 10)), expand_x=True)],
        [sg.Multiline(size=(45, 20), key='-LOG-', disabled=True, font='Courier 10', background_color='black', text_color='white', autoscroll=True)]
    ]

    layout = [
        [sg.Text("MES Vision QC Integration", font=("Helvetica", 16, "bold"))],
        [
            sg.Text("Machine:"), 
            sg.Combo(machine_ids, default_value=machine_ids[0] if machine_ids else '', key='-MACHINE-', size=(6, 1), readonly=True),
            sg.Text(" Conf:"),
            sg.Slider(range=(0.05, 1.0), default_value=0.25, resolution=0.05, orientation='h', size=(10, 15), key='-CONF-'),
            sg.Checkbox('Require Overlap', default=True, key='-REQUIRE_OVERLAP-', tooltip="If unchecked, ANY defect triggers a log"),
            sg.Button('Start', button_color='green', key='-START-', size=(8, 1)),
            sg.Button('Stop', button_color='red', key='-STOP-', disabled=True, size=(8, 1))
        ],
        [sg.Column(col_video), sg.Column(col_info, vertical_alignment='top')]
    ]

    window = sg.Window('YOLO Quality Control Panel', layout, finalize=True)
    
    cap = None
    is_running = False
    current_machine = None

    cooldowns = {'part': 0, 'material': 0}
    COOLDOWN_SECONDS = 5.0
    
    last_context_update = 0
    CONTEXT_UPDATE_INTERVAL = 5.0 

    while True:
        event, values = window.read(timeout=20) 

        if event == sg.WIN_CLOSED:
            break

        if event == '-START-':
            if not values['-MACHINE-']:
                window['-LOG-'].update("Please select a Machine.\n", append=True, text_color_for_value='red')
                continue
                
            current_machine = int(values['-MACHINE-'])

            cap = cv2.VideoCapture(0)
            if not cap.isOpened():
                window['-LOG-'].update("Error: Could not open webcam.\n", append=True, text_color_for_value='red')
                cap = None
            else:
                is_running = True
                window['-START-'].update(disabled=True)
                window['-STOP-'].update(disabled=False)
                window['-MACHINE-'].update(disabled=True)
                window['-LOG-'].update("Camera started. Waiting for defects...\n", append=True, text_color_for_value='lightgreen')
                
                fetch_production_context(current_machine, window)
                last_context_update = time.time()

        if event == '-STOP-':
            is_running = False
            if cap:
                cap.release()
                cap = None
            window['-START-'].update(disabled=False)
            window['-STOP-'].update(disabled=True)
            window['-MACHINE-'].update(disabled=False)
            window['-IMAGE-'].update(data=b'')
            window['-LOG-'].update("Camera stopped.\n", append=True, text_color_for_value='salmon')

        if is_running and cap:
            ret, frame = cap.read()
            if not ret:
                continue

            frame = cv2.resize(frame, (640, 480))
            
            frame = cv2.flip(frame, 1)

            current_time = time.time()

            if current_time - last_context_update > CONTEXT_UPDATE_INTERVAL:
                fetch_production_context(current_machine, window)
                last_context_update = current_time

            conf_thresh = float(values['-CONF-'])
            require_overlap = values['-REQUIRE_OVERLAP-']
            
            results = model.predict(source=frame, conf=conf_thresh, verbose=False)
            boxes = results[0].boxes
            
            defects = []
            parts = []
            materials = []

            for box in boxes:
                cls_id = int(box.cls[0].item())
                coords = box.xyxy[0].tolist() 
                
                if cls_id in DEFECT_CLASSES:
                    defects.append(coords)
                elif cls_id == PART_CLASS:
                    parts.append(coords)
                elif cls_id == MATERIAL_CLASS:
                    materials.append(coords)

            for defect_box in defects:
                
                if not require_overlap:
                    if current_time - cooldowns['part'] > COOLDOWN_SECONDS:
                        log_reject_to_db(current_machine, category_id=1, reason_id=1, window=window)
                        cooldowns['part'] = current_time
                    continue 
                
                # If we DO require overlap
                if current_time - cooldowns['part'] > COOLDOWN_SECONDS:
                    for part_box in parts:
                        if check_intersection(defect_box, part_box):
                            log_reject_to_db(current_machine, category_id=1, reason_id=1, window=window)
                            cooldowns['part'] = current_time
                            break
                
                if current_time - cooldowns['material'] > COOLDOWN_SECONDS:
                    for material_box in materials:
                        if check_intersection(defect_box, material_box):
                            log_reject_to_db(current_machine, category_id=3, reason_id=11, window=window)
                            cooldowns['material'] = current_time
                            break

            # Plot boundaries and update GUI
            annotated_frame = results[0].plot()
            imgbytes = cv2.imencode('.png', annotated_frame)[1].tobytes()
            window['-IMAGE-'].update(data=imgbytes)

    if cap:
        cap.release()
    window.close()

if __name__ == '__main__':
    main()
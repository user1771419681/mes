import cv2
import time
import PySimpleGUI as sg
from ultralytics import YOLO
import mysql.connector
from mysql.connector import Error

DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 3304,
    'user': 'xooiduyr_root', 
    'password': '@crgKvFVGv2TUSh', 
    'database': 'xooiduyr_mes'
}

# indices: 0:DEFECT_01, 1:DEFECT_02, 2:DEFECT_03, 3:X2026R1_CONE, 4:X2026R1_DRUM
DEFECT_CLASSES = [0, 1, 2]
PART_CLASS = 3    
MATERIAL_CLASS = 4  

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
            window['-LOG-'].update(f"Defect ignored: No active order on Machine {machine_id}\n", append=True)
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

    try:
        model = YOLO("best.pt")
    except Exception as e:
        sg.popup_error(f"Failed to load YOLO model: {e}\nPlease ensure the path is correct.")
        return

    layout = [
        [sg.Text("MES Vision QC Integration", font=("Helvetica", 16, "bold"))],
        [sg.Text("Machine ID:"), sg.InputText("1", key='-MACHINE-', size=(5, 1)),
         sg.Button('Start Camera', button_color='green', key='-START-'),
         sg.Button('Stop Camera', button_color='red', key='-STOP-', disabled=True)],
        [sg.Image(filename='', key='-IMAGE-', size=(640, 480), background_color='black')],
        [sg.Multiline(size=(80, 10), key='-LOG-', disabled=True, font='Courier 10', background_color='black', text_color='white')]
    ]

    window = sg.Window('YOLO Quality Control', layout, finalize=True)
    
    cap = None
    is_running = False

    cooldowns = {
        'part': 0,
        'material': 0
    }
    COOLDOWN_SECONDS = 5.0

    while True:
        event, values = window.read(timeout=20) 

        if event == sg.WIN_CLOSED:
            break

        if event == '-START-':
            try:
                machine_id = int(values['-MACHINE-'])
            except ValueError:
                window['-LOG-'].update("Invalid Machine ID.\n", append=True, text_color_for_value='red')
                continue

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

            results = model.predict(source=frame, conf=0.30, verbose=False)
            
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

            current_time = time.time()

            for defect_box in defects:
                
                if current_time - cooldowns['part'] > COOLDOWN_SECONDS:
                    for part_box in parts:
                        if check_intersection(defect_box, part_box):
                            log_reject_to_db(machine_id, category_id=1, reason_id=1, window=window)
                            cooldowns['part'] = current_time
                            break
                
                if current_time - cooldowns['material'] > COOLDOWN_SECONDS:
                    for material_box in materials:
                        if check_intersection(defect_box, material_box):
                            log_reject_to_db(machine_id, category_id=3, reason_id=11, window=window)
                            cooldowns['material'] = current_time
                            break

            annotated_frame = results[0].plot()
            imgbytes = cv2.imencode('.png', annotated_frame)[1].tobytes()
            window['-IMAGE-'].update(data=imgbytes)

    if cap:
        cap.release()
    window.close()

if __name__ == '__main__':
    main()
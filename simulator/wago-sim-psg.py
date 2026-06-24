import mysql.connector
from mysql.connector import Error
import PySimpleGUI as sg
import datetime

def get_db_connection(config, window):
    try:
        conn = mysql.connector.connect(**config)
        return conn
    except Error as e:
        ui_log(window, f"[ERROR] Connecting to MySQL: {e}", text_color='red')
        return None

def process_wago_strokes(config, window):
    conn = get_db_connection(config, window)
    if not conn:
        return False 

    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM wago WHERE Processed = 0 ORDER BY Timestamp ASC")
        unprocessed_logs = cursor.fetchall()

        if not unprocessed_logs:
            return True

        ui_log(window, f"Found {len(unprocessed_logs)} unprocessed stroke(s)...", text_color='yellow')

        for log in unprocessed_logs:
            log_id = log['LogID']
            machine_id = log['MachineID']
            stroke_count = log['ProductionCount']

            if not machine_id:
                mark_processed(cursor, log_id)
                continue

            cursor.execute("""
                SELECT po.OrderID, po.RecipeID 
                FROM production_order po
                JOIN production_recipes pr ON po.RecipeID = pr.RecipeID
                WHERE po.Status = 'Active' AND pr.MachineID = %s
                LIMIT 1
            """, (machine_id,))
            active_order = cursor.fetchone()

            if not active_order:
                ui_log(window, f"Machine {machine_id} cycled, but no active order found. Skipping.", text_color='orange')
                mark_processed(cursor, log_id)
                continue

            order_id = active_order['OrderID']
            recipe_id = active_order['RecipeID']

            cursor.execute("INSERT INTO processed_production (LogID, OrderID, AssignedQuantity) VALUES (%s, %s, %s)", (log_id, order_id, stroke_count))
            cursor.execute("UPDATE production_order SET ProducedQuantity = ProducedQuantity + %s WHERE OrderID = %s", (stroke_count, order_id))

            cursor.execute("SELECT ArticleID, Quantity FROM recipe_outputs WHERE RecipeID = %s", (recipe_id,))
            for out in cursor.fetchall():
                qty_to_add = float(stroke_count) * float(out['Quantity'])
                update_progress(cursor, order_id, out['ArticleID'], 'Output', qty_to_add)

            cursor.execute("SELECT ArticleID, Quantity FROM recipe_inputs WHERE RecipeID = %s", (recipe_id,))
            for inp in cursor.fetchall():
                qty_to_consume = float(stroke_count) * float(inp['Quantity'])
                update_progress(cursor, order_id, inp['ArticleID'], 'Input', -qty_to_consume)

            mark_processed(cursor, log_id)

        conn.commit()
        ui_log(window, f"Successfully processed and committed {len(unprocessed_logs)} strokes.", text_color='lightgreen')
        return True

    except Error as e:
        conn.rollback()
        ui_log(window, f"[ERROR] Transaction failed: {e}", text_color='red')
        return False
    finally:
        cursor.close()
        conn.close()

def update_progress(cursor, order_id, article_id, progress_type, amount):
    cursor.execute("""
        INSERT INTO production_order_progress (OrderID, ArticleID, ProgressType, CurrentQuantity)
        VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE CurrentQuantity = CurrentQuantity + VALUES(CurrentQuantity)
    """, (order_id, article_id, progress_type, amount))

def mark_processed(cursor, log_id):
    cursor.execute("UPDATE wago SET Processed = 1 WHERE LogID = %s", (log_id,))

def ui_log(window, text, text_color=None):
    """Helper to inject logs into the Multiline with a timestamp."""
    timestamp = datetime.datetime.now().strftime("%H:%M:%S")
    formatted_msg = f"[{timestamp}] {text}\n"
    window['-LOG-'].update(formatted_msg, append=True, text_color_for_value=text_color, autoscroll=True)

def main():
    sg.theme('DarkBlue3')

    conn_frame = [
        [sg.Text('Host:', size=(8, 1)), sg.InputText('127.0.0.1', key='-HOST-', size=(20, 1)),
         sg.Text('Port:', size=(5, 1)), sg.InputText('3304', key='-PORT-', size=(6, 1))],
        [sg.Text('User:', size=(8, 1)), sg.InputText('xooiduyr_root', key='-USER-', size=(20, 1)),
         sg.Text('Pass:', size=(5, 1)), sg.InputText('@crgKvFVGv2TUSh', key='-PASS-', size=(15, 1), password_char='*')],
        [sg.Text('DB:', size=(8, 1)), sg.InputText('xooiduyr_mes', key='-DB-', size=(20, 1))]
    ]

    layout = [
        [sg.Frame('Connection Settings', conn_frame, pad=(5, 10))],
        [sg.Button('Start Engine', button_color='green', key='-BTN_START-'), 
         sg.Button('Stop Engine', button_color='red', key='-BTN_STOP-', disabled=True),
         sg.Button('Clear Logs', key='-BTN_CLEAR-')],
        [sg.Text('Processor Output Log:')],
        [sg.Multiline(size=(65, 15), key='-LOG-', disabled=True, font='Courier 10', background_color='black', text_color='white')]
    ]

    window = sg.Window('MES WAGO Stroke Processor', layout, finalize=True)
    ui_log(window, "App initialized. Awaiting start...", text_color='white')

    is_running = False

    while True:
        event, values = window.read(timeout=2000)

        if event == sg.WIN_CLOSED:
            break

        if event == '-BTN_CLEAR-':
            window['-LOG-'].update('')

        if event == '-BTN_START-':
            is_running = True
            window['-BTN_START-'].update(disabled=True)
            window['-BTN_STOP-'].update(disabled=False)
            ui_log(window, "--- Engine Started ---", text_color='lightgreen')
            
            for key in ['-HOST-', '-PORT-', '-USER-', '-PASS-', '-DB-']:
                window[key].update(disabled=True)

        if event == '-BTN_STOP-':
            is_running = False
            window['-BTN_START-'].update(disabled=False)
            window['-BTN_STOP-'].update(disabled=True)
            ui_log(window, "--- Engine Stopped ---", text_color='salmon')

            for key in ['-HOST-', '-PORT-', '-USER-', '-PASS-', '-DB-']:
                window[key].update(disabled=False)

        if event == sg.TIMEOUT_EVENT and is_running:
            try:
                db_config = {
                    'host': values['-HOST-'],
                    'port': int(values['-PORT-']),
                    'user': values['-USER-'],
                    'password': values['-PASS-'],
                    'database': values['-DB-']
                }
                
                success = process_wago_strokes(db_config, window)
                if not success:
                    is_running = False
                    window['-BTN_START-'].update(disabled=False)
                    window['-BTN_STOP-'].update(disabled=True)
                    ui_log(window, "Engine automatically stopped due to connection error.", text_color='orange')
                    for key in ['-HOST-', '-PORT-', '-USER-', '-PASS-', '-DB-']:
                        window[key].update(disabled=False)
                        
            except ValueError:
                ui_log(window, "[ERROR] Port must be a valid integer number.", text_color='red')
                is_running = False
                window['-BTN_START-'].update(disabled=False)
                window['-BTN_STOP-'].update(disabled=True)

    window.close()

if __name__ == '__main__':
    main()
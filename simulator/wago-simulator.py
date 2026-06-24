import time
import mysql.connector
from mysql.connector import Error

DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 3304,
    'user': 'xooiduyr_root', 
    'password': '@crgKvFVGv2TUSh', 
    'database': 'xooiduyr_mes'
}

def get_db_connection():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        return conn
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

def process_wago_strokes():
    conn = get_db_connection()
    if not conn:
        return

    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("SELECT * FROM wago WHERE Processed = 0 ORDER BY Timestamp ASC")
        unprocessed_logs = cursor.fetchall()

        if not unprocessed_logs:
            return

        print(f"Found {len(unprocessed_logs)} unprocessed stroke(s).")

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
                mark_processed(cursor, log_id)
                continue

            order_id = active_order['OrderID']
            recipe_id = active_order['RecipeID']

            cursor.execute("""
                INSERT INTO processed_production (LogID, OrderID, AssignedQuantity)
                VALUES (%s, %s, %s)
            """, (log_id, order_id, stroke_count))

            cursor.execute("""
                UPDATE production_order 
                SET ProducedQuantity = ProducedQuantity + %s 
                WHERE OrderID = %s
            """, (stroke_count, order_id))

            cursor.execute("SELECT ArticleID, Quantity FROM recipe_outputs WHERE RecipeID = %s", (recipe_id,))
            outputs = cursor.fetchall()
            for out in outputs:
                qty_to_add = float(stroke_count) * float(out['Quantity'])
                update_progress(cursor, order_id, out['ArticleID'], 'Output', qty_to_add)

            cursor.execute("SELECT ArticleID, Quantity FROM recipe_inputs WHERE RecipeID = %s", (recipe_id,))
            inputs = cursor.fetchall()
            for inp in inputs:
                qty_to_consume = float(stroke_count) * float(inp['Quantity'])
                update_progress(cursor, order_id, inp['ArticleID'], 'Input', -qty_to_consume)

            mark_processed(cursor, log_id)

        conn.commit()
        print(f"Successfully processed and committed {len(unprocessed_logs)} strokes.")

    except Error as e:
        conn.rollback()
        print(f"Transaction failed, rolling back. Error: {e}")
    finally:
        cursor.close()
        conn.close()

def update_progress(cursor, order_id, article_id, progress_type, amount):
    """
    Upserts the progress table. If the row doesn't exist, it creates it.
    If it does, it adds the amount (which handles both positive outputs and negative inputs).
    """
    cursor.execute("""
        INSERT INTO production_order_progress (OrderID, ArticleID, ProgressType, CurrentQuantity)
        VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE CurrentQuantity = CurrentQuantity + VALUES(CurrentQuantity)
    """, (order_id, article_id, progress_type, amount))

def mark_processed(cursor, log_id):
    cursor.execute("UPDATE wago SET Processed = 1 WHERE LogID = %s", (log_id,))

if __name__ == "__main__":
    print("--- WAGO Processor Started. Press Ctrl+C to stop ---")
    try:
        while True:
            process_wago_strokes()
            time.sleep(2) 
    except KeyboardInterrupt:
        print("\nProcessor stopped by user.")
import pymysql

# Database connection
db_config = {
    'host': '127.0.0.1',
    'user': 'root',
    'password': '',
    'database': 'testdb',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}

def clear_all_rows():
    connection = pymysql.connect(**db_config)
    try:
        with connection.cursor() as cursor:
            # Get all tables
            cursor.execute("SHOW TABLES;")
            tables = [row[f'Tables_in_{db_config["database"]}'] for row in cursor.fetchall()]

            if not tables:
                print("No tables found.")
                return

            # Disable foreign key checks
            cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")

            # Truncate each table
            for table in tables:
                print(f"Clearing table {table}...")
                cursor.execute(f"TRUNCATE TABLE `{table}`;")

            # Re-enable foreign key checks
            cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
        
        connection.commit()
        print("All table rows cleared successfully.")
    finally:
        connection.close()

if __name__ == "__main__":
    clear_all_rows()

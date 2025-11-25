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

def drop_all_app_tables():
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

            # Drop each table
            for table in tables:
                print(f"Dropping table {table}...")
                cursor.execute(f"DROP TABLE `{table}`;")

            # Re-enable foreign key checks
            cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")

        connection.commit()
        print("All tables dropped successfully.")
    finally:
        connection.close()

if __name__ == "__main__":
    drop_all_app_tables()


import time
import mysql.connector
import os

DB_HOST = os.environ.get('DB_HOST', 'localhost')
DB_PORT = int(os.environ.get('DB_PORT', 3306))
DB_USER = os.environ.get('DB_USER', 'customuser')
DB_PASSWORD = os.environ.get('DB_PASSWORD', 'custompass')
DB_NAME = os.environ.get('DB_NAME', 'notes')

retries = 10
for i in range(retries):
    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            port=DB_PORT,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        conn.close()
        print("Successfully connected to MySQL.")
        break
    except Exception as e:
        print(f"Attempt {i+1} failed: {e}")
        time.sleep(5)
else:
    raise RuntimeError("Could not connect to DB after retries.")

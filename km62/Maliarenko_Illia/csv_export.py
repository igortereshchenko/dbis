import cx_Oracle
import csv

username = 'ASIMER'
password = '253161977'
databaseName = 'localhost:1521/XE'
db = cx_Oracle.connect(username, password, databaseName)
cursor = db.cursor()
cursor.execute("""
SELECT TRIM(computer_id) as computer_id
from COMPUTER
""")
for computer_id in cursor:
    with open("computer_" + computer_id[0] + ".csv", "r", newline="") as file:
        reader = csv.reader(file)
        id = next(reader)[1]
        cursor_insert = db.cursor()
        cursor_insert.execute("""
        insert into test_comp(computer_id) values (:computer_id)
        """, computer_id = computer_id[0])
        db.commit()
        next(reader, None)
        next(reader, None)
        cursor_insert.prepare("""
                insert into test_has_hardw(computer_id, hardware_id) values (:computer_id, :hardware_id)
                """)
        rows = []
        for row in reader:
            print(row)
            rows.append([id] + row)
            print(rows)
        cursor_insert.executemany(None, rows)
        cursor_insert.close()
        db.commit()

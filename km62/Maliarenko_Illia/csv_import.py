import cx_Oracle
import csv

username = 'ASIMER'
password = '253161977'
databaseName = 'localhost:1521/XE'
db = cx_Oracle.connect (username,password,databaseName) 
cursor = db.cursor()
cursor.execute("""
SELECT TRIM(computer_id) as computer_id
from COMPUTER
""")
for computer_id in cursor:
    with open("computer_" + computer_id[0] + ".csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["computer_id", computer_id[0]])
        writer.writerow([])
        writer.writerow(["hardware_id"])
        cursor_has_hardware = db.cursor()
        cursor_has_hardware.execute("""
        SELECT hardware_id
        from has_hardware
        where computer_id = :computer_id
        """, computer_id = computer_id[0])
        for hardware_id in cursor_has_hardware:
            writer.writerow(hardware_id)
import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("ihor", "dreyev", "xe")
 
cursor = connection.cursor()
 
cursor.execute("""
SELECT
	TRIM(id) as id,
	TRIM(name) as name,
	TRIM(room_id) as room_id,
	TRIM(hostel_id) as hostel_id,
	TRIM(computer_id) as computer_id
FROM student

""")
 
 
 
with open("result.csv", "w", newline="") as file:
	writer = csv.writer(file)
	for stud_id, stud_name, room_id, hostel_id, computer_id in cursor:
 

 
        	writer.writerow([stud_id, stud_name, room_id, hostel_id, computer_id])

 
        
cursor.close()

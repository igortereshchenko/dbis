import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("ihor", "dreyev", "xe")
 
cursor = connection.cursor()
 
with open("import.csv", newline='') as file:
	reader = csv.reader(file)
	for row in reader:
		insert_query = "insert into student(id, name, room_id, hostel_id, computer_id) values(:stud_id, :stud_name, :room_id, :hostel_id, :computer_id )"

		cursor.execute(insert_query, stud_id = row[0], stud_name = row[1], room_id = row[2], hostel_id = row[3], computer_id = row[4])
cursor.close()
connection.commit() /*save changes in db*/


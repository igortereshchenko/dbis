import csv
import cx_Oracle

connection = cx_Oracle.connect("testuser", "testuser", "localhost:1521/xe")
cursor_university = connection.cursor()

cursor_university.execute("""SELECT UNIVER_ID, UNIVER_NAME, UNIVER_ADDR, UNIVER_LEVEL
FROM UNIVERSITIES""")

for univer_id, univer_name, univer_addr, univer_level in cursor_university:
	with open("university_"+str(univer_id)+".csv", "w", newline="") as file:
		writer = csv.writer(file)
		writer.writerow(["ID", univer_id])
		writer.writerow(["Name", univer_name])
		writer.writerow(["Address", univer_addr])
		writer.writerow(["Level", univer_level])

		cursor_faculty = connection.cursor()
		query = """SELECT FACULTY_ID, FACULTY_NAME, 
			TO_CHAR(FACLULTY_DATE_FOUNDATION, 'yyyy-mm-dd')
		FROM FACULTIES
		WHERE UNIVER_ID_FK = :id"""
		cursor_faculty.execute(query, id = univer_id)
		writer.writerow([])
		writer.writerow(["Faculty id", "Faculty name", "Faculty date of foundation"])
		for faculty_row in cursor_faculty:
			writer.writerow(faculty_row)

cursor_university.close()
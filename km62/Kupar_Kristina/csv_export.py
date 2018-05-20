import csv
 
import cx_Oracle

connection = cx_Oracle.connect("kristina", "kris", "DESKTOP-QE561LC:1521/xe")

cursor_student = connection.cursor()
 
cursor_student.execute("""
SELECT
    TRIM(id) as student_id,
	TRIM(name) as student_name,
    to_char(birthdate, 'mm-dd-yyyy') as birthdate,
    TRIM(course) as course
FROM
    student""")
 
 
 
for student_id, student_name, birthdate, course in cursor_student:
 
    with open("student_"+student_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
		
        writer.writerow(["ID", student_id])
        writer.writerow(["Course", course])
        writer.writerow(["Name", student_name])
        writer.writerow(["Birthdate", birthdate])
		
        cursor_TeacherWork = connection.cursor()
 
        query = """
                    Select 
						work_id as work_id,
                        mark as mark
					FROM 
						studentyieldswork
                    WHERE TRIM(student_id) = :id"""
        cursor_TeacherWork.execute(query, id = student_id)
        writer.writerow([])
        writer.writerow(["Work id", 'Mark'])
        for work_row in cursor_TeacherWork:
            writer.writerow(work_row)
 
cursor_student.close()
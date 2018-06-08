import csv

import cx_Oracle

connection = cx_Oracle.connect("project", "project", "xe")

cursor_student = connection.cursor()

cursor_student.execute("""
select student.student_id
from student""")

for student_row in cursor_student:
    student_id = student_row[0]
    with open("studentComment_"+str(student_id)+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", student_id])
 
        cursor_student = connection.cursor()

        query = """
SELECT "comment_text"
FROM comment
WHERE "student_id" = :id
"""
 
        cursor_student.execute(query, id = student_id)
        writer.writerow([])
        writer.writerow(["comment_text"])

            
cursor_student.close()
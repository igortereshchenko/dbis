import csv

import cx_Oracle

connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")

cursor_student_exercise = connection.cursor()

cursor_student_exercise.execute("""
select student.student_id as stud_id, student.record_book as rec_book, student.student_year as stud_year
from student""")

for stud_id, rec_book, stud_year in cursor_student_exercise:

    with open("student_" + str(stud_id) + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["Student's ID", stud_id])
        writer.writerow(["Student's book", rec_book])
        writer.writerow(["Student's year", stud_year])

        cursor_comment = connection.cursor()

        query = """select exercise_answer.exercise_number, count(comments.comment_id) as com_numb, TO_CHAR(comments.comment_text) as com_text
from exercise join exercise_answer on exercise.exercise_number = exercise_answer.exercise_number
    join student on exercise_answer.student_id = student.STUDENT_ID
    join person on student.PERSON_ID = person.PERSON_ID
    join marker on person.person_id = marker.person_id
    join comments on marker.marker_id = comments.marker_id
group by TO_CHAR(comments.comment_text),student.student_id, exercise_answer.exercise_number
having (student.student_id = :id)"""

        cursor_comment.execute(query, id=stud_id)
        writer.writerow([])
        writer.writerow(["Exercise ID", "Comment_Number", "Commment text"])
        for comm_row in cursor_comment:
            writer.writerow(comm_row)

cursor_student_exercise.close()
import csv

import cx_Oracle

connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")

cursor_student = connection.cursor()

cursor_student.execute("""
select student.student_id as stud_id, student.record_book as rec_book, student.student_year as stud_year
from student""")

for stud_id, rec_book, stud_year in cursor_student:

    with open("student_" + str(stud_id) + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["Student's ID", stud_id])
        writer.writerow(["Student's book", rec_book])
        writer.writerow(["Student's year", stud_year])

        cursor_student_mark = connection.cursor()

        query = """
select DISTINCT TO_CHAR(exercise.exercise_solution) as answer, 
                TO_CHAR(exercise_answer.student_solution) as student_answer,
                max(exercise.exercise_mark) as max_mark,
                exercise_answer.student_solution_mark as student_mark
from student join exercise_answer on student.student_id = exercise_answer.student_id
             join exercise on exercise_answer.exercise_number = exercise.exercise_number
group by student.student_id, 
         TO_CHAR(exercise.exercise_solution), 
         TO_CHAR(exercise_answer.student_solution), 
         exercise_answer.student_solution_mark
having (student.student_id = :id)"""

        cursor_student_mark.execute(query, id=stud_id)
        writer.writerow([])
        for stud_row in cursor_student_mark:
            writer.writerow(stud_row)

cursor_student.close()

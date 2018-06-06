import csv
import cx_Oracle

connection = cx_Oracle.connect("db123", "qwerty", "XE")

cursor_student = connection.cursor()

cursor_student.execute("""
        SELECT
            TRIM(student_id) AS student_id,
            TRIM(student_name) AS student_name,
        FROM
            student""")

for student_id, student_name in cursor_student:
    with open("student_" + student_id + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID", student_id])
        writer.writerow(["Name", student_name])

        cursor_train = connection.cursor()

        query = """
            SELECT
                train_id,
                TO_CHAR(departure_time,'yyyy-mm-dd hh24:mi:ss')
            FROM
                STUDENT
                NATURAL JOIN ticket
            WHERE
                TRIM(student_id) = :id"""

        cursor_train.execute(query, id=student_id)
        writer.writerow([])
        writer.writerow(["Train ID", " Departure Time"])
        for train_row in cursor_train:
            writer.writerow(train_row)

cursor_student.close()
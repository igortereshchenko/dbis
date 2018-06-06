import csv

import cx_Oracle

connection = cx_Oracle.connect("db123", "qwerty", "XE")

filename = "student_1000000001.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    surname = next(reader)[1]

    insert_query = "insert into STUDENT(student_id, student_name) values (:student_id, :student_name)"
    cursor_student = connection.cursor()
    cursor_student.execute(insert_query, student_id=id, student_name=name)
    cursor_student.close()

    connection.commit()

    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO train(train_id, departure_time) VALUES (:train_id, TO_DATE(:departure_time,'yyyy/mm/dd hh24:mi:ss'))"
    cursor_train = connection.cursor()

    cursor_train.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_train.executemany(None, rows)

    cursor_train.close()
    connection.commit()
import csv

import cx_Oracle

connection = cx_Oracle.connect("studentpma", "studentpma", "1.1.1.1/xe")

filename = "student_1001.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    phone = next(reader)[1]

    insert_query = "insert into students(student_id, student_name, student_phone) values (:student_id, :student_name, :student_phone )"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, student_id=id, student_name=name, student_phone=phone)
    cursor_customer.close()

    connection.commit()
    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO computers (computer_serial_number, computer_model, computer_is_working, student_id) VALUES (:computer_serial_number, :computer_model, :computer_is_working :student_id)"
    cursor_order = connection.cursor()

    cursor_order.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_order.executemany(None, rows)

    cursor_order.close()
    connection.commit()
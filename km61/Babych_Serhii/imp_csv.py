import csv
import cx_Oracle

connection = cx_Oracle.connect("system", '10125101', 'DESKTOP-R9NH18C/xe')

filename = "customer_1000000001.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]

    name = next(reader)[1]

    country = next(reader)[1]

    insert_query = "insert into students(student_id, student_name) values (:student_id, :student_name )"

    cursor_customer = connection.cursor()

    cursor_customer.execute(insert_query, student_id=id, student_name=name)

    cursor_customer.close()

    connection.commit()

    next(reader, None)


    next(reader, None)


    insert_query = "INSERT INTO DISTIPLINE (distipline_name, distipline_date, student_id) VALUES (:distipline_name, TO_DATE(:distipline_date,'yyyy-mm-dd'), :student_id)"

    cursor_order = connection.cursor()

    cursor_order.prepare(insert_query)

    rows = []

    for row in reader:
        rows.append(row + [id])

    cursor_order.executemany(None, rows)

    cursor_order.close()

    connection.commit() 

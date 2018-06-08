import csv

import cx_Oracle

connection = cx_Oracle.connect("system", "vfczyz1223", "xe")

filename = "phoneNumbers.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    country = next(reader)[1]

    insert_query = "insert into phoneNumbers (student_IDCardNumber, student_name, country_name) values (:student_IDCardNumber, :student_name, :country_name )"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, student_IDCardNumber=id, student_name=name, country_name=country)
    cursor_customer.close()

    connection.commit()
    changes in db

    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO Countries_has_operators (Operator_name, country_name, operator_country_phoneCode) VALUES (:Operator_name, :country_name, :operator_country_phoneCode)"
    cursor_order = connection.cursor()

    cursor_order.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_order.executemany(None, rows)

    cursor_order.close()
    connection.commit()

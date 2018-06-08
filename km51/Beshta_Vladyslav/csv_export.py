import csv

import cx_Oracle

connection = cx_Oracle.connect("Beshta", "beshta", "xe")

filename = "BOOK_100003.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    author = next(reader)[1]
    year = next(reader)[1]


    insert_query = "insert into book(book_id, book_name, book_author, book_year) values (:book_id, :book_name, :book_author, :book_year )"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, book_id=id, book_name=name, book_author=author, book_year=year)
    cursor_customer.close()

    connection.commit()

    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO book_page (page_id, book_id, page_number) VALUES (:page_id, :book_id, :page_number)"
    cursor_order = connection.cursor()

    cursor_order.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_order.executemany(None, rows)

    cursor_order.close()
    connection.commit()
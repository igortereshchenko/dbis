import csv

import cx_Oracle

connection = cx_Oracle.connect("Katia", "Katia", "xe")

filename = "viewer_1.csv"

with open(filename) as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    surname = next(reader)[1]
    watched = next(reader)[1]

    insert_query = "insert into viewers(viewer_id, viewer_name, viewer_surname, viewer_watched) values (:v_id, :v_name, :v_surname, :v_watched )"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, v_id=id, v_name=name, v_surname=surname, v_watched=watched)
    cursor_customer.close()

    connection.commit()
    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO movies(ticket_number, ticket_hall, ticket_row, ticket_seat) VALUES (:ticket_number, :ticket_hall, :ticket_row, :ticket_seat)"
    cursor_tickets = connection.cursor()

    cursor_tickets.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_tickets.executemany(None, rows)

    cursor_tickets.close()
    connection.commit()  # save changes in db

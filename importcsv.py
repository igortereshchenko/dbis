import csv

import cx_Oracle

connection = cx_Oracle.connect("SYSTEM", "1234", "sas")

filename = "house.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    idh1 = next(reader)[1]
    square_h = next(reader)[1]
    insert_query = "insert into house values (4,Brooklyn)"
    cursor_h = connection.cursor()
    cursor_h.execute(insert_query, idh=idh1, SQ_house=square_h)
    cursor_h.close()

    connection.commit()
    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO square VALUES (Beverli)"
    cursor_sq = connection.cursor()

    cursor_sq.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_sq.executemany(None, rows)

    cursor_sq.close()
    connection.commit()
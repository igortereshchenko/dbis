import csv

import cx_Oracle

connection = cx_Oracle.connect("herasko", "herasko", "xe")

filename = "person_35432555.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    surname = next(reader)[1]


    insert_query = "insert into person(person_id_number, person_name, person_surname) values (:person_id_number, :person_name, :person_surname)"
    cursor_person = connection.cursor()
    cursor_person.execute(insert_query, person_id_number=id, person_name=name, person_surname=surname)
    cursor_person.close()

    connection.commit()

    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO AUTHOR(song_title, song_release_year, song_create, person_id_number) VALUES (:song_title, :song_release_year, :song_create, :person_id_number"
    cursor_author = connection.cursor()

    cursor_author.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_author.executemany(None, rows)

    cursor_author.close()
    connection.commit()
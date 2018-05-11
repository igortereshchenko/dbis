import csv

import cx_Oracle

connection = cx_Oracle.connect("Kharytonchyk", "P12345", "xe")

filename = "human_1000000001.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    surname = next(reader)[1]

    insert_query = "insert into HUMAN(human_identific_number, human_name, human_surname) values (:human_identific_number, :human_name, :human_surname )"
    cursor_human = connection.cursor()
    cursor_human.execute(insert_query, human_identific_number=id, human_name=name, human_surname=surname)
    cursor_human.close()

    connection.commit()

    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO human_sings_song (song_title, song_release_year,  sing_time, human_identific_number) VALUES (:song_title, :song_release_year,  TO_DATE(:sing_time,'yyyy/mm/dd hh24:mi:ss'),:human_identific_number)"
    cursor_song = connection.cursor()

    cursor_song.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_song.executemany(None, rows)

    cursor_song.close()
    connection.commit()
import csv

import cx_Oracle

connection = cx_Oracle.connect("SYSTEM", "florist98", "localhost:1521/xe")

filename = "human_2343444321.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    name = next(reader)[1]
    surname = next(reader)[1]
    birthday = next(reader)[1]

    insert_query = "insert into Human(human_id, human_name, human_surname, human_birthday ) values (:human_id, :human_name, :human_surname, :human_birthday)"
    cursor_human = connection.cursor()
    cursor_human.execute(insert_query, human_id=id, human_name=name, human_surname=surname, human_birthday=birthday)
    cursor_human.close()

    connection.commit()


    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO human_sings_song (song_name, song_id, song_sing_date) VALUES (:song_name, :song_id, TO_DATE(:song_sing_date,'yyyy-mm-dd'),)"
    cursor_human_sings_song = connection.cursor()

    cursor_human_sings_song.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_human_sings_song.executemany(None, rows)

    cursor_human_sings_song.close()
    connection.commit()  # save changes in db
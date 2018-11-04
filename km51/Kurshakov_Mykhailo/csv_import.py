import csv

import cx_Oracle

connection = cx_Oracle.connect("test", "test", "DESKTOP-0Q2I46R/xe")

filename = "MUSIC_TITLE_First composition..csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    title = next(reader)[1]
    genre = next(reader)[1]
    print(title,genre)

    insert_query = """INSERT INTO MUSIC (MUSIC_TITLE,MUSIC_GENRE) VALUES (:title, :genre)"""
    cursor_music = connection.cursor()
    cursor_music.execute(insert_query, title=title, genre=genre)
    cursor_music.close()

    connection.commit()

    next(reader, None)
    next(reader, None)

    insert_query = """INSERT INTO "info about music" (MUSIC_TITLE, MUSIC_AUTHOR2) VALUES (:title, :author)"""
    cursor_music_info = connection.cursor()

    cursor_music_info.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append([title] + row)
    print(rows)
    cursor_music_info.executemany(None, rows)

    cursor_music_info.close()
    connection.commit()
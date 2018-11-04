import csv

import cx_Oracle

connection = cx_Oracle.connect("test", "test", "DESKTOP-0Q2I46R/xe")

cursor_music = connection.cursor()

cursor_music.execute("""
SELECT
    TRIM(MUSIC_TITLE) as MUSIC_TITLE,
    TRIM(MUSIC_GENRE) as MUSIC_GENRE
FROM
    MUSIC""")

for MUSIC_TITLE, MUSIC_GENRE in cursor_music:

    with open("MUSIC_TITLE_" + MUSIC_TITLE + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["TITLE", MUSIC_TITLE])
        writer.writerow(["GENRE", MUSIC_GENRE])

        cursor_music_info = connection.cursor()

        query = """
                    SELECT
                      TRIM(MUSIC_AUTHOR2) as MUSIC_AUTHOR2

                    FROM
                        MUSIC NATURAL JOIN "info about music"
                    WHERE TRIM(MUSIC_TITLE) = :title"""

        cursor_music_info.execute(query, title=MUSIC_TITLE)
        writer.writerow([])
        writer.writerow(["MUSIC_AUTHOR2"])
        for info_row in cursor_music_info:
            writer.writerow(info_row)

cursor_music.close()
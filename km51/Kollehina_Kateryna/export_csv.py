import csv

import cx_Oracle

connection = cx_Oracle.connect("SYSTEM", "florist98", "localhost:1521/xe")
cursor_human = connection.cursor()
cursor_human.execute("""
SELECT
    TRIM(human_id) as human_id,
    TRIM(human_name) as human_name,
    TRIM(human_surname) as human_surname,
    TRIM(human_birthday) as human_birthday
FROM
    human""")

for human_id, human_name, human_surname, human_birthday in cursor_human:
    with open("human_" + human_id + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID", human_id])
        writer.writerow(["Name", human_name])
        writer.writerow(["Surname", human_surname])
        writer.writerow(["Birthday", human_birthday])

        cursor_songs = connection.cursor()
        query = """
                    SELECT
                        Song.SONG_NAME,
                        Song.SONG_ID,
                        human_sings_song.song_sing_date
                    FROM
                       human
                            JOIN human_sings_song  ON human.human_id = human_sings_song.human_id
                            JOIN Song ON human_sings_song.song_id = song.song_id
                    WHERE 
                        human.human_ID = :pid
                """

        cursor_songs.execute(query, pid=human_id)
        writer.writerow([])
        writer.writerow(["song_name", "song_id", "song_sing_date"])

        for song_row in cursor_songs:
            writer.writerow(song_row)

cursor_human.close()
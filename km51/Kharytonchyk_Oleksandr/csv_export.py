import csv
import cx_Oracle

connection = cx_Oracle.connect("Kharytonchyk", "P12345", "xe")

cursor_human = connection.cursor()

cursor_human.execute("""
        SELECT
            TRIM(human_identific_number) AS human_identific_number,
            TRIM(human_name) AS human_name,
            TRIM(human_surname) AS human_surname
        FROM
            human""")

for human_identific_number, human_name, human_surname in cursor_human:
    with open("human_" + human_identific_number + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID", human_identific_number])
        writer.writerow(["Name", human_name])
        writer.writerow(["Surname", human_surname])

        cursor_song = connection.cursor()

        query = """
            SELECT
                song_title,
                song_release_year,
                TO_CHAR(sing_time,'yyyy-mm-dd hh24:mi:ss')
            FROM
                HUMAN
                NATURAL JOIN human_sings_song
            WHERE
                TRIM(human_identific_number) = :id"""

        cursor_song.execute(query, id=human_identific_number)
        writer.writerow([])
        writer.writerow(["Song title", " Song release year", " Sing time"])
        for song_row in cursor_song:
            writer.writerow(song_row)

cursor_human.close()
import csv
import cx_Oracle

connection = cx_Oracle.connect("herasko", "herasko", "xe")

cursor_person = connection.cursor()

cursor_person.execute("""
        SELECT
            TRIM(person_id_number) AS person_id_number,
            TRIM(person_name) AS person_name,
            TRIM(person_surname) AS person_surname
        FROM
            person""")

for person_id_number, person_name, person_surname in cursor_person:
    with open("person_" + person_id_number + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID", person_id_number])
        writer.writerow(["Name", person_name])
        writer.writerow(["Surname", person_surname])

        cursor_author = connection.cursor()

        query = """
            SELECT
                song_title,
                song_release_year,
                song_create
            FROM
                person
                NATURAL JOIN author
            WHERE
                TRIM(person_id_number) = :id"""

        cursor_author.execute(query, id=person_id_number)
        writer.writerow([])
        writer.writerow(["Song title", "Song release year", "Song create"])
        for author_row in cursor_author:
            writer.writerow(author_row)

cursor_person.close()
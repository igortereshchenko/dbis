import cx_Oracle
import csv


connection = cx_Oracle.connect("BlindProrok", "prorok2000", "User-PC/XE")
cursor = connection.cursor()

query = """
    SELECT
        TRIM(Title)
    FROM
        Films
"""

cursor.execute(query)

for film_title in cursor.fetchall():

    film_title = film_title[0]
    with open("Film_" + film_title + '.csv', 'w', newline="") as file:

        writer = csv.writer(file)

        writer.writerow(["Title", film_title])

        query = """
            SELECT
                TRIM(Client_first_name),
                TRIM(Client_last_name),
                TO_CHAR(Seance_date,'yyyy-mm-dd')
            FROM
                Seances
            WHERE
                TRIM(Film_title) = :film_title
        """

        cursor.execute(query, film_title=film_title)

        writer.writerow([])
        writer.writerow(["Client_first_name", "Client_last_name", "Seance_date"])
        for row in cursor.fetchall():
            writer.writerow(row)

cursor.close()
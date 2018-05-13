import cx_Oracle
import csv
import glob

connection = cx_Oracle.connect("BlindProrok", "prorok2000", "User-PC/XE")
cursor = connection.cursor()

appropriate_files = glob.glob("Film_*.csv")

for filename in appropriate_files:

    with open(filename, newline="") as file:
        reader = csv.reader(file)

        title = next(reader)[1]

        insert_query = """
            INSERT INTO Films(Title) VALUES (:title)
        """

        cursor.execute(insert_query, title=title)

        connection.commit()

        next(reader, None)
        next(reader, None)

        insert_query = """
            INSERT INTO Seances(Film_title, Client_first_name, Client_last_name, Seance_date)
                VALUES(:film_title, :client_first_name, :client_last_name, TO_DATE(:seance_date, 'yyyy-mm-dd'))
        """

        cursor.prepare(insert_query)

        rows = []
        for row in reader:
            rows.append([title] + row)

        cursor.executemany(None, rows)

        connection.commit()

cursor.close()
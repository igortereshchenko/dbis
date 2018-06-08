import cx_Oracle
import csv

connection = cx_Oracle.connect("system", "vfczyz1223", "xe")
cursor = connection.cursor()

query = """
    SELECT
        TRIM(student_name)
    FROM
        Students
"""

cursor.execute(query)

for student_name in cursor.fetchall():

    film_title = film_title[0]
    with open("Students_" + student_name + '.csv', 'w', newline="") as file:

        writer = csv.writer(file)

        writer.writerow(["Students", film_title])

        query = """
            SELECT
                TRIM(phoneNumbers.student_name),
                TRIM(phoneNumber),
            FROM
                phoneNumbers
            WHERE
                TRIM(student_name) = :student_name
        """

        cursor.execute(query, student_name=student_name)

        writer.writerow([])
        writer.writerow(["phoneNumbers.student_name", "phoneNumber"])
        for row in cursor.fetchall():
            writer.writerow(row)

cursor.close()

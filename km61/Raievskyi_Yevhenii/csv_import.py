import csv

import cx_Oracle

connection = cx_Oracle.connect("eugen1344", "101918", "xe")

cursor = connection.cursor()

cursor.execute("""
SELECT
    *
FROM
    students""")

with open("numbers.csv", "w", newline="") as file:
    writer = csv.writer(file)

    writer.writerow([i[0] for i in cursor.description])

    for row in cursor.fetchall():
        arr = [str(i).strip() for i in row]
        writer.writerow(arr)

cursor.execute("""
SELECT
    *
FROM
    students_numbers""")

for row in cursor.fetchall():
    with open("students_numbers_" + str(row[1]) + ".csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow([i[0] for i in cursor.description])

        arr = [str(i).strip() for i in row]
        writer.writerow(arr)

cursor.close()
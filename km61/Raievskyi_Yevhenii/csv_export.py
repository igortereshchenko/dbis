import csv

import cx_Oracle

connection = cx_Oracle.connect("eugen1344", "101918", "xe")

filename = "students_numbers_380506666666.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    header_str = ','.join(next(reader))
    data = next(reader)
    register_date = data[-1]
    del(data[-1])

    insert_query = "insert into customers({0}) values ({1}, TO_DATE(:r_date, 'YYYY-MM-DD HH24:MI:SS'))".format(header_str, ','.join(data))

    print(insert_query)
    cursor = connection.cursor()
    cursor.execute(insert_query, r_date=register_date)
    cursor.close()

    connection.commit()


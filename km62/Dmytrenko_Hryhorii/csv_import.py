import csv
import cx_Oracle

connection = cx_Oracle.connect("li341", "sirikbog", "XE")
filename = "human_100015.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    h_id = next(reader)[1]
    name = next(reader)[1]
    sex = next(reader)[1]
    age = next(reader)[1]
    country = next(reader)[1]

    insert_query = "insert into HUMAN(human_id, human_name, human_sex, human_age, human_country) values (:human_id, :human_name, :human_sex, :human_age, :human_country)"
    cursor_human = connection.cursor()
    cursor_human.execute(insert_query, human_id = h_id, human_name = name, human_sex = sex, human_age = age, human_country = country)
    cursor_human.close()
    connection.commit()
    next(reader, None)
    next(reader, None)
    insert_query = "INSERT INTO PHONE_TYPE (phone_id, phone_type_name, human_id) VALUES (:phone_id, :phone_type_name, :human_id)"
    cursor_phone_type = connection.cursor()

    cursor_phone_type.prepare (insert_query)

    rows = []
    for row in reader:
        rows.append(row+[h_id])

    cursor_phone_type.executemany(None, rows)

    cursor_phone_type.close()
    connection.commit() 

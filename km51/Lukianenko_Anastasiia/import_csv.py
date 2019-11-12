import csv
import os
import cx_Oracle

connection = cx_Oracle.connect("code_review", "code_review", "127.0.0.1")

directory = 'C:/Users/vicoo/PycharmProjects/data_bases/'
files = os.listdir(directory)
csv_files = filter(lambda x: x.endswith('.csv'), files)
for filename in csv_files:

    with open(filename, newline='') as file:
        reader = csv.reader(file)

        user_email = next(reader)[1]
        name = next(reader)[1]
        lastname = next(reader)[1]
        user_sex = next(reader)[1]
        print(user_email)

        insert_query = "insert into users(email, user_name, user_lastname, sex)" \
                       "values (:email, :user_name, :user_lastname, :sex )"
        cursor_user = connection.cursor()
        cursor_user.execute(insert_query, email=user_email, user_name=name, user_lastname=lastname, sex=user_sex)
        cursor_user.close()

        connection.commit()

        next(reader, None)
        next(reader, None)

        insert_query = "INSERT INTO user_contacts (email_fk, contact_email, contact_name, date_added)" \
                       "VALUES (:email, :contact_email, :contact_name, TO_DATE(:date_added,'yyyy-mm-dd'))"
        cursor_contacts = connection.cursor()
        cursor_contacts.prepare(insert_query)

        rows = []
        for row in reader:
            rows.append([user_email] + row)

        cursor_contacts.executemany(None, rows)

        cursor_contacts.close()
        connection.commit()  # save changes in db
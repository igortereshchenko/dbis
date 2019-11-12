import csv

import cx_Oracle

connection = cx_Oracle.connect("code_review", "code_review", "127.0.0.1")

cursor_user = connection.cursor()

cursor_user.execute("""
SELECT
    TRIM(email) as email,
    TRIM(user_name) as user_name,
    TRIM(user_lastname) as user_lastname,
    TRIM(sex) as sex
FROM
    users""")

for email, user_name, user_lastname, sex in cursor_user:

    with open("users_" + email + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["EMAIL", email])
        writer.writerow(["User_Name", user_name])
        writer.writerow(["User_LastName", user_lastname])
        writer.writerow(["Sex", sex])

        cursor_contacts = connection.cursor()

        query = """
                    SELECT
                        DISTINCT TRIM(CONTACT_EMAIL),
                        TRIM(CONTACT_NAME),
                        TO_CHAR(DATE_ADDED,'yyyy-mm-dd')

                    FROM
                        USERS NATURAL JOIN USER_CONTACTS
                    WHERE TRIM(EMAIL_FK) = :id"""

        cursor_contacts.execute(query, id=email)
        writer.writerow([])
        writer.writerow(["CONTACT_EMAIL", "CONTACT_NAME", "DATE_ADDED"])
        for contact_row in cursor_contacts:
            writer.writerow(contact_row)

cursor_user.close()
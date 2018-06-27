import csv

import cx_Oracle

connection = cx_Oracle.connect("studentpma", "studentpma", "1.1.1.1/xe")

cursor_customer = connection.cursor()

cursor_customer.execute("""
SELECT
    TRIM(student_id) as student_id,
    TRIM(student_name) as student_name,
    TRIM(student_phone) as student_phone
FROM
    students""")

for student_id, student_name, student_phone in cursor_customer:

    with open("student_" + student_id + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID", student_id])
        writer.writerow(["Name", student_name])
        writer.writerow(["Phone", student_phone])

        cursor_order = connection.cursor()

        query = """
                    SELECT
                        COMPUTER_SERIAL_NUMBER,
                        COMPUTER_MODEL,
                        COMPUTER_IS_WORKING

                    FROM
                        STUDENTS NATURAL JOIN COMPUTERS
                    WHERE TRIM(STUDENT_ID) = :id"""

        cursor_order.execute(query, id=student_id)
        writer.writerow([])
        writer.writerow(["Computer serial number", "Computer model", "Computer state"])
        for computers_row in cursor_order:
            writer.writerow(computers_row)

cursor_customer.close()
import csv
import cx_Oracle

connection = cx_Oracle.connect("system", '10125101', 'DESKTOP-R9NH18C/xe')

cursor_customer = connection.cursor()

cursor_customer.execute("""

SELECT

    TRIM(student_id) as student_id,

    TRIM(student_name) as student_name,



FROM

    students""")

for student_id, student_name in cursor_customer:

    with open("students_" + student_id + ".csv", "w", newline="") as file:

        writer = csv.writer(file)

        writer.writerow(["ID", student_id])

        writer.writerow(["Name", student_name])



        cursor_order = connection.cursor()

        query = """

                    SELECT

                        ORDER_NUM,

                        TO_CHAR(ORDER_DATE,'yyyy-mm-dd')



                    FROM

                        students NATURAL JOIN DISTIPLINE

                    WHERE TRIM(student_ID) = :id"""

        cursor_order.execute(query, id=student_id)

        writer.writerow([])

        writer.writerow(["DISTIPLINE name", "DISTIPLINE date"])

        for order_row in cursor_order:
            writer.writerow(order_row)

cursor_customer.close()

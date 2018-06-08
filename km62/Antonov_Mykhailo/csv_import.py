import csv

import cx_Oracle

connection = cx_Oracle.connect("Antonov", "antonov", "xe")

cursor_customer = connection.cursor()

cursor_customer.execute("""
SELECT
    TRIM(id_ticket) as id_ticket,
    TRIM(id_student) as id_student,
    TRIM(train_ticket) as train_ticket,
FROM
    BOOK""")

for id_ticket, id_student, train_ticket, in cursor_customer:

    with open("TICKET_" + id_ticket + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID_TICKET", id_ticket])
        writer.writerow(["ID_STUDENT", id_student])
        writer.writerow(["TRAIN_TICKET", train_ticket])

        cursor_order = connection.cursor()

        query = """
                    SELECT
                        link_site,
                        name_site
                    FROM
                        site JOIN site_sells_ticket
                    WHERE TRIM(price) > 200
                    """

        cursor_order.execute(query, id=ticket_id)
        writer.writerow([])
        writer.writerow(["link_site", "name_site"])
        for order_row in cursor_order:
            writer.writerow(order_row)

cursor_customer.close()
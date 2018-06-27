import csv
import cx_Oracle

connection = cx_Oracle.connect("SYSTEM", "1234", "sas")

cursor_customer = connection.cursor()

cursor_customer.execute("""
SELECT
    *
FROM
    house""")

for house_id,Sq in cursor_customer:

    with open("customer_" + house_id+ ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["idh", house_id])
        writer.writerow(["SQ_house", Sq])

        cursor_sq = connection.cursor()

        query = """
                    SELECT
                        *

                    FROM
                        square
                        """

        cursor_sq.execute(query, id=SQname)
        writer.writerow([])
        writer.writerow(["Order number"])
        for order_row in cursor_sq:
            writer.writerow(order_row)

cursor_sq.close()
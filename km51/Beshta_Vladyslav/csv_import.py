import csv

import cx_Oracle

connection = cx_Oracle.connect("Beshta", "beshta", "xe")

cursor_customer = connection.cursor()

cursor_customer.execute("""
SELECT
    TRIM(book_id) as book_id,
    TRIM(book_name) as book_name,
    TRIM(book_author) as book_author,
    TRIM(book_year) as book_year
FROM
    BOOK""")

for book_id, book_name, book_author, book_year in cursor_customer:

    with open("BOOK_" + book_id + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID", book_id])
        writer.writerow(["NAME", book_name])
        writer.writerow(["AUTHOR", book_author])
        writer.writerow(["YEAR", book_year])

        cursor_order = connection.cursor()

        query = """
                    SELECT
                        PAGE_ID,
                        PAGE_NUMBER

                    FROM
                        BOOK NATURAL JOIN BOOK_PAGE
                    WHERE TRIM(BOOK_ID) = :id
                    """

        cursor_order.execute(query, id=book_id)
        writer.writerow([])
        writer.writerow(["Page id", "Page number"])
        for order_row in cursor_order:
            writer.writerow(order_row)

cursor_customer.close()
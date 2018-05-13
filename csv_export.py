import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("system", "qwerty", "xe")
 
cursor_mobile = connection.cursor()
 
cursor_mobile.execute("""
SELECT
 *
FROM
    mobile""")
 
 
 
for MOBILE_ID, MOBILE_NAME, MOBILE_CHARACTERISTIC in cursor_mobile:
 
    with open("mobile_"+str(MOBILE_ID)+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", MOBILE_ID])
        writer.writerow(["Name", MOBILE_NAME])
        writer.writerow(["Characteristic", MOBILE_CHARACTERISTIC])
 
        cursor_stores = connection.cursor()
 
        query = """
                    SELECT
                        IN_STOCK,
						SHOP_ID_FK,
						MOBILE_PRICE 
                    FROM
                        MOBILE NATURAL JOIN MOBILE_STORES_IN_SHOP
                    WHERE MOBILE_ID = :id"""
 
        cursor_stores.execute(query, id = MOBILE_ID)
        writer.writerow([])
        writer.writerow(["Stock", "Shop ID", "Price"])
        for order_row in cursor_stores:
            writer.writerow(order_row)
 
cursor_mobile.close()
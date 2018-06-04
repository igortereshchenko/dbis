import csv
 
import cx_Oracle

connection = cx_Oracle.connect("Vlod", "xnjnjnj21", "DESKTOP-CHMS3RO/xe") 
cursor_customer = connection.cursor()
 
cursor_customer.execute("""
SELECT
    TRIM(vend_id) as vend_id,
    TRIM(vend_name) as vend_name,
    TRIM(vend_address) as vend_address,
    TRIM(vend_city) as vend_city,
    TRIM(vend_state) as vend_state,
    TRIM(vend_zip) as vend_zip,
    TRIM(vend_country) as vend_country
FROM
    VENDORS""")
 
 
 
for vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country  in cursor_customer:
 
    with open("vendor_"+vend_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", vend_id])
        writer.writerow(["Name", vend_name])
        writer.writerow(["Address", vend_address])
        writer.writerow(["City", vend_city])
        writer.writerow(["State", vend_state])
        writer.writerow(["ZIP", vend_zip])
        writer.writerow(["Country", vend_country])
 
        cursor_order = connection.cursor()
 
        query = """
                    SELECT
                        TRIM(prod_id) as prod_id,
                        TRIM(PROD_NAME) AS prod_name
 
                    FROM
                       products NATURAL JOIN vendors
                    WHERE TRIM(VEND_ID) = :id"""
 
        cursor_order.execute(query, id = vend_id)
        writer.writerow([])
        writer.writerow(["prod_id", "prod_name"])
        for order_row in cursor_order:
            writer.writerow(order_row)
 
cursor_customer.close()

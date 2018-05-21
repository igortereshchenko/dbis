import csv

import cx_Oracle

connection = cx_Oracle.connect("system", "uuuliakov1607199por", "xe")
 
cursor_shop= connection.cursor()
 
cursor_shop.execute("""
SELECT
    TRIM(shop_id) as shop_id,
    TRIM(shop_name) as shop_name,
    TRIM(shopt_location) as shopt_location
FROM
    shop""")
 
 
 
for shop_id, shop_name, shopt_location in cursor_shop:
 
    with open("shop_"+shop_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", shop_id])
        writer.writerow(["Name", shop_name])
        writer.writerow(["Location", shop_locatione])
 
        cursor_phone = connection.cursor()
 
        query = """
                    SELECT
                        *
                    FROM
                         phone
                    WHERE TRIM(shop_id) = :id"""
 
        cursor_phone.execute(query, id = shop_id)
        writer.writerow([])
        writer.writerow(["phone_id", "phone number", "phone price", "phone_marka"])
        for phone_row in cursor_phone:
            writer.writerow(phone_row)
 
cursor_shop.close()




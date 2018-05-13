import csv
import cx_Oracle

try:
    connection = cx_Oracle.connect("antonacer", "antonace", "xe")
    print("Connecting to DB")
except cx_Oracle.DatabaseError:
    print("Connection failed!")

filename = "brand_FB232.csv"
insert_query = "INSERT INTO PHONEBRAND(BRAND_SERIAL, BRAND_NAME, BRAND_COMPANY, BRAND_RATING) VALUES (:brand_serial, :brand_name, :brand_company, :brand_rating)"
inner_query = "INSERT INTO VENDOR(VEND_ID, VEND_NAME, VEND_RATING, VEND_ADDRESS) VALUES (:vend_id, :vend_name, :vend_rating, :vend_address)"

with open(filename, newline='') as file:
    reader = csv.reader(file)
    b_serial = next(reader)[1]
    b_name = next(reader)[1]
    b_company = next(reader)[1]
    b_rating = next(reader)[1]

    cursor_brand = connection.cursor()
    cursor_brand.execute(insert_query, brand_serial = b_serial, brand_name = b_name, brand_company = b_company, brand_rating = b_rating)
    cursor_brand.close()
    connection.commit()
    next(reader, None)
    next(reader, None)
    cursor_vendor = connection.cursor()
    cursor_vendor.prepare(inner_query)
    rows = []

    for row in reader:
        rows.append(row)

    cursor_vendor.executemany(None, rows)
    cursor_vendor.close()
    connection.commit()

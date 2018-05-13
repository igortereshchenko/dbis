import csv
import cx_Oracle

try:
    connection = cx_Oracle.connect("antonacer", "antonace", "xe")
    print("Connecting to DB")
except cx_Oracle.DatabaseError:
    print("Connection failed!")

inner_query = "SELECT VENDOR.VEND_ID, VENDOR.VEND_NAME, VENDOR.VEND_RATING, VENDOR.VEND_ADDRESS FROM VENDOR JOIN PHONE ON VENDOR.VEND_ID = PHONE.VEND_ID JOIN PHONEBRAND ON PHONE.BRAND_SERIAL = PHONEBRAND.BRAND_SERIAL WHERE PHONEBRAND.BRAND_NAME = :requested_brand"
query = "SELECT BRAND_SERIAL, BRAND_NAME, BRAND_COMPANY, BRAND_RATING FROM PHONEBRAND"
cursor = connection.cursor()
cursor.execute(query)

for brand_serial, brand_name, brand_company, brand_rating in cursor:
    with open("brand_"+brand_serial+".csv", "w", newline="") as file:
        file_recorder = csv.writer(file)

        file_recorder.writerow(["Brand serial", brand_serial])
        file_recorder.writerow(["Brand name", brand_name])
        file_recorder.writerow(["Brand company", brand_company])
        file_recorder.writerow(["Brand rating", brand_rating])

        #print("Brand name: '" + str(brand_name) + "', with rating " + str(brand_rating) + " has vendors:")

        inner_cursor = connection.cursor()
        inner_cursor.execute(inner_query, requested_brand = brand_name)

        file_recorder.writerow([])
        file_recorder.writerow(["Vendor ID", "Vendor name", "Vendor rating", "Vendor address"])
        for element in inner_cursor:
            file_recorder.writerow(element)
cursor.close()
inner_cursor.close()
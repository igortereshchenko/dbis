import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("system", "qwerty", "xe")
 
filename = "mobile_78953152.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    name = next(reader)[1]
    characteristic = next(reader)[1]
 
    insert_query = "insert into mobile(MOBILE_ID, MOBILE_NAME, MOBILE_CHARACTERISTIC) values (:MOBILE_ID, :MOBILE_NAME, :MOBILE_CHARACTERISTIC )"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, MOBILE_ID = id, MOBILE_NAME = name, MOBILE_CHARACTERISTIC = characteristic)
    cursor_customer.close()
 
    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO MOBILE_STORES_IN_SHOP (IN_STOCK, SHOP_ID_FK, MOBILE_ID, MOBILE_PRICE) VALUES (:IN_STOCK, :SHOP_ID_FK, :MOBILE_ID, :MOBILE_PRICE)"
    cursor_stores = connection.cursor()
 
    cursor_stores.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])

 
    cursor_stores.executemany(None, rows)
 
    cursor_stores.close()
    connection.commit() 
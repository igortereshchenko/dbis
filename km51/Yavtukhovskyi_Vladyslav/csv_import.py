import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("Vlod", "xnjnjnj21", "DESKTOP-CHMS3RO/xe") 
 
filename = "vendor_BRE02.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    name = next(reader)[1]
    country = next(reader)[1]
 
    insert_query = "insert into vendors(vend_id, vend_name, vend_address, vend_city,vend_state,vend_zip,vend_country) values (:vend_id, :vend_name, :vend_address, :vend_city, :vend_state,vend_zip, :vend_country)"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, cust_id = id, vend_name = name, vend_address= adress, vend_city = city, vend_state = state, vend_zip=zip1, vend_country= country)
    cursor_customer.close()
 
    connection.commit() /*save changes in db*/
 
    next(reader, None) /*skip empty line*/
    next(reader, None) /*skip order header*/
 
    insert_query = "INSERT INTO products (prod_id, vend_id, prod_name) VALUES (:prod_id, :vend_id, :prod_name)"
    cursor_order = connection.cursor()
 
    cursor_order.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])
 
    cursor_order.executemany(None, rows)
 
    cursor_order.close()
    connection.commit() #save changes in db

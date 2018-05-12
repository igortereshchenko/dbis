import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("ada", "killmyself13", "xe")
 
filename = "room_house.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    name = next(reader)[1]
    country = next(reader)[1]

	
    insert_query = "insert into customers(cust_id, cust_name, cust_country) values (:cust_id, :cust_name, :cust_country )"
    cursor_room = connection.cursor()
    cursor_room.execute(insert_query, cust_id = id, cust_name = name, cust_country = country)
    cursor_room.close()
 
    connection.commit() /*save changes in db*/
 
    next(reader, None) /*skip empty line*/
    next(reader, None) /*skip order header*/
 
    insert_query = "INSERT INTO Room (room_number, owner_name, number_of_inhabit, number_of_sqr_meters) VALUES (:room_number, :owner_name, :number_of_inhabit, :number_of_sqr_meters)"
    cursor_house = connection.cursor()
 
    cursor_house.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])
 
    cursor_house.executemany(None, rows)
 
    cursor_order.close()
    connection.commit() #save changes in db

# coding: utf-8

# In[ ]:

import cx_Oracle
import csv
connection = cx_Oracle.connect("vadimka", "vadimka", "localhost:1521/xe")
filename = "school_48.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    number = next(reader)[1]
    adr = next(reader)[1]
    phone_number = next(reader)[1]
    email = next(reader)[1]
 
    insert_query = "insert into school(school_number, adress, school_phone_number, school_email) values (:school_number, :adress, :school_phone_number, :school_email)"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, school_number = number, adress = adr, school_phone_number = phone_number, school_email = email)
    cursor_customer.close()
 
    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO classroom (class_number, CLASS_VOLUME, CLASS_FLOOR, SCHOOL_NUMBER, ADRESS) VALUES (:classroom_number, :CLASS_VOLUME, :CLASS_FLOOR, :SCHOOL_NUMBER, :ADRESS)"
    cursor_order = connection.cursor()
 
    cursor_order.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[number]+[adr])
 
    cursor_order.executemany(None, rows)
 
    cursor_order.close()
    connection.commit() 


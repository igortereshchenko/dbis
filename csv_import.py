import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("vad1", "25436762", "xe")
 
filename = "WINDOWS_1010.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
  
    vers = next(reader)[1]
    id = next(reader)[1]
    u_name= next(reader)[1]
    u_pass = next(reader)[1]
	
    insert_query = "insert into WINDOWS(VERSION,WINDOWS_C,NAME_USER_C,PASSWORD_USER_C) values (:VERSION,:WINDOWS_C,:NAME_USER_C,:PASSWORD_USER_C)"
    cursor_computer = connection.cursor()
    cursor_computer.execute(insert_query, VERSION = vers, WINDOWS_C = id, NAME_USER_C = u_name, PASSWORD_USER_C = u_pass)
    cursor_computer.close()
 
    connection.commit() 
 
    next(reader, None) 
    next(reader, None) 
 
    insert_query = "INSERT INTO COMPUTER (WINDOWS_C, PROGRAMS_C,VERSION_PROGRAMS_C, ID_C) VALUES (:WINDOWS_C, :PROGRAMS_C, :VERSION_PROGRAMS_C, :ID_C)"
    cursor_order = connection.cursor()
 
    cursor_order.prepare (insert_query)
 
    rows = []
    for row in reader:
	        rows.append([id]+row)
    cursor_order.executemany(None, rows)
 
    cursor_order.close()
    connection.commit() #save changes in db
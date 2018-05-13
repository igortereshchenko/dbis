import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "12345", "localhost:1521/xe")

filename = "classroom_101.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    subject = next(reader)[1]
    space = next(reader)[1]
    floor = next(reader)[1]
 
    insert_query = "insert into classroom(classroom_number, classroom_subject, classroom_space, classroom_floor) values (:classroom_number, :classroom_subject, :classroom_space, :classroom_floor )"
    cursor_classroom = connection.cursor()
    cursor_classroom.execute(insert_query, classroom_number = id, classroom_subject = subject, classroom_space = space, classroom_floor = floor)
    cursor_classroom.close()

    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO desk (desk_zip, desk_color, desk_height, classroom_number_fk_ds) VALUES (:desk_zip, :desk_color, CAST(:desk_height AS NUMBER(5,2)), :classroom_number)"
    cursor_desk = connection.cursor()
    
    cursor_desk.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])

    cursor_desk.executemany(None, rows)
 
    cursor_desk.close()
    connection.commit()

filename = "classroom_202.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    subject = next(reader)[1]
    space = next(reader)[1]
    floor = next(reader)[1]
 
    insert_query = "insert into classroom(classroom_number, classroom_subject, classroom_space, classroom_floor) values (:classroom_number, :classroom_subject, :classroom_space, :classroom_floor )"
    cursor_classroom = connection.cursor()
    cursor_classroom.execute(insert_query, classroom_number = id, classroom_subject = subject, classroom_space = space, classroom_floor = floor)
    cursor_classroom.close()
 
    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO desk (desk_zip, desk_color, desk_height, classroom_number_fk_ds) VALUES (:desk_zip, :desk_color, CAST(:desk_height AS NUMBER(5,2)), :classroom_number)"
    cursor_desk = connection.cursor()
    
    cursor_desk.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id]) 
 
    cursor_desk.executemany(None, rows)
 
    cursor_desk.close()
    connection.commit()

filename = "classroom_303.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    subject = next(reader)[1]
    space = next(reader)[1]
    floor = next(reader)[1]
    
    insert_query = "insert into classroom(classroom_number, classroom_subject, classroom_space, classroom_floor) values (:classroom_number, :classroom_subject, :classroom_space, :classroom_floor )"
    cursor_classroom = connection.cursor()
    cursor_classroom.execute(insert_query, classroom_number = id, classroom_subject = subject, classroom_space = space, classroom_floor = floor)
    cursor_classroom.close()
 
    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO desk (desk_zip, desk_color, desk_height, classroom_number_fk_ds) VALUES (:desk_zip, :desk_color, CAST(:desk_height AS NUMBER(5,2)), :classroom_number)"
    cursor_desk = connection.cursor()
    
    cursor_desk.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])
 
    cursor_desk.executemany(None, rows)
 
    cursor_desk.close()
    connection.commit()

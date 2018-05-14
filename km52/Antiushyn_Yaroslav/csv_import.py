import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "Yaroslav", "localhost:1521/xe")

filename = "classroom_1.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    area = next(reader)[1]
 
    insert_query = "insert into classroom(classroom_id, classroom_area ) values (:classroom_id, :classroom_area )"
    cursor_classroom = connection.cursor()
    cursor_classroom.execute(insert_query, classroom_id = id, classroom_area = area)
    cursor_classroom.close()

    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO desk (desk_id, desk_material, desk_height,  desk_width,  classroom_id_fk_ds) VALUES (:desk_id, :desk_material, CAST(:desk_height AS NUMBER(4,2)),  CAST(:desk_width as NUMBER(4,2)), :classroom_id)"
    cursor_desk = connection.cursor()
    
    cursor_desk.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])

    cursor_desk.executemany(None, rows)
 
    cursor_desk.close()
    connection.commit()

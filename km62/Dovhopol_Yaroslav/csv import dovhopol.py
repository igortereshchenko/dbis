import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("zlatiko_proj", "123456", "xe")
 
filename = "computer_4.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = int(next(reader)[1])
    raiting = next(reader)[1]
    assembly = next(reader)[1]
 
    insert_query = "insert into computer values(:computer_id, :rating, :assembly_id)"
    cursor_comp = connection.cursor()
    cursor_comp.execute(insert_query, computer_id = id, rating = raiting, assembly_id = assembly)
    cursor_comp.close()
 
    connection.commit() #save changes in db
 
    next(reader, None) #skip empty line*/
    next(reader, None) #skip order header*/
 
    insert_query = "insert into Relation_5 values(:computer_id, :program_id)"
    cursor_relation = connection.cursor()
 
    cursor_relation.prepare(insert_query)
 
    rows = []
    for row in reader:
        rows.append(row)
 
    cursor_relation.executemany(None, rows)
 
    cursor_relation.close()
    connection.commit() #save changes in db

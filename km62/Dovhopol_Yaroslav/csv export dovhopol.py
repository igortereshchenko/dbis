import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("zlatiko_proj", "123456", "xe")
 
cursor_comp = connection.cursor()
 
cursor_comp.execute("""
SELECT
    *
FROM computer
""")
 
 
 
for computer_id, raiting, assembly_id in cursor_comp:
 
    with open("computer_"+str(computer_id)+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", computer_id])
        writer.writerow(["Raiting", raiting])
        writer.writerow(["Assembly id", assembly_id])
 
        cursor_relation = connection.cursor()
 
        query = """
SELECT
    *
FROM Relation_5 
WHERE computer_computer_id = :id
"""
 
        cursor_relation.execute(query, id = computer_id)
        writer.writerow([])
        writer.writerow(["Computer_id", "Program id"])
        for row in cursor_relation:
            writer.writerow(row)
 
cursor_comp.close()

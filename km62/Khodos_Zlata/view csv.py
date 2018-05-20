import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("zlatiko_proj", "123456", "xe")
 
cursor_person = connection.cursor()
 
cursor_person.execute("""
Select "personid"
from user_notes
""")
 
 
for person_row in cursor_person:
    person_id = person_row[0]
    with open("personNote_"+str(person_id)+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", person_id])
 
        cursor_marker = connection.cursor()

        query = """
SELECT "notename", "Notes"
FROM user_notes
WHERE "personid" = :id
"""
 
        cursor_marker.execute(query, id = person_id)
        writer.writerow([])
        writer.writerow(["Note name", "Note text"])
        for order_row in cursor_marker:
            writer.writerow(order_row)
            
cursor_person.close()

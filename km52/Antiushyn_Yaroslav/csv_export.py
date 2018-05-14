import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "Yaroslav", "localhost:1521/xe")

cursor_classroom = connection.cursor()
 
cursor_classroom.execute("""
SELECT
    TRIM(classroom_id) as classroom_id,
    TRIM(classroom_area) as classroom_area,
FROM
    Classroom""")
 
for classroom_id, classroom_area in cursor_classroom:
 
    with open("classroom_"+classroom_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["Id", classroom_id])
        writer.writerow(["Area", classroom_area])
 
        cursor_desk = connection.cursor()
 
        query = """
                    SELECT DISTINCT
                        desk_id,
                        desk_material,
                        desk_height,
                        desk_width
                    FROM
                        Classroom NATURAL JOIN Desk
                    Where TRIM(classroom_id_fk_ds) = :id"""
    
        cursor_desk.execute(query, id = classroom_id)
        writer.writerow([])
        writer.writerow(["Desk ID", "Desk Material", "Desk Height", "Desk Width"])
        for desk_row in cursor_desk:
            print(desk_row)
            writer.writerow(desk_row)
 
cursor_classroom.close()

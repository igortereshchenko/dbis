import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "12345", "localhost:1521/xe")

cursor_classroom = connection.cursor()
 
cursor_classroom.execute("""
SELECT
    TRIM(classroom_number) as classroom_number,
    TRIM(classroom_subject) as classroom_subject,
    TRIM(classroom_space) as classroom_space,
    TRIM(classroom_floor) as classroom_floor
FROM
    Classroom""")
 
for classroom_number, classroom_subject, classroom_space, classroom_floor in cursor_classroom:
 
    with open("classroom_"+classroom_number+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["Number", classroom_number])
        writer.writerow(["Subject", classroom_subject])
        writer.writerow(["Space", classroom_space])
        writer.writerow(["Floor", classroom_floor])
 
        cursor_desk = connection.cursor()
 
        query = """
                    SELECT DISTINCT
                        desk_zip,
                        desk_color,
                        TRIM(desk_height)
                    FROM
                        Classroom NATURAL JOIN Desk
                    Where TRIM(classroom_number_fk_ds) = :id"""
    
        cursor_desk.execute(query, id = classroom_number)
        writer.writerow([])
        writer.writerow(["Desk ZIP", "Desk Color", "Desk Height"])
        for desk_row in cursor_desk:
            print(desk_row)
            writer.writerow(desk_row)
 
cursor_classroom.close()

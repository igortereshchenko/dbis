import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "12345", "localhost:1521/xe")

filename = "student_1.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    name = next(reader)[1]
    group = next(reader)[1]
    country  = next(reader)[1]
    email  = next(reader)[1]

    insert_query = "insert into student(student_name, student_group, student_country, student_email ) values ( :student_name, :student_group, :student_country, :student_email )"
    cursor_student = connection.cursor()
    cursor_student.execute(insert_query, student_name = name, student_group = group, student_country = country, student_email = email )
    cursor_student.close()

    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO programminglanguage (language_name, language_developer, language_birth, language_type,  language_id_fk_ds) VALUES (:language_name, :language_developer, :language_birth, :language_type,  :language_id_fk_ds)"
    cursor_programminglanguage = connection.cursor()
    
    cursor_programminglanguage.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])

    cursor_programminglanguage.executemany(None, rows)
 
    cursor_programminglanguage.close()
    connection.commit()

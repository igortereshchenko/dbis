import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "12345", "localhost:1521/xe")

cursor_student = connection.cursor()
 
cursor_student.execute("""
SELECT
    TRIM(student_name) as student_name,
    TRIM(student_group) as student_group,
    TRIM(student_country) as student_country,
    TRIM(student_email) as student_email,
FROM
    student""")
 
for (student_name, student_group, student_country, student_email in cursor_student:
 
    with open("student_"+student_name+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["name", student_name])
        writer.writerow(["group", student_group])
        writer.writerow(["country", student_country])
        writer.writerow(["email", student_email])
 
        cursor_programminglanguage = connection.cursor()
 
        query = """
                    SELECT DISTINCT
                       language_name, є=
                       language_developer, 
                       language_birth, 
                       language_type
                    FROM
                       student NATURAL JOIN programminglanguage
                    Where TRIM(student_name_fk_ds) = :id"""
    
        cursor_programminglanguage.execute(query, name = student_name)
        writer.writerow([])
        writer.writerow(["language_name", "language_developer", "language_birth", "language_type"])
        for programminglanguage_row in cursor_programminglanguage:
            print(programminglanguage_row)
            writer.writerow(programminglanguage_row)

cursor_student.close()

import csv
import os, fnmatch

import cx_Oracle
 
connection = cx_Oracle.connect("kristina", "kris", "DESKTOP-QE561LC:1521/xe")
 
files = fnmatch.filter(os.listdir('.'), '*.csv')

for filename in files:  
    with open(filename, newline='') as file:
        reader = csv.reader(file)
    
        student_id = next(reader)[1]
        course = next(reader)[1]
        name = next(reader)[1]
        birthdate = next(reader)[1]
    
        insert_query = "insert into student(id, name, course, birthdate) values (:id, :name, :course, :birthdate)"
        cursor_student = connection.cursor()
        cursor_student.execute(insert_query, id = student_id, name = name, course = course, birthdate = birthdate)
        cursor_student.close()
    
        connection.commit()
    
        next(reader, None) 
        next(reader, None) 
    
        insert_query = "INSERT INTO studentyieldswork (student_id, work_id, mark) VALUES (:student_id, :work_id, :mark)"
        cursor_YieldsWork = connection.cursor()
    
        cursor_YieldsWork.prepare (insert_query)
    
        rows = []
        for row in reader:
            rows.append([student_id, row[0], row[1]])

        cursor_YieldsWork.executemany(None, rows)
    
        cursor_YieldsWork.close()
        connection.commit()
import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "qwerty13", "localhost:1521/xe")
 
filename = "doctors_1111.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    name = next(reader)[1]
    surname = next(reader)[1]
    spec = next(reader)[1]
    license = next(reader)[1]
 
    insert_query = "insert into doctors(name, surname, specialization, lisence) values (:name, :surname, :specialization, :lisence )"
    cursor_doctor = connection.cursor()
    cursor_doctor.execute(insert_query, name = name, surname = surname, specialization = spec, lisence = license)
    cursor_doctor.close()
 
    connection.commit() 
 
    next(reader, None) 
    next(reader, None)
 
    insert_query = "INSERT INTO patientcard ( card_id, ill_name, doctor_license, patient_name, patient_surname, patient_phone, appointment) VALUES (:card_id, :ill_name, :doctor_license, :patient_name, :patient_surname, :patient_phone, TO_DATE(:appointment,'yyyy-mm-dd'))"
    cursor_patientcard = connection.cursor()
 
    cursor_patientcard.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])
 
    cursor_patientcard.executemany(None, rows)
 
    cursor_patientcard.close()
    connection.commit() 
 
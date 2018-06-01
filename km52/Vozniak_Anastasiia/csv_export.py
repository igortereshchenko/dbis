import pip
import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "qwerty13", "localhost:1521/xe")
 
cursor_doctor = connection.cursor()
 
cursor_doctor.execute("""
SELECT
    TRIM(name) as name,
    TRIM(surname) as surname,
    TRIM(specialization) as spec,
	TRIM(lisence) as license
FROM
    doctors""")
 
 
 
for name, surname, spec, cust_country in cursor_doctor:
 
    with open("doctors_"+license+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["Name", name])
        writer.writerow(["Surname", surname])
        writer.writerow(["Specialization", spec])
        writer.writerow(["License", license])
        cursor_patientcard = connection.cursor()
 
        query = """
                    SELECT
					    card_id,
						ill_name,
						patient_name,
						patient_surname,
						patient_phone,
                        TO_CHAR(appointment,'yyyy-mm-dd')
 
                    FROM
                        doctors NATURAL JOIN patientcard
                    WHERE TRIM(doctor_license) = :license"""
 
        cursor_patientcard.execute(query, id = license)
        writer.writerow([])
        writer.writerow(["Card id", "Ill","Patient name","Patient surname", "Phone", "Appointment"])
        for patientcard_row in cursor_patientcard:
            writer.writerow(patientcard_row)
 
cursor_doctor.close()

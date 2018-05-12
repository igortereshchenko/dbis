import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "f4", "DESKTOP-5UL0E3G/xe")
 
filename = "programist_82.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    prog_id = next(reader)[1]
    first_name = next(reader)[1]
    last_name = next(reader)[1]
    programist_level = next(reader)[1]
     
    insert_query = """
                    insert into Programist(programist_id,
                        programist_first_name,
                        programist_last_name,
                        programist_level)
                    values (:prog_id, :first_name, :last_name, :programist_level)"""
    cursor_programist = connection.cursor()
    cursor_programist.execute(insert_query, prog_id = prog_id,
                              first_name = first_name,
                              last_name = last_name,
                              programist_level = programist_level)
    cursor_programist.close()
 
    connection.commit() #save changes in db/
 
    next(reader, None) #*skip empty line*/
    next(reader, None) #*skip order header*/
 
    insert_query = """INSERT INTO Programist_job
                        (programist_id,
                         programist_job_id,
                         project_name,
                         project_verison,
                         start_working_date,
                         end_working_date)
                        VALUES (
                        :prog_id,
                        :job_id,
                        :project_name,
                        :project_version,
                        TO_DATE(:start_working_date,'yyyy-mm-dd'),
                        TO_DATE(:end_working_date,'yyyy-mm-dd'))"""
    programist_job_cursor = connection.cursor()
 
    programist_job_cursor.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append([prog_id] + row)
    print(rows)
    programist_job_cursor.executemany(None, rows)
 
    programist_job_cursor.close()
    connection.commit() #save changes in db
 

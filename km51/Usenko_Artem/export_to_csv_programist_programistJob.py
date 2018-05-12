import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "f4", "DESKTOP-5UL0E3G/xe")
 
programist_cursor = connection.cursor()
 
programist_cursor.execute("""
SELECT
    programist_id as prog_id,
    TRIM(programist_first_name) as first_nmae,
    TRIM(programist_last_name) as last_name,
    TRIM(programist_level) as prog_level
FROM
    Programist""")
 
for prog_id, first_name, last_name, prog_level in programist_cursor:
 
    with open("programist_"+str(prog_id)+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["Programist_id", prog_id])
        writer.writerow(["programist_first_name", first_name])
        writer.writerow(["programist_last_name",  last_name])
        writer.writerow(["programist_level",prog_level])    
 
        cursor_programist_job = connection.cursor()
        query = """
                    SELECT
                        programist_job_id,
                        project_name,
                        project_verison,
                        TO_CHAR(start_working_date,'yyyy-mm-dd'),
                        TO_CHAR(end_working_date,'yyyy-mm-dd')
                    FROM
                        Programist NATURAL JOIN Programist_job
                    WHERE TRIM(programist_id) = :id"""
 
        cursor_programist_job.execute(query, id = prog_id)
        writer.writerow([])
        writer.writerow(["Programist job id", "Project name", "Project version", "Start working date", "End working date"])
        for job_row in cursor_programist_job:
            writer.writerow(job_row)
        cursor_programist_job.close() 
programist_cursor.close()

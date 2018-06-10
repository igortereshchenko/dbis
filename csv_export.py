import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("vad1", "25436762", "xe")
 
cursor_computer = connection.cursor()
 
cursor_computer.execute("""
SELECT *
FROM WINDOWS""")
 
 
 
for VERSION,WINDOWS_C,NAME_USER_C,PASSWORD_USER_C in cursor_computer:
 
    with open("WINDOWS_"+WINDOWS_C+".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["Version", VERSION])
        writer.writerow(["id of windows", WINDOWS_C])
        writer.writerow(["Name of user", NAME_USER_C])
        writer.writerow(["pass of user", PASSWORD_USER_C])
        
 
        cursor_windows = connection.cursor()
 
        query = """
                    SELECT
                        PROGRAMS_C,VERSION_PROGRAMS_C,ID_C
                    FROM
                        WINDOWS NATURAL JOIN COMPUTER
                    WHERE TRIM(WINDOWS_C) = :id"""
 
        cursor_windows.execute(query, id = WINDOWS_C)
        writer.writerow([])
        writer.writerow([ "Pr name","Pr version","id computer"])
        for orow in cursor_windows:
            writer.writerow(orow)
 
cursor_computer.close()
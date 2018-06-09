import csv
import cx_Oracle

connection = cx_Oracle.connect("Dima", "01200120", "xe")

cursor_windows = connection.cursor()

cursor_windows.execute("""

SELECT *

FROM

    OS_WINDOWS""")

 
for VERSION, DESCRIPTION, LANGUAGE, SYSTE_BIT_RATE in cursor_windows:

 

    with open("OS_WINDOWS_"+VERSION+".csv", "w", newline="") as file:

        writer = csv.writer(file)

 

        writer.writerow(["VERSION", VERSION])
		
        writer.writerow(["DESCRIPTION", DESCRIPTION])
		
        writer.writerow(["LANGUAGE", LANGUAGE])
		
        writer.writerow(["SYST BIT RATE", SYSTE_BIT_RATE])

		
		
		


 

        cursor_soft = connection.cursor()

 

        query = """

                    SELECT

                        TRIM(NAME),

						TO_CHAR(DATA,'yyyy-mm-dd')

                    FROM

                        OS_WINDOWS NATURAL JOIN SOFT_IS_INCTALL

                    WHERE TRIM(VERSION) = :VERSION"""

 

        cursor_soft.execute(query, VERSION = VERSION)

        writer.writerow([])

        writer.writerow(["Soft name", "Date of install"])

        for order_row in cursor_soft:

            writer.writerow(order_row)

 

cursor_windows.close()
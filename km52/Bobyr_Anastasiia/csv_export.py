import cx_Oracle
import csv
 
username = 'Bobyr'
password = 'Bobyr'
databaseName = "localhost:1521/xe"
connection = cx_Oracle.connect (username,password,databaseName)

cursor_illness = connection.cursor()
 
cursor_illness.execute("""select trim(illness_name) as illness_name, trim(illness_recovery_days) as illness_recovery_days, trim(percentage_of_mortality) as percentage_of_mortality 
from illness""")

 
for illness_name, illness_recovery_days, percentage_of_mortality in cursor_illness:
    with open("illness_"+illness_name+".csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["Illness", illness_name])
        writer.writerow(["Recovery days", illness_recovery_days])
        writer.writerow(["% of mortality", percentage_of_mortality])
        cursor_record = connection.cursor()
        query = """ select trim(record_id), trim(card_id), to_char(record_date,'yyyy-mm-dd') from Illness natural join Records where trim(illness_name) = :name"""
        cursor_record.execute(query, name = illness_name)
        writer.writerow([])
        writer.writerow(["Record id", "Card id", "Record date"])
        for order_row in cursor_record:
            writer.writerow(order_row)
 
cursor_illness.close()
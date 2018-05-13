import cx_Oracle
import csv
 
username = 'Bobyr'
password = 'Bobyr'
databaseName = "localhost:1521/xe"
 
connection = cx_Oracle.connect (username,password,databaseName)

filename = "illness_otitis.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    name = next(reader)[1] 
    rec_days = next(reader)[1] 
    perc_mortality = next(reader)[1]
 
    insert_query = "insert into Illness(illness_name, illness_recovery_days, percentage_of_mortality) values (:illness_name, :illness_recovery_days, :percentage_of_mortality )"
    cursor_illness = connection.cursor()
    cursor_illness.execute(insert_query, illness_name = name, illness_recovery_days = rec_days, percentage_of_mortality = perc_mortality)
    cursor_illness.close()
 
    connection.commit() 
 
    next(reader, None) 
    next(reader, None) 
	
    insert_query = "insert into Records (record_id, card_id, record_date, illness_name) values (:record_id, :card_id, to_date(:record_date,'yyyy-mm-dd'), :illness_name)"
    cursor_records = connection.cursor()
    cursor_records.prepare(insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[name])
 
    cursor_records.executemany(None, rows)
 
    cursor_records.close()
    connection.commit() 

import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect ('System','Meizu123',"192.168.0.103")
 
filename = "people_1001.csv"
 
with open(filename, newline='') as file:

    reader = csv.reader(file)
 
    id = next(reader)[1]
    name = next(reader)[1]
    country = next(reader)[1]	
    adress = next(reader)[1]
 
    insert_query = "insert into people(people_id, people_name, people_COUNTRY,STREET_ADRESS) values (:people_id, :people_name, :people_COUNTRY,:STREET_ADRESS)"
    cursor_people = connection.cursor()
    cursor_people.execute(insert_query, people_id = id, people_name = name, people_COUNTRY = country,STREET_ADRESS = adress)
    cursor_people.close()
 
    connection.commit() 
 
    next(reader, None) 
    next(reader, None)
 
    insert_query = "INSERT INTO house (HOUSE_NUMBER, HOUSE_AREA,COUNT_OF_PEOPLE, people_id) VALUES (:HOUSE_NUMBER, :HOUSE_AREA,:COUNT_OF_PEOPLE, :people_id)"
    cursor_house = connection.cursor()
 
    cursor_house.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])
 
    cursor_house.executemany(None, rows)
 
    cursor_house.close()
    connection.commit() 
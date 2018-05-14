import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect ('System','Meizu123',"192.168.0.103")
 
cursor_people = connection.cursor()
 
cursor_people.execute("""
SELECT
    TRIM(people_id) as people_id,
    TRIM(people_name) as people_name,
    TRIM(people_country) as country,
	TRIM(STREET_ADRESS) as adress
FROM
    people""")
 
 
 
for people_id, people_name, country, adress in cursor_people:
 
    with open("people_"+people_id+".csv", "w", newline="") as file:
		
        writer = csv.writer(file)
		
        writer.writerow(["ID", people_id])
        writer.writerow(["Name", people_name])
        writer.writerow(["Country", country])
        writer.writerow(["Adress", adress])
		
		
		
		
 
        cursor_house = connection.cursor()
 
        query = """
                    SELECT
                        HOUSE_NUMBER,
						HOUSE_AREA,
						COUNT_OF_PEOPLE
 
                    FROM
                        people NATURAL JOIN house
                    WHERE TRIM(people_id) = :id"""
 
        cursor_house.execute(query, id = people_id)
        writer.writerow([])
        writer.writerow(["HOUSE_NUMBER", "HOUSE_AREA","COUNT_OF_PEOPLE"])
        for house_row in cursor_house:
            writer.writerow(house_row)
 
cursor_people.close()

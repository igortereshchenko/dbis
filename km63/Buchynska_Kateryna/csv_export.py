import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("ada", "killmyself13", "xe")
 
cursor_room = connection.cursor()
 
cursor_room.execute("""

SELECT 
TRIM(room_number) ,
TRIM(owner_name) ,
TRIM(owner_name) ,
TRIM(number_of_sqr_meters) 
FROM Room 
""")
 
 
 
for room_number, owner_name,number_of_inhabit, number_of_sqr_meters   in cursor_room:

    with open("room_number"+room_number+ ".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["room_number", room_number])
        writer.writerow(["owner_name", owner_name])
        writer.writerow(["owner_name", owner_name])
		writer.writerow(["number_of_sqr_meters", number_of_sqr_meters])
		cursor_house = connection.cursor()
 
        query = """
                    
SELECT 
TRIM(house_street) ,
TRIM(house_number) ,
TRIM(number_of_floors) ,
TRIM(number_of_entrances) 
FROM House

where TRIM(house_number) = : house_num;
"""
 
        cursor_house.execute(query, house_number = house_num)
        writer.writerow([])
        writer.writerow(["Order number", "Order date"])
        for house_row in cursor_room:
            writer.writerow(house_row)
 
cursor_room.close()
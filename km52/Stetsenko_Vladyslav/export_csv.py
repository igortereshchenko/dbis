import cx_Oracle
import csv


connstr = 'username/password@HOST:PORT/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()


# query = """
# 			SELECT 
# 					hotel.hotel__name, tourist.tourist_first_name,
# 					tourist.hotel_id,
# 					tourist.tourist_id
# 			FROM tourist JOIN hotel on tourist.hotel_id=hotel.hotel_id
# 			"""
# cursor.execute(query)
# f = open('toursit_hotel.csv', 'w')
# writer = csv.writer(f)
# writer.writerow(["tourist_id", "tourist_name", "hotel_id", "hotel_name"])

# for hotel_name, tourist_name, hotel_id, tourist_id in cursor:
# 	writer.writerow([tourist_id, tourist_name, hotel_id, hotel_name])
# f.close()


query = "SELECT hotel_name, hotel_id FROM hotels"
cursor.execute(query)
for hotel_name, hotel_id in cursor:
	f = open('hotels_'+ str(hotel_id)+".csv", 'w')
	writer = csv.writer(file)
	writer.writerow(["ID", hotel_id])
	writer.writerow(["Name", hotel_name])
	tourist_query = "SELECT tourist_id, tourist_name FROM tourists WHERE hotel_id={0}".format(hotel_id)
	cursor.execute(tourist_query)
	writer.writerow([])
	writer.writerow(['tourist_id', 'tourist_name'])
	for row in cursor:
		writer.writerow(row)
	f.close()
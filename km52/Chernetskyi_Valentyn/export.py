import cx_Oracle
import csv


connstr = 'username/password@127.0.0.1:1521/1.1.1.1/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()


query = "SELECT hotel_id, name, city, zip FROM hotels"
cursor.execute(query)
for hotel_id, name, city, zip in cursor:
	f = open('hotels)'+ str(hotel_id)+".csv", 'w')
	writer = csv.writer(f)
	writer.writerow(["hotel_id", hotel_id])
	writer.writerow(["name", name])
	writer.writerow(["city", city])
	writer.writerow(["zip", zip])

	notes_query = "SELECT members, room_ir FROM rooms WHERE hotel_id={0}".format(hotel_id)
	cursor.execute(notes_query)
	writer.writerow([])
	writer.writerow(['members', 'room_id'])

	for row in cursor:
		writer.writerow(row)
	f.close()

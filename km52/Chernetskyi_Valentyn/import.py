import cx_Oracle
import csv

filename = "dasdasdsads.csv"

notebooks_insert_query = """
	INSERT INTO hotels(
	  hotel_id,
	  name,
	  city,
	  zip
	)
	VALUES(
	  '{0}',
	  '{1}',
	  {2},
	  '{3}'
	);
"""

notes_insert_query = """
	INSERT INTO rooms
	(
		members,
		room_id
	)
	VALUES(
		'{0}',
		'{1}',
	);
"""

f = open(filename)
hotel_id = csv.reader(f)
name = next(reader)[1]
city = next(reader)[1]
zip = next(reader)[1]
query = notebooks_insert_query.format(hotel_id, name, city, zip)
cursor.execute(query)
next(reader)
next(reader)

for item in reader:
	cursor.execute(notes_insert_query.format(*item))
conn.commit()

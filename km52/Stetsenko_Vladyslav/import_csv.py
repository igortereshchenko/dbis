#import pandas as pd
import cx_Oracle
import csv

filename = ''
connstr = 'username/password@HOST:PORT/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()

insert_hotel_query = """
		INSERT INTO hotels_copy
		(
			hotel_id,
			hotel__name
		)
		VALUES
		(
			{0},
			'{1}'
		)
	"""

insert_tourist_query = """
		INSERT INTO tourists_copy
		(
			tourist_id,
			tourist_first_name,
			hotel_id
		)
		VALUES
		(
			{0},
			'{1}',
			{2}
		)
	"""

# d = pd.read_csv('toursit_hotel.csv', sep=',')
# hotels_inserted = set()
# for item in zip(d.tourist_id, d.tourist_name, d.hotel_id, d.hotel_name):
# 	if not item[2] in hotels_inserted:
# 		hotel_insert = insert_hotel_query.format(item[2], item[3])
# 		cursor.execute(hotel_insert)
# 		conn.commit()
# 		hotels_inserted.add(item[2])
# 	tourist_insert = insert_tourist_query.format(item[0], item[1], item[2])
# 	cursor.execute(tourist_insert)
# 	conn.commit()


f = open(filename)
reader = csv.reader(f)
hotel_id = next(reader)[1]
name = next(reader)[1]
query = insert_hotel_query.format(hotel_id, name)
cursor.execute(query)
next(reader)
next(reader)

for item in reader:
	cursor.execute(insert_tourist_query.format(*item))
conn.commit()

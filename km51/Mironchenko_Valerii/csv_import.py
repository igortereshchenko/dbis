#import pandas as pd
import cx_Oracle
import csv

filename = ''
connstr = 'username/password@HOST:PORT/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()

insert_singer_query = """
		INSERT INTO Singer
		(
			singer_id,
			singer_last_name
		)
		VALUES
		(
			{0},
			'{1}'
		)
	"""

insert_song_query = """
		INSERT INTO Song
		(
			song_id,
			song_name,
			singer_id
		)
		VALUES
		(
			{0},
			'{1}',
			{2}
		)
	"""



f = open(filename)
reader = csv.reader(f)
singer_id = next(reader)[1]
singer_last_name = next(reader)[1]
query = insert_singer_query.format(singer_id, singer_last_name)
cursor.execute(query)
next(reader)
next(reader)

for item in reader:
	cursor.execute(insert_song_query.format(*item))
conn.commit()

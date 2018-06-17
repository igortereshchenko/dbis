import cx_Oracle
import csv


connstr = 'username/password@HOST:PORT/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()


query = "SELECT singer_id, singer_last_name FROM Singer"
cursor.execute(query)
for id, singer_last_name in cursor:
	f = open('singer_'+ str(id)+".csv", 'w')
	writer = csv.writer(file)
	writer.writerow(["ID", id])
	writer.writerow(["Name", singer_last_name])
	song_query = "SELECT song_id, song_name FROM Song WHERE singer_id={0}".format(id)
	cursor.execute(song_query)
	writer.writerow([])
	writer.writerow(['song_id', 'song_name'])
	for row in cursor:
		writer.writerow(row)
	f.close()
import cx_Oracle
import csv


connstr = 'username/password@127.0.0.1:1521/1.1.1.1/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()


query = "SELECT stud_id, notebook_id, subject_id, notebook_name FROM Notebooks"
cursor.execute(query)
for stud_id, notebook_id, subject_id, notebook_name in cursor:
	f = open('notebook_'+ str(notebook_id)+".csv", 'w')
	writer = csv.writer(f)
	writer.writerow(["stud_id", stud_id])
	writer.writerow(["notebook_id", notebook_id])
	writer.writerow(["subject_id", subject_id])
	writer.writerow(["notebook_name", notebook_name])

	notes_query = "SELECT notebook_id, note_num, note_date, page_quantity FROM Notes WHERE notebook_id={0}".format(notebook_id)
	cursor.execute(notes_query)
	writer.writerow([])
	writer.writerow(['notebook_id', 'note_num', "note_date", "page_quantity"])

	for row in cursor:
		writer.writerow(row)
	f.close()






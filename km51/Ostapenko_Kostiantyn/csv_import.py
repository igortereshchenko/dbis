import cx_Oracle
import csv

filename = "dasdasdsads.csv"

notebooks_insert_query = """
	INSERT INTO Notebooks(
	  stud_id,
	  notebook_id,
	  subject_id,
	  notebook_name
	)
	VALUES(
	  '{0}',
	  '{1}',
	  TO_DATE('2018-04-30', 'yyyy-mm-dd'),
	  '{2}'
	);
"""

notes_insert_query = """
	INSERT INTO Notes
	(
		notebook_id,
		note_num,
		note_date,
		page_quantity
	)
	VALUES(
		'{0}',
		'{1}',
		TO_DATE('{2}', 'yyyy-mm-dd'),
		{3}
	);
"""

f = open(filename)
stud_id = csv.reader(f)
notebook_id = next(reader)[1]
subject_id = next(reader)[1]
notebook_name = next(reader)[1]
query = notebooks_insert_query.format(stud_id, notebook_id, subject_id, notebook_name)
cursor.execute(query)
next(reader)
next(reader)

for item in reader:
	cursor.execute(notes_insert_query.format(*item))
conn.commit()
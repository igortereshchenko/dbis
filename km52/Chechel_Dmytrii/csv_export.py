#import pandas as pd
import cx_Oracle
import csv

filename = ''
connstr = 'username/password@HOST:PORT/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()

books_query = """
		INSERT INTO books
		(
			book_id,
			book_name
		)
		VALUES
		(
			{0},
			'{1}'
		)
	"""

pages_query = """
		INSERT INTO pages
		(
			page_id,
			page_text,
			book_id
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
book_id = next(reader)[1]
name = next(reader)[1]
query = books_query.format(book_id, name)
cursor.execute(query)
next(reader)
next(reader)

for item in reader:
	cursor.execute(pages_query.format(*item))
conn.commit()

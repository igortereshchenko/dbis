import cx_Oracle
import csv


connstr = 'username/password@HOST:PORT/xe'
conn = cx_Oracle.connect(connstr)
cursor = conn.cursor()

query = """
        SELECT
                book_name, book_id
        FROM books
        """
cursor.execute(query)
for boon_name, book_id in cursor:
	f = open('books_'+ str(book_id)+".csv", 'w')
	writer = csv.writer(file)
	writer.writerow(["ID", book_id])
	writer.writerow(["Name", book_name])
	query = "SELECT page_id, page_text FROM pages WHERE page_id={0}".format(page_id)
	cursor.execute(query)
	writer.writerow([])
	writer.writerow(['page_id', 'page_text'])
	for row in cursor:
		writer.writerow(row)
	f.close()

import csv
import cx_Oracle

connection = cx_Oracle.connect("test2", "test2", "localhost:1521/xe")
filename = "university_1.csv"
with open(filename, newline='') as file:
	reader = csv.reader(file)
	
	id = next(reader)[1]
	name = next(reader)[1]
	addr = next(reader)[1]
	level = next(reader)[1]

	insert_query = """INSERT INTO UNIVERSITIES (UNIVER_ID, UNIVER_NAME, 
		UNIVER_ADDR, UNIVER_LEVEL) 
	VALUES(:univer_id, :univer_name, :univer_addr, :univer_level)"""

	cursor_university = connection.cursor()
	cursor_university.execute(insert_query, univer_id = id, univer_name = name,
						   univer_addr = addr, univer_level = level)
	cursor_university.close()

	connection.commit()

	next(reader, None)
	next(reader, None)
	
	insert_query = """
	INSERT INTO FACULTIES (FACULTY_ID, UNIVER_ID_FK, FACULTY_NAME, FACLULTY_DATE_FOUNDATION)
	VALUES(:faculty_id, :univer_id, :faculty_name, TO_DATE(:faculty_date, 'yyyy-mm-dd'))
	"""

	cursor_faculty = connection.cursor()
	rows = []
	for row in reader:
		cursor_faculty.execute(insert_query, faculty_id = row[0], univer_id = id, 
						 faculty_name = row[1], faculty_Date = row[2])

	connection.commit()
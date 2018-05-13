import csv
import cx_Oracle

connection = cx_Oracle.connect("Dima", "01200120", "xe")

filename = "OS_WINDOWS_0.0.1.csv"

with open(filename, newline='') as file:

    reader = csv.reader(file)

    VERSION_ = next(reader)[1]

    DESCRIPTION_ = next(reader)[1]

    LANGUAGE_ = next(reader)[1]
	
    SYSTE_BIT_RATE_ = next(reader)[1]

 

    insert_query = "insert into OS_WINDOWS(VERSION, DESCRIPTION, LANGUAGE, SYSTE_BIT_RATE) values (:VERSION, :DESCRIPTION, :LANGUAGE, :SYSTE_BIT_RATE )"

    cursor_windows = connection.cursor()

    cursor_windows.execute(insert_query, VERSION = VERSION_, DESCRIPTION = DESCRIPTION_, LANGUAGE = LANGUAGE_, SYSTE_BIT_RATE = SYSTE_BIT_RATE_)

    cursor_windows.close()

 

    connection.commit() 

 

    next(reader, None) 

    next(reader, None)

 

    insert_query = "INSERT INTO SOFT_IS_INCTALL (NAME, DATA, VERSION) VALUES (:NAME, TO_DATE(:DATA,'yyyy-mm-dd'), :VERSION_)"

    cursor_soft = connection.cursor()

 

    cursor_soft.prepare (insert_query)

 

    rows = []

    for row in reader:

        rows.append(row+[VERSION_])

 

    #cursor_soft.executemany(None, rows)

    print(rows[0])

    cursor_soft.close()

    connection.commit() #save changes in db

 
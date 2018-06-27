import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "12345", "localhost:1521/xe")

filename = "fb_news_1.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    name = next(reader)[1]
    
 
    insert_query = "insert into fb_news(fact_name, new_id) values (:fact_name, :new_id )"
    cursor_fb_news = connection.cursor()
    cursor_fb_news.execute(insert_query, new_id = id, fact_name = name)
    cursor_fb_news.close()

    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO facts (fact_name, fact_date) VALUES (:fact_name, :fact_date), :fact_name)"
    cursor_desk = connection.cursor()
    
    cursor_facts.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])

    cursor_facts.executemany(None, rows)
 
    cursor_facts.close()
    connection.commit()

filename = "fb_news_2.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    name = next(reader)[1]
    
 
    insert_query = "insert into fb_news(fact_name, new_id) values (:fact_name, :new_id )"
    cursor_fb_news = connection.cursor()
    cursor_fb_news.execute(insert_query, new_id = id, fact_name = name)
    cursor_fb_news.close()

    connection.commit()
 
    next(reader, None)
    next(reader, None)
 
    insert_query = "INSERT INTO facts (fact_name, fact_date) VALUES (:fact_name, :fact_date), :fact_name)"
    cursor_desk = connection.cursor()
    
    cursor_facts.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])

    cursor_facts.executemany(None, rows)
 
    cursor_facts.close()
    connection.commit()

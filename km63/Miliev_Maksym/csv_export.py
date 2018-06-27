import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "12345", "localhost:1521/xe")

cursor_fb_news = connection.cursor()
 
cursor_fb_news.execute("""
SELECT
    TRIM(fact_name) as fact_name,
    TRIM(new_id) as new_id
FROM
    fb_news""")
 
for new_id, fact_name in cursor_fb_news:
 
    with open("fb_new_"+new_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["Number", new_id])
        writer.writerow(["Name", fact_name])
 
        cursor_facts = connection.cursor()
 
        query = """
                    SELECT DISTINCT
                        fact_name,
                        fact_date,
                       
                    FROM
                        fb_new NATURAL JOIN facts
                    Where TRIM(new_id_fk_ds) = :id"""
    
        cursor_facts.execute(query, id = new_id)
        writer.writerow([])
        writer.writerow(["New topic", "New date"])
        for facts_row in cursor_facts:
            print(facts_row)
            writer.writerow(facts_row)
 
cursor_facts.close()

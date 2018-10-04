import csv
import cx_Oracle

connection = cx_Oracle.connect("li341", "sirikbog", "XE")

cursor_human = connection.cursor()

cursor_human.execute("""

SELECT
    TRIM(human_id) as human_id,
    TRIM(human_name) as human_name,
    TRIM(human_sex) as human_sex,
    TRIM(human_age) as human_age,
    TRIM(human_country) as human_country
FROM
    HUMAN""")

for human_id, human_name, human_sex, human_age, human_country in cursor_human:
    with open("human_"+human_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["ID", human_id])
        writer.writerow(["Name", human_name])
        writer.writerow(["Sex", human_sex])
        writer.writerow(["Age", human_age])
        writer.writerow(["Country", human_country])
        cursor_phone_type = connection.cursor()

        query = """
                    SELECT PHONE_ID, PHONE_TYPE_NAME, PHONE_ORDER_DATE
                    FROM HUMAN NATURAL JOIN HUMAN_HAS_PHONE NATURAL JOIN PHONE_TYPE 
                    WHERE TRIM(HUMAN_ID) = :id"""
        
        cursor_phone_type.execute(query, id = human_id)
        writer.writerow([])
        writer.writerow(["Phone id", "Phone name", "Phone order date"])
        for phone_row in cursor_phone_type:
            writer.writerow(phone_row)

cursor_human.close()

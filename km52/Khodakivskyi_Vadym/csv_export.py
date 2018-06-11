
# coding: utf-8

# In[3]:


import cx_Oracle
import csv
connection = cx_Oracle.connect("vadimka", "vadimka", "localhost:1521/xe")
cursor_customer = connection.cursor()
 
cursor_customer.execute("""
                SELECT
                    TRIM(SCHOOL_NUMBER) as SCHOOL_NUMBER,
                    trim(ADRESS)as ADRESS,
                    trim(SCHOOL_PHONE_NUMBER) as SCHOOL_PHONE_NUMBER,
                    trim(SCHOOL_EMAIL) as SCHOOL_EMAIL
                FROM school""")

for school_number, adress, school_phone_number, school_email in cursor_customer:
    
     with open("school_"+school_number+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["School number", school_number])
        writer.writerow(["Adress", adress])
        writer.writerow(["School phone number", school_phone_number])
        writer.writerow(["School email", school_email])
 
        cursor_order = connection.cursor()
 
        query = """
                    SELECT
                        CLASS_NUMBER,
                        CLASS_VOLUME,
                        CLASS_FLOOR
                    FROM classroom natural join SCHOOL
                    where TRIM(SCHOOL_NUMBER) = :num"""
 
        cursor_order.execute(query, num = school_number)
        writer.writerow([])
        writer.writerow(["Class number", "Class volume", "Class floor"])
        for order_row in cursor_order:
            writer.writerow(order_row)
cursor_customer.close()


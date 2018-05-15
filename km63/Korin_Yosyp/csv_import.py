import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect ('system/yopes1999@192.168.1.103/xe')
 
filename = "user_10000001.csv"
 
with open(filename, newline='') as file:
    reader = csv.reader(file)
 
    id = next(reader)[1]
    name = next(reader)[1]
    birthday = next(reader)[1]
    phone = next(reader)[1]
    password_ = next(reader)[1]
	
    insert_query = "insert into users(user_id, user_name, user_birthdate, phone, user_password) values (:user_id, :user_name, TO_DATE(:user_birthdate,'dd.mm.yyyy'), :phone, :user_password)"
    cursor_user = connection.cursor()
    cursor_user.execute(insert_query, user_id = id, user_name = name, user_birthdate = birthday, phone = phone, user_password = password_)
    cursor_user.close()
 
    connection.commit() 
 
    next(reader, None) 
    next(reader, None) 
 
    insert_query = "INSERT INTO users_news (news_id_fk, news_heder, news_body, publish, user_name, user_birthdate, phone, user_password, user_id_fk) VALUES (:news_id_fk, :news_heder, :news_body, TO_DATE(:publish,'dd.mm.yyyy'), :user_name, TO_DATE(:user_birthdate,'dd.mm.yyyy'), :phone, :user_password, :user_id)"
    cursor_u_n = connection.cursor()
 
    cursor_u_n.prepare (insert_query)
 
    rows = []
    for row in reader:
        rows.append(row+[id])
 
    cursor_u_n.executemany(None, rows)
 
    cursor_u_n.close()
    connection.commit() 
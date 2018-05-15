import csv

import cx_Oracle

connection = cx_Oracle.connect ('system/yopes1999@192.168.1.103/xe')

cursor_user = connection.cursor()

cursor_user.execute("""
SELECT
    TO_CHAR(user_id) user_id,
    rtrim(user_name) as user_name,
    rtrim(TO_CHAR(user_birthdate,'dd.mm.yyyy')) as birthday,
    phone,
    rtrim(user_password) as password_
FROM
    users""")


for user_id, user_name, birthday, phone, password_ in cursor_user:

    with open("user_"+user_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["ID", user_id])
        writer.writerow(["Name", user_name])
        writer.writerow(["Birthday", birthday])
        writer.writerow(["Phone", phone])
        writer.writerow(["Password", password_])
	
        cursor_u_n = connection.cursor()

        query = """
					SELECT
						news_id_fk,
						news_heder,
						news_body,
						rtrim(TO_CHAR(publish,'dd.mm.yyyy')) publish,
						rtrim(user_name) user_name,
						rtrim(TO_CHAR(user_birthdate,'dd.mm.yyyy')) birthday,
						phone,
						rtrim(user_password) password_
					FROM
						users
						NATURAL JOIN users_news
					WHERE
						user_id =:id"""
 
        cursor_u_n.execute(query, id = user_id)
        writer.writerow([])
        writer.writerow(["ID news", "News heder", "News body", "Publish", "Name", "Birthday", "Phone", "Password"])
        for u_n_row in cursor_u_n:
            writer.writerow(u_n_row)

cursor_user.close()
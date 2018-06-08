import csv
import cx_Oracle

connection = cx_Oracle.connect("akvtn/akvtn@localhost/main")

filename = "citizen_0001.csv"

insert_citizen_query = """INSERT INTO citizens(citizen_id, citizen_first_name, citizen_second_name, citizen_birthday)
                                    VALUES (:identifier,
                                            :first_name,
                                            :second_name,
                                            TO_DATE(:birthday,'yyyy-mm-dd')) """

insert_car_query = """ INSERT INTO cars (car_id, car_brand, car_model, car_price, car_manufacture_year)
                                        VALUES (:car_id, 
                                                :car_brand,
                                                :car_model, 
                                                :car_price,
                                                TO_DATE(:car_manufacture_year,'yyyy-mm-dd')) """

connect_citizen_car_query = """ INSERT INTO citizencar (citizen_id_fk,car_id_fk,purchase_date)
                                        VALUES (:citizen_id,
                                                :car_id,
                                                TO_DATE(:purchase_date,'yyyy-mm-dd'))"""

with open(filename, newline='') as file:
    reader = csv.reader(file)

    citizen_identifier = next(reader)[1]
    citizen_first_name = next(reader)[1]
    citizen_second_name = next(reader)[1]
    citizen_birthday = next(reader)[1]

    citizen_cursor = connection.cursor()
    citizen_cursor.execute(insert_citizen_query,
                           identifier=citizen_identifier,
                           first_name=citizen_first_name,
                           second_name=citizen_second_name,
                           birthday=citizen_birthday[0:10])
    citizen_cursor.close()
    connection.commit()

    next(reader, None)

    insert_car_cursor = connection.cursor()
    for car_row in reader:
        car_id, car_brand, car_model, car_price, car_manufacture_year, car_purchase_date = car_row

        insert_car_cursor.execute(insert_car_query,
                                  car_id=car_id,
                                  car_brand=car_brand,
                                  car_model=car_model,
                                  car_price=car_price,
                                  car_manufacture_year=car_manufacture_year[0:10])

        insert_car_cursor.execute(connect_citizen_car_query,
                                  citizen_id=citizen_identifier,
                                  car_id=car_id,
                                  purchase_date=car_purchase_date[0:10])
        connection.commit()

    insert_car_cursor.close()

connection.close()


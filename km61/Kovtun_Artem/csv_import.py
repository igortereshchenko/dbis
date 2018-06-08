import csv
import cx_Oracle

connection = cx_Oracle.connect("akvtn/akvtn@localhost/main")
cursor = connection.cursor()

cursor.execute("SELECT * FROM citizens")

for identifier, first_name, second_name, birthday in cursor:
    with open("citizen_{0}.csv".format(identifier), "w", newline='') as file:
        writer = csv.writer(file)

        writer.writerow(["Id", identifier])
        writer.writerow(["First_name", first_name])
        writer.writerow(["Second_name", second_name])
        writer.writerow(["Birthday", birthday])
        writer.writerow([])

        car_cursor = connection.cursor()
        query = """SELECT cars.car_id, 
                          cars.car_brand,
                          cars.car_model,
                          cars.car_price,
                          cars.car_manufacture_year,
                          citizencar.purchase_date
                   FROM cars JOIN citizencar ON cars.car_id = citizencar.car_id_fk 
                             JOIN citizens ON citizencar.citizen_id_fk = citizens.citizen_id
                   WHERE citizens.citizen_id = :citizen_id"""

        car_cursor.execute(query, citizen_id=identifier)

        for car_data in car_cursor:
            writer.writerow(car_data)


connection.close()

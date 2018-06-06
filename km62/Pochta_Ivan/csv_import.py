import csv
 
import cx_Oracle

connection = cx_Oracle.connect("system", "newivanpochta17", "xe")
 
cursor_stations = connection.cursor()

filename = "customer_00000.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)
    id_ = next(reader)[1]
    name = next(reader)[1]
    insert_query = "insert into stations(station_id, station_name) values (:station_id, :station_name)"
    cursor_station = connection.cursor()
    cursor_station.execute(insert_query, station_id = int(id_), station_name = str(name))
    cursor_station.close()
    connection.commit()
    next(reader, None)
    next(reader, None)
import csv
 
import cx_Oracle

connection = cx_Oracle.connect("system", "xxx", "xe")
 
cursor_stations = connection.cursor()

cursor_stations.execute("""
SELECT
    TRIM(station_id) as station_id,
    TRIM(station_name) as station_name
FROM
    Stations""")
for station_id, station_name in cursor_stations:
    with open("station_"+station_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["Station ID", station_id])
        writer.writerow(["Station Name", station_name])
        
        cursor_train_has_station = connection.cursor()
        query = """SELECT
                        train_fk
                    FROM
                        STATIONS JOIN TRAIN_HAS_STATION ON STATION_ID=STATION_fk
                    WHERE TRIM(STATION_ID) = :id"""
        cursor_train_has_station.execute(query, id = station_id)
        writer.writerow([])
        writer.writerow(["train"])
        for row in cursor_train_has_station:
            writer.writerow(row)
cursor_stations.close()
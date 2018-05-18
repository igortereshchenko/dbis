import csv
 
import cx_Oracle
 
connection = cx_Oracle.connect("SYSTEM", "florist98", "localhost:1521/xe")
 
cursor_human = connection.cursor()
 
cursor_human.execute("""
SELECT
    TRIM(human_id) as human_id,
    TRIM(human_name) as human_name,
    TRIM(human_surname) as human_surname
FROM
    Human""")
 
 
 
for human_id, human_name, human_surname in cursor_human:
 
    with open("human_"+human_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", human_id])
        writer.writerow(["Name", human_name])
        writer.writerow(["Country", human_surname])
 
        cursor_song = connection.cursor()
 
        query = """
                    SELECT
                        song_name,
                        song_id,
                        TO_CHAR(song_sing_date,'yyyy-mm-dd')
 
                    FROM
                        Human 
                            JOIN human_sings_song ON human.human_id = human_sings_song.human_id
                            JOIN Song ON human_sings_song.song_id = song.song_id
                        
                    WHERE TRIM(human_id) = :id"""
 
        cursor_song.execute(query, id = human_id)
        writer.writerow([])
        writer.writerow(["song_name", "song_id", "song_sing_date"])
        for order_row in cursor_song:
            writer.writerow(song_row)
 
cursor_human.close()
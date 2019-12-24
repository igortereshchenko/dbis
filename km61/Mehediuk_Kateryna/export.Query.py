import csv

import cx_Oracle

connection = cx_Oracle.connect("Katia", "Katia", "xe")

cursor_viewer = connection.cursor()

cursor_viewer.execute("""
SELECT
    TRIM(viewer_id) as viewer_id,
    TRIM(viewer_name) as viewer_name,
    TRIM(viewer_surname) as viewer_surname,
    TRIM(viewer_watched) as viewer_watched
FROM viewers""")

for viewer_id, viewer_name, viewer_surname, viewer_watched in cursor_viewer:

    with open("viewer_" + viewer_id + ".csv", "w") as file:
        writer = csv.writer(file)

        writer.writerow(["Id", viewer_id])
        writer.writerow(["Name", viewer_name])
        writer.writerow(["Surname", viewer_surname])
        writer.writerow(["watched", viewer_watched])

        cursor_tickets = connection.cursor()

        query = """
                    SELECT
                        DISTINCT ticket_number,
                        ticket_hall,
                        ticket_row,
                        ticket_seat
                    FROM
                        tickets NATURAL JOIN 
                        (SELECT ticket_number_fk
                        FROM cinema_session NATURAL JOIN
                        viewers
                        WHERE :id = viewer_id_fk)
                    WHERE ticket_number_fk = ticket_number"""

        cursor_tickets.execute(query, id = viewer_id)
        writer.writerow([])
        writer.writerow(["ticket_number", "ticket_hall", "ticket_row", "ticket_seat"])
        for order_row in cursor_tickets:
            writer.writerow(order_row)

cursor_viewer.close()
import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")
cursor = connection.cursor()
cursor.execute("""
SELECT info.person_id, info.markers_date, count(info.count_date) 
FROM (
SELECT
    person.person_id, min(marker_date) markers_date, count(marker_date) count_date
FROM
    person
    JOIN marker ON person.person_id = marker.person_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                            AND marker.person_id = note_marker.person_id
group by
person.person_id, note_name
)info
group by info.person_id, info.markers_date
""")
count_notes = []
dates_notes = []
user_person_id = int(input('Input user id, please: '))
for row in cursor:
    if row[0] == user_person_id:
        count_notes += [row[2]]
        dates_notes += [row[1]]
        print("Count notes: ",row[2]," Date of the notes: ",row[1])
    else:
        continue
person_dates_notes = go.Scatter(
    x=dates_notes,
    y=count_notes,
    mode='lines+markers'
)
data = [person_dates_notes]
py.plot(data)

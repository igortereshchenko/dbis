import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")
cursor = connection.cursor()
cursor.execute("""
SELECT
    person.person_id,
    COUNT(lecture.lecture_name)
FROM
    person
    JOIN marker ON person.person_id = marker.person_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                        AND marker.person_id = note_marker.person_id
    JOIN material ON marker.material_id = material.material_id
    JOIN lecture ON lecture.material_id = material.material_id
GROUP BY
    person.person_id
""");
people = []
lectures_count = []
for row in cursor:
    print("Person id ",row[0]," and his amount of outlined lectures: ",row[1])
    people += [row[0]]
    lectures_count += [row[1]]
pie = go.Pie(labels=people, values=lectures_count)
py.plot([pie])

import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")
cursor = connection.cursor()
cursor.execute("""
SELECT
    person.person_id AS "person id",
    COUNT(note_marker.note_name) AS "count notes"
FROM
    person
    JOIN marker ON person.person_id = marker.person_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                        AND marker.person_id = note_marker.person_id
GROUP BY
    person.person_id """)
person = []
note = []
for row in cursor:
    print("Person id: ",row[0]," and his amount of notes: ",row[1])
    person += [row[0]]
    note += [row[1]]
data = [go.Bar(
            x=person,
            y=note
    )]
layout = go.Layout(
    title='People and notes',
    xaxis=dict(
        title='People',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Amount of notes',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    )
)
fig = go.Figure(data=data, layout=layout)
person_note =py.plot(fig)

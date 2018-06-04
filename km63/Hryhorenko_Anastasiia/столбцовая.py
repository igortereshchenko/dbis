import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
 
 
connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")
 
cursor = connection.cursor()
 
cursor.execute("""
select exercise_number, exercise_mark
from exercise
 """)
   
exercise_number = []
exercise_mark = []
 
 
for row in cursor:
    print("exercise number: ",row[0]," and mark: ",row[1])
    exercise_number += [row[0]]
    exercise_mark += [row[1]]

data = [go.Bar(
            x=exercise_number,
            y=exercise_mark
    )]
 
layout = go.Layout(
    title='exercises and marks',
    xaxis=dict(
        title='exercise',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Points',
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

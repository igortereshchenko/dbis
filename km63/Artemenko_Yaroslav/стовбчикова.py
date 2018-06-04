import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
 
 
connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")
 
cursor = connection.cursor()
 
cursor.execute("""
select count(comments.comment_id), exercise.exercise_number
from exercise join exercise_answer on exercise.exercise_number = exercise_answer.exercise_number
    join student on exercise_answer.student_id = student.STUDENT_ID
    join person on student.PERSON_ID = person.PERSON_ID
    join marker on person.person_id = marker.person_id
    join comments on marker.marker_id = comments.marker_id
    group by exercise.exercise_number, comments.comment_id
    order by comments.comment_id
 """)
   
exercise = []
count_ex = []
 
 
for row in cursor:
    print("exercise: ",row[0]," and his amount of comments: ",row[1])
    exercise += [row[0]]
    count_ex += [row[1]]

data = [go.Bar(
            x=exercise,
            y=count_ex
    )]
 
layout = go.Layout(
    title='exercises and amount',
    xaxis=dict(
        title='exercise',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Amount of comments',
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

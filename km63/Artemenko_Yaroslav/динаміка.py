import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
 
 
connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")
 
cursor = connection.cursor()
 
cursor.execute("""
select comments.comment_date, count(comments.comment_id), exercise.exercise_number
from exercise join exercise_answer on exercise.exercise_number = exercise_answer.exercise_number
    join student on exercise_answer.student_id = student.STUDENT_ID
    join person on student.PERSON_ID = person.PERSON_ID
    join marker on person.person_id = marker.person_id
    join comments on marker.marker_id = comments.marker_id
    group by exercise.exercise_number, comments.comment_date
    order by comments.comment_date
""")

count_comments = []
datetime = []

ex_id = int(input('Input exercise id, please: '))

for row in cursor:
    if row[2] == ex_id:
        count_comments += [row[1]]
        datetime += [row[0]]
        print("Count comments: ",row[1]," Date of comments: ",row[0])
    else:
        continue
    

comment_dates = go.Scatter(
    x=datetime,
    y=count_comments,
    mode='lines+markers'
)
data = [comment_dates]
py.plot(data)

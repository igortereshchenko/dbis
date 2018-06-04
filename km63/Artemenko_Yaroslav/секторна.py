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
    group by exercise.exercise_number
""");
 
exercise = []
comment_count = []
 
 
for row in cursor:
    print("Person id ",row[0]," and his amount of outlined lectures: ",row[1])
    exercise += [row[0]]
    comment_count += [row[1]]
 
 
 
pie = go.Pie(labels=exercise, values=comment_count)
py.plot([pie])

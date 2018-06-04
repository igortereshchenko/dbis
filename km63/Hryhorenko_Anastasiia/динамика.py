import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
 
 
connection = cx_Oracle.connect("studentpma", "studentpma", "77.47.134.131/xe")
 
cursor = connection.cursor()
 
cursor.execute("""
select student.student_id, exercise_answer.student_solution_mark, exercise_answer.student_solution_time
from student join exercise_answer on student.student_id = exercise_answer.student_id
""")

datetime = []
mark = []

student_id = int(input('Input exercise id, please: '))

for row in cursor:
    if row[0] ==student_id:
        mark += [row[1]]
        datetime += [row[2]]
        print("Date: ",row[1]," Mark ",row[2])
    else:
        continue
    

mark_dates = go.Scatter(
    x=datetime,
    y=mark,
    mode='lines+markers'
)
data = [mark_dates]
py.plot(data)

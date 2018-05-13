import cx_Oracle
import plotly
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard

plotly.tools.set_credentials_file(username='kristinakupar11', api_key='JHWNl2AEEf7PS53AF8ig')
 
connection = cx_Oracle.connect("kristina", "kris", "DESKTOP-QE561LC:1521/xe")
 
cursor = connection.cursor() 

# створення першої візуалізації. Статистика кількості студентів на курсах
 
cursor.execute("""
SELECT
    student.cource,
    COUNT(student.id) as cource_num
FROM Student
    GROUP BY student.course """)
  
course = []
students_count = []
 
 
for row in cursor:
    print("number of course: ",row[0]," and it count: ",row[1])
    cource += [row[0]]
    students_count += [row[1]]
 
 
data = [go.Bar(
            x=cource,
            y=students_count
    )]
 
layout = go.Layout(
    title='count of students and respectively cources',
    xaxis=dict(
        title='Cource',
		dtick=1,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Count of students',
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
 
students_cources = py.plot(fig, filename='count-of-students', auto_open=False)

#----------створення другої візуалізації. Відсотки учнів, яким викладає певний викладач--------

cursor.execute("""
SELECT
    TRIM(TEACHER.NAME),
    NVL(COUNT(DISTINCT STUDENT_ID),0) as COUNT_STUDENT,
	(SELECT COUNT(ID) FROM Student)
 FROM
    studentYieldsWork JOIN WORK
        ON studentYieldsWork.WORK_ID = WORK.WORK_ID
    JOIN TEACHER
        ON Work.TEACHER_ID = TEACHER.ID
    GROUP BY TEACHER.NAME
""");

TEACHER = []
COUNT_STUDENTS = []

for row in cursor:
    print("Teacher: ",row[0]," Count of his/her students: ",row[1], " ", row[2])
    TEACHER += [row[0]]
    COUNT_STUDENTS += [row[1]/row[2]]
	
pie = go.Pie(labels = TEACHER, values = COUNT_STUDENTS)
teachers_students = py.plot([pie], filename = 'teachers_students', auto_open = False)

#----------створення третьої візуалізації. Середні бали на курсах.-----------------

cursor.execute("""
SELECT
    STUDENT.COURCE,
    round(AVG(MARK), 2) as mark
 FROM
    STUDENTYIELDSWORK JOIN STUDENT
		ON STUDENT.ID = STUDENTYIELDSWORK.STUDENT_ID
	group by student.cource
	order by student.cource asc
""");

cource = []
average_mark = []

for row in cursor:
    print("course ",row[0]," average mark: ",row[1])
    cource += [row[0]]
    average_mark += [row[1]]
	
avarage_marks = go.Scatter(
    x = cource,
    y = average_mark,
    mode = 'lines+markers'
)
data = [avarage_marks]
avg_marks = py.plot(data, filename = 'avg_marks', auto_open = False)

#---------------------creating dashboard----------------------------

def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z0-9.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


dashboard_hw = dashboard.Dashboard()

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(students_cources),
    'title': 'count of students at cources'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(teachers_students),
    'title': 'teachers and their students'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(avg_marks),
    'title': 'average marks'
}
 
 
dashboard_hw.insert(box_1)
dashboard_hw.insert(box_2, 'below', 1)
dashboard_hw.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(dashboard_hw, 'Dashboard with Python')
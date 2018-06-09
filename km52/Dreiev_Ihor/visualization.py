import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("ihor", "dreyev", "xe")

cursor = connection.cursor()

""" create plot 1   вивести к-сть студентів в кожному з гуртожитків."""

cursor.execute("""
	SELECT hostel.id, count(1)
	FROM student JOIN hostel ON student.hostel_id = hostel.id
	GROUP BY hostel.id  """)

hostel_id = []
count_students = []

for row in cursor:
    print("In hostel : ", row[0], "students : ", row[1])
    dorm_number += [row[0]]
    count_students += [row[1]]

data = [go.Bar(
    x=hostel_id,
    y=count_students
)]

layout = go.Layout(
    title='Students in hostels there',
    xaxis=dict(
        title='hostel id',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='student`s count',
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

students_in_host_url = py.plot(fig, filename='student in hostel', auto_open=False)

""" create plot 2   гуртожиток та його к-сть студентів/загальну к-стіть студентів у всіх гуртожитках"""

cursor.execute("""
SELECT
    count(1)
FROM
    student
WHERE student.hostel_id IS NOT NULL
""")

total_students=[]

for row in cursor:
    print("Students count in total: ", row[0])
    total_students += [row[0]]


cursor.execute("""
	SELECT hostel.id, count(1)
	FROM student JOIN hostel ON student.hostel_id = hostel.id
	GROUP BY hostel.id  """)

hostel_id = []
part_students = []

for row in cursor:
    print("In hostel : ", row[0], "students : ", row[1])
    dorm_number += [row[0]]
    part_students += [row[1]/total_students[0]]

pie = go.Pie(labels=hostel, values=part_students)
part_stud_in_host = py.plot([pie], filename='part_stud', auto_open=False)


"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

students_in_host_id = fileId_from_url(students_in_host_url)
part_stud_in_host_id = fileId_from_url(part_stud_in_host)


box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': students_in_host_id,
    'title': 'student in dorm'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': part_stud_in_host_id,
    'title': 'dorm-room-count'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)


py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')

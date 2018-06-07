import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')

connection = cx_Oracle.connect("my_test", "pass", "localhost:1521/xe")
cursor = connection.cursor()

""" create plot 1  Вивести студентів та кількісь їх телефонів"""

cursor.execute("""
select students.stud_id,
    students.stud_name,
    count(STUDENTS_HAS_PHONES.phone_id_fk)
from STUDENTS left join STUDENTS_HAS_PHONES on students.stud_id = STUDENTS_HAS_PHONES.STUD_ID_FK 
GROUP BY students.stud_id, students.stud_name
 """)

student = []
phone_count = []

for row in cursor:
    print("Student_name: ", row[1], " count_of_his_phones: ", row[2])
    student += [str(row[0]) + " "+row[1]]
    phone_count += [row[2]]

data = [go.Bar(
    x=student,
    y=phone_count
)]

layout = go.Layout(
    title='Students and count_of_phones',
    xaxis=dict(
        title='Student',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='count_of_phones',
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

students_phones_sum = py.plot(fig, filename='students_phones_sum', auto_open='false')

""" create plot 2   Вивести операторів %телефоів що мають даний оператор відносно інших телефонів"""

cursor.execute("""
select operators.oper_name,
    operators.oper_code,
    count(phone_number.phone_id_fk)
from operators left join phone_number on phone_number.oper_code_fk = operators.OPER_CODE 
GROUP BY operators.oper_name,
    operators.oper_code
""");

operators = []
number_of_phones = []

for row in cursor:
    print("Operator name ", row[1] + " code: (" + row[0], ") number_of_phones: ", row[2])
    operators += [row[1] + " " + row[0]]
    number_of_phones += [row[2]]

pie = go.Pie(labels=operators, values=number_of_phones)
operators_phones_sum = py.plot([pie], filename='operators_phones_sum', auto_open='false')

""" create plot 3   Вивести динаміку кількості телефонів  у студентів по датах"""

cursor.execute("""
select 
    STUDENTS_HAS_PHONES.STUD_PHONE_DATE,
    count(students.stud_id)
from STUDENTS join STUDENTS_HAS_PHONES on students.stud_id = STUDENTS_HAS_PHONES.STUD_ID_FK 
GROUP BY  STUDENTS_HAS_PHONES.STUD_PHONE_DATE
order by STUDENTS_HAS_PHONES.STUD_PHONE_DATE
""")
dates = []
number_of_student_has_phone = []

for row in cursor:
    print("Date ", row[0], " number_of_student_has_phone: ", row[1])
    dates += [row[0]]
    number_of_student_has_phone += [row[1]]

order_date_prices = go.Scatter(
    x=dates,
    y=number_of_student_has_phone,
    mode='lines+markers'
)
data = [order_date_prices]

number_student_has_phone_on_date= py.plot(data, filename='number_student_has_phone_on_date', auto_open='false')

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

students_phones_sum_id = fileId_from_url(students_phones_sum)
operators_phones_sum_id = fileId_from_url(operators_phones_sum)
number_student_has_phone_on_date_id = fileId_from_url(number_student_has_phone_on_date)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': students_phones_sum_id,
    'title': 'students_phones_sum'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': operators_phones_sum_id,
    'title': 'operators_phones_sum'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': number_student_has_phone_on_date_id,
    'title': 'number_student_has_phone_on_date_'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')
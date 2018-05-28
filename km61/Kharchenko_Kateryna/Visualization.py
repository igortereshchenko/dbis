import plotly
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import plotly.dashboard_objs as dashboard
import re

def fileid_from_url(url):
    """Return fileId from a url."""
    raw_fileid = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileid.replace('/', ':')

connection = cx_Oracle.connect("system", "vfczyz1223", "xe")
cursor = connection.cursor()

""" create #1 """
cursor.execute("""
SELECT
    Students.student_name||' '||Students.student_IDCardNumber as student,
    COUNT(phoneNumbers.phoneNumber)as phoneNumber_amount
FROM
    phoneNumbers INNER JOIN Students ON phoneNumbers.student_IDCardNumber = Students.student_IDCardNumber 
    and phoneNumbers.student_name = Students.student_name
GROUP BY
    Students.student_name,
    Students.student_IDCardNumber
""")
students = []
numbers = []
for row in cursor.fetchall():
    students.append(row[0])
    numbers.append(row[1])

data = [go.Bar(
    x = students,
    y = numbers
)]

layout = go.Layout(
    title='Students and numbers count',
    xaxis=dict(
        title='Students',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Numbers count',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    )
)

fig = go.Figure(data=data)
numbers_per_person_url = py.plot(fig, filename = 'numbers-per-person.html')

""" create #2 """
cursor.execute("""
SELECT
    Operators.Operator_name as operators,
    COUNT(phoneNumbers.phoneNumber)as phoneNumber_amount
FROM
    phoneNumbers INNER JOIN Operators ON phoneNumbers.Operator_name = Operators.Operator_name 
GROUP BY
    Operators.Operator_name
""")
operators = []
phone_n_count = []
for row in cursor.fetchall():
    operators.append(row[0]);
    phone_n_count.append(row[1]);

pie = go.Pie(labels=operators, values=phone_n_count)
operator_proportion_url = py.plot([pie], filename = 'operator-proportion.html')

my_dboard = dashboard.Dashboard()

numbers_per_person_id = fileId_from_url(numbers_per_person_url)
operator_proportion_id = fileId_from_url(operator_proportion_url)


box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': numbers_per_person_id,
    'title': 'Number count per person'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': operator_proportion_id,
    'title': 'Operator market proportion'
}

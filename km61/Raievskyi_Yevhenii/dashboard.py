import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard

def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("eugen1344", "101918", "xe")

cursor = connection.cursor()

""" create plot 1 """

cursor.execute("""
SELECT
    students.stud_name,
    COUNT(students_numbers.phone_number_fk)
FROM
    students_numbers INNER JOIN students ON students_numbers.stud_id_fk = students.stud_id
GROUP BY
    students_numbers.stud_id_fk,
    students.stud_name,
    students.stud_id
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

""" create plot 2  """

cursor.execute("""
SELECT
    operators.operator_name,
    COUNT(students_numbers.phone_number_fk)
FROM
    operators INNER JOIN students_numbers ON operators.operator_id = students_numbers.operator_id_fk
GROUP BY
    students_numbers.operator_id_fk, operators.operator_name
""");

operators = []
phone_n_count = []

for row in cursor.fetchall():
    operators.append(row[0]);
    phone_n_count.append(row[1]);

pie = go.Pie(labels=operators, values=phone_n_count)
operator_proportion_url = py.plot([pie], filename = 'operator-proportion.html')

""" create plot 3  """

cursor.execute("""
SELECT
    students_numbers.register_date, COUNT(students_numbers.phone_number_fk)
FROM
    students_numbers
GROUP BY
    students_numbers.register_date
ORDER BY
    students_numbers.register_date
""")

register_dates = []
numbers_count = []

for row in cursor:
    register_dates.append(row[0])
    numbers_count.append(row[1])

data = go.Scatter(
    x=register_dates,
    y=numbers_count,
    mode='lines+markers'
)

phone_registration_url = py.plot([data], filename = 'phone-registration-dates.html')

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

numbers_per_person_id = fileId_from_url(numbers_per_person_url)
operator_proportion_id = fileId_from_url(operator_proportion_url)
phone_registration_id = fileId_from_url(phone_registration_url)

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

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': phone_registration_id,
    'title': 'Phone registration dates'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'Finally made those graphs. I hate myself')
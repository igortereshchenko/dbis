import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')

connection = cx_Oracle.connect("db123", "qwerty", "XE")
cursor = connection.cursor()

""" create plot 1   """

cursor.execute("""
SELECT STUDENT.student_id||'<br>'||trim(STUDENT.student_name)
    FROM HUMAN JOIN (
        SELECT STUDENT.student_id, sum(TICKET.price) as order_sum
            FROM STUDENT join TICKET 
            ON STUDENT.student_id = TICKET.student_id
        GROUP BY STUDENT.student_id) report ON report.student_id = STUDENT.student_id  """)

students = []
ticket_sum = []

for row in cursor:
    print("Student: ",row[0]," and his ordered tickets sum: ",row[1])
    studentss += [row[0]]
    ticket_sum += [row[1]]

data = [go.Bar(
            x=students,
            y=ticket_sum
    )]

layout = go.Layout(
    title='Students and total price of ordered tickets',
    xaxis=dict(
        title='Students',
        titlefont=dict(
            family='Courier New, monospace',
            size=10,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Sum of ordered tickets',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=10,
            color='#7f7f7f'
        )
    )
)

fig = go.Figure(data=data, layout=layout)
students_ordered_tickets_sum = py.plot(fig, filename='students_ordered_tickets_sum')

""" create plot 2   """

cursor.execute("""


SELECT trim(STUDENT.student_id),trim((STUDENT.student_name), NVL(report.order_sum, 0) ticket_sum 
    FROM STUDENT JOIN (
    SELECT STUDENT.student_id, sum(TICKET.price) as order_sum
        FROM STUDENT left join STUDENT_HAS_TICKET 
            ON STUDENT.student_id = TICKET.ticket_id
            left join TICKET 
            ON STUDENT_HAS_TICKET.ticket_id = TICKET.ticket_id
        GROUP BY STUDENT.student_id) report ON report.student_id = STUDENT.student_id

""")

studentss_2 = []
ticket_sum_2 = []

for row in cursor:
    print("Student name ",row[1]+" id: ("+row[0],") and his ordered tickets sum: ",row[2])
    students_2 += [row[1]+" "+row[0]]
    ticket_sum_2 += [row[2]]

pie_diagram = go.Pie(labels=stdents_2, values=ticket_sum_2)
students_tickets_sum = py.plot([pie_diagram], filename='students_tickets_sum_percents')

""" create plot 3   """

cursor.execute("""
SELECT STUDENT_HAS_TICKET.order_date, sum(TICKET.price) as order_sum
        FROM STUDENT left join STUDENT_HAS_TICKET
            ON STUDENT.student_id = STUDENT_HAS_TICKET.student_id
            left join TICKET 
            ON STUDENT_HAS_TICKET.phone_id = TICKET.ticket_id
        WHERE STUDENT_HAS_TICKET.order_date is not null
        GROUP BY STUDENT_HAS_TICKET.order_date
        ORDER BY STUDENT_HAS_TICKET.order_date
""")

order_dates = []
ticket_price = []

for row in cursor:
    print("Date ",row[0]," ordered ticket price: ",row[1])
    order_dates += [row[0]]
    ticket_price += [row[1]]


ordered_ticket_date_prices = go.Scatter(
    x=order_dates,
    y=ticket_price,
    mode='lines+markers'
)

data = [ordered_ticket_date_prices]
ordered_ticket_date_prices_url=py.plot(data, filename='ordered ticket prices by date')

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

students_ordered_tickets_sum_id = fileId_from_url(students_ordered_tickets_sum)
students_tickets_sum_id = fileId_from_url(students_tickets_sum)
ordered_ticket_prices_by_date_id = fileId_from_url(ordered_ticket_date_prices_url)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': students_ordered_tickets_sum_id,
    'title': 'Students and total price of ordered tickets'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': students_tickets_sum_id,
    'title': 'Students and total price of ordered tickets'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': ordered_ticket_prices_by_date_id,
    'title': 'Ordered ticket price by date'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'Dashboard by Sedinin KM-62')
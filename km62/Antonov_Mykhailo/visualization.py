import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')

connection = cx_Oracle.connect("Antonov", "antonov", "XE")
cursor = connection.cursor()

""" create plot 1   """

cursor.execute("""
SELECT student.student_id||'<br>'||trim(student.name_student) student, NVL(report.price_sum, 0) id_ticket 
    FROM student JOIN (
        SELECT student.student_id, sum(site_sells_ticket.price) as price_sum
            FROM student left join site_sells_ticket 
            ON student.student_id = site_sells_ticket.student_id
            LEFT JOIN site 
            ON site_sells_ticket.id_ticket = ticket.id_ticket
        GROUP BY student.student_id) report ON report.student_id = student_id.student_id  """)

persons = []
phone_sum = []

for row in cursor:
    print("Student: ",row[0]," and his ticket price sum: ",row[1])
    persons += [row[0]]
    phone_sum += [row[1]]

data = [go.Bar(
            x=persons,
            y=phone_sum
    )]

layout = go.Layout(
    title='Student and total price of ordered tickets',
    xaxis=dict(
        title='Persons',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Sum of ordered tickets',
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
persons_ordered_phones_sum = py.plot(fig, filename='persons_ordered_ticket_sum')

""" create plot 2   """

cursor.execute("""
SELECT trim(HUMAN.human_id),trim(HUMAN.human_name), NVL(report.order_sum, 0) phone_sum 
    FROM HUMAN JOIN (
    SELECT HUMAN.human_id, sum(PHONE_TYPE.price) as order_sum
        FROM HUMAN left join HUMAN_HAS_PHONE 
            ON HUMAN.human_id = HUMAN_HAS_PHONE.human_id
            left join PHONE_TYPE 
            ON HUMAN_HAS_PHONE.phone_id = PHONE_TYPE.phone_id
        GROUP BY HUMAN.human_id) report ON report.human_id = HUMAN.human_id 
""")

persons_2 = []
phone_sum_2 = []

for row in cursor:
    print("Student name ",row[1]+" id: ("+row[0],") and his ordered tickets sum: ",row[2])
    persons_2 += [row[1]+" "+row[0]]
    phone_sum_2 += [row[2]]

pie_diagram = go.Pie(labels=persons_2, values=phone_sum_2)
persons_phones_sum = py.plot([pie_diagram], filename='persons_phones_sum_percents')

""" create plot 3   """

cursor.execute("""
SELECT site_sells_ticket.link site, sum(ticket.price) as ticket_sum
        FROM student LEFT JOIN ticket 
            ON student.student_id = ticket.student_id
            left join ticket 
            ON student.student_id = ticket.student_id
        WHERE ticket.train_ticket is not null
        GROUP BY ticket.train_ticket
        ORDER BY ticket.train_ticket
""")

order_dates = []
phone_price = []

for row in cursor:
    print("Date ",row[0]," ordered ticket price: ",row[1])
    order_dates += [row[0]]
    phone_price += [row[1]]


ordered_phone_date_prices = go.Scatter(
    x=order_dates,
    y=phone_price,
    mode='lines+markers'
)

data = [ordered_phone_date_prices]
ordered_phone_date_prices_url=py.plot(data, filename='ordered ticket prices by trains')

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

persons_ordered_phones_sum_id = fileId_from_url(persons_ordered_phones_sum)
persons_phones_sum_id = fileId_from_url(persons_phones_sum)
ordered_phone_prices_by_date_id = fileId_from_url(ordered_phone_date_prices_url)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': persons_ordered_phones_sum_id,
    'title': 'Persons and total price of ordered phones'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': persons_phones_sum_id,
    'title': 'Persons and total price of ordered phones'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': ordered_phone_prices_by_date_id,
    'title': 'Ordered phones price by date'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'Dashboard by Antonov')
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')

connection = cx_Oracle.connect("li341", "sirikbog", "XE")
cursor = connection.cursor()

""" create plot 1   """

cursor.execute("""
SELECT HUMAN.human_id||'<br>'||trim(HUMAN.human_name) HUMAN, NVL(report.order_sum, 0) phone_sum 
    FROM HUMAN JOIN (
        SELECT HUMAN.human_id, sum(PHONE_TYPE.price) as order_sum
            FROM HUMAN left join HUMAN_HAS_PHONE 
            ON HUMAN.human_id = HUMAN_HAS_PHONE.human_id
            left join PHONE_TYPE 
            ON HUMAN_HAS_PHONE.phone_id = PHONE_TYPE.phone_id
        GROUP BY HUMAN.human_id) report ON report.human_id = HUMAN.human_id  """)

persons = []
phone_sum = []

for row in cursor:
    print("Person: ",row[0]," and his ordered phones sum: ",row[1])
    persons += [row[0]]
    phone_sum += [row[1]]

data = [go.Bar(
            x=persons,
            y=phone_sum
    )]

layout = go.Layout(
    title='Persons and total price of ordered phones',
    xaxis=dict(
        title='Persons',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Sum of ordered phones',
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
persons_ordered_phones_sum = py.plot(fig, filename='persons_ordered_phones_sum')

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
    print("Person name ",row[1]+" id: ("+row[0],") and his ordered phones sum: ",row[2])
    persons_2 += [row[1]+" "+row[0]]
    phone_sum_2 += [row[2]]

pie_diagram = go.Pie(labels=persons_2, values=phone_sum_2)
persons_phones_sum = py.plot([pie_diagram], filename='persons_phones_sum_percents')

""" create plot 3   """

cursor.execute("""
SELECT human_has_phone.order_date, sum(PHONE_TYPE.price) as order_sum
        FROM HUMAN left join HUMAN_HAS_PHONE 
            ON HUMAN.human_id = HUMAN_HAS_PHONE.human_id
            left join PHONE_TYPE 
            ON HUMAN_HAS_PHONE.phone_id = PHONE_TYPE.phone_id
        WHERE human_has_phone.order_date is not null
        GROUP BY human_has_phone.order_date
        ORDER BY human_has_phone.order_date
""")

order_dates = []
phone_price = []

for row in cursor:
    print("Date ",row[0]," ordered phone price: ",row[1])
    order_dates += [row[0]]
    phone_price += [row[1]]


ordered_phone_date_prices = go.Scatter(
    x=order_dates,
    y=phone_price,
    mode='lines+markers'
)

data = [ordered_phone_date_prices]
ordered_phone_date_prices_url=py.plot(data, filename='ordered phone prices by date')

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

py.dashboard_ops.upload(my_dboard, 'Dashboard by Dmytrenko KM-62')
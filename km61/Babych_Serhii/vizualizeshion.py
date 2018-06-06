
""" Вивести покупців та загальну суму усіх їх замовлень. Покупець – число. """
import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
connection = cx_Oracle.connect("system", '10125101', 'DESKTOP-R9NH18C/xe')
cursor = connection.cursor()
cursor.execute("""select * from buyers""")
customers = []
orders_sum = []
for row in cursor:
    print("Customer name: ", row[0], " and his order sum: ", row[1])
    customers += [row[0] + row[1]]
    orders_sum += [row[1]]
    data = [go.Bar(
        x=customers,
        y=orders_sum
    )]
    layout = go.Layout(
        title='Customers and Orders sum',
        xaxis=dict(
            title='Customers',
            titlefont=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        ),
        yaxis=dict(
            title='Orders sum',
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
    customers_orders_sum = py.plot(fig)
    
""" Вивести постачальника та % його продажів відносно решти постачальників. Постачальник – його відсоток серед решти """

cursor = connection.cursor()
cursor.execute("""select buyer_id, order_amount from buyers""")

data = []
for i in cursor:
    data.append(i)

sum = 0
for i in range(len(data)):
    sum += data[i][1]

user_list = []
for i in data:
    user_list.append(i[0])
user_list = set(user_list)

customers = []
orders_sum = []

for i in user_list:
    sum2 = 0
    for j in range(i, len(data) - 1):
        if data[i][0] == data[j][0]:
            sum2 += data[j][1]
    customers += [i]
    orders_sum += [sum2 / sum * 100]

pie = go.Pie(labels=vendors, values=products_sum)

py.plot([pie])

"""Вивести динаміку покупок по датах"""

cursor = connection.cursor()
cursor.execute("""select buyer_id, order_amount from buyers""")

data = []
for i in cursor:
    data.append(i)

sum = 0
for i in range(len(data)):
    sum += data[i][1]

user_list = []
for i in data:
    user_list.append(i[0])
user_list = set(user_list)

customers = []
orders_sum = []

for i in user_list:
    sum2 = 0
    for j in range(i, len(data) - 1):
        if data[i][0] == data[j][0]:
            sum2 += data[j][1]
    customers += [i]
    orders_sum += [sum2 / sum * 100]

order_date_prices = go.Scatter(
    x=customers,
    y=orders_sum,
    mode='lines+markers'
)
data = [order_date_prices]
py.plot(data)

import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard

username = 'god'
password = 'qwerty'
databaseName = "xe"

connection = cx_Oracle.connect(username, password, databaseName)

def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')

cursor = connection.cursor()

cursor.execute("""
select student_name as name , count(student_name) as count
from student
group  by student_name """)

name = []
count = []

for row in cursor:
    print("Name: ", row[0], " and count of this name: ", row[1])
    name += [row[0]]
    count += [row[1]]

    data = [go.Bar(
        x=name,
        y=count
    )]

    layout = go.Layout(
        title='Names and cont of this names',
        xaxis=dict(
            title='Name',
            titlefont=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        ),
        yaxis=dict(
            title='Count',
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

customers_orders_sum = py.plot(fig, filename='customers-orders-sum.html')
print ('1')
#-------------------------------------
cursor.execute("""
select
    operator_fk as operator,
    count(student_fk) as student
from direct
group by operator_fk
""");

operator= []
student = []
print(operator)
print(student)
for row in cursor:
    operator += [row[0]]
    student += [row[1]]


pie = go.Pie(labels=operator, values=student)
vendors_products_sum = py.plot([pie], filename='vendors-products-sum.html')
print ('2')
#--------------------------------------
cursor.execute("""
select
    operator_fk as operator,
    count(student_fk) as student
from direct
group by operator_fk
""");
operator = []
student = []

for row in cursor:
    print("Date ", row[0], " sum: ", row[1])
    operator += [row[0]]
    student += [row[1]]

operator123 = go.Scatter(
    x=operator,
    y=student,
    mode='lines+markers'
)
data = [operator123]
order_date_prices_url=py.plot(data, filename='order_date_prices_url.html')


print('3')
#-----------------------------------------
my_dboard = dashboard.Dashboard()
print(customers_orders_sum, vendors_products_sum, order_date_prices_url )
customers_orders_sum_id = ('customers_orders_sum.html')
vendors_products_sum_id = ('vendors_products_sum.html')
order_date_prices_id = ('order_date_prices_url.html')

print( customers_orders_sum_id, vendors_products_sum_id, order_date_prices_id )

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': customers_orders_sum_id,
    'title': 'Customers and Orders sum'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': vendors_products_sum_id,
    'title': 'Customers and Orders sum'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': order_date_prices_id,
    'title': 'Orders price by date'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
print( customers_orders_sum_id, vendors_products_sum_id, order_date_prices_id)
print('sdfsf')
py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')

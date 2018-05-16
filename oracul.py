import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("SYSTEM", "1234", "sas")

cursor = connection.cursor()

""" create plot 1   назва району та кількість домів у ньому"""

cursor.execute("""
    SELECT 
   square.SQname,count(house.idh)
    FROM square left join house
    on square.SQname=house.SQ_house
                            GROUP BY square.SQname 
        on report.CUST_ID = CUSTOMERS.CUST_ID   """)

square = []
house_count = []

for row in cursor:
    print("square: ", row[0], " and his count house: ", row[1])
    square += [row[0]]
    house_count += [row[1]]

data = [go.Bar(
    x=square,
    y=house_count
)]

layout = go.Layout(
    title='SQuare and house',
    xaxis=dict(
        title='square',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='count house',
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

customers_orders_sum = py.plot(fig, filename='customers-orders-sum')

""" create plot 2   будинок та кількість квартир у ньому"""

cursor.execute("""
SELECT
    idh,count_of_flats
    from house
""");

house = []
numflats = []

for row in cursor:
    print(" ", row[1] + " id: (" + row[0], ")")
    house += [row[0]]
    numflats += [row[1]]

pie = go.Pie(labels=house, values=numflats)
vendors_products_sum = py.plot([pie], filename='vendors-products-sum')

""" create plot 3  house&humans"""

cursor.execute("""
SELECT
    house.idh,count(humans.name)
 FROM
    house LEFT JOIN humans
        ON house.idh = humans.humanhouse
    GROUP BY house.idh
""")
househum = []
human = []

for row in cursor:
    print("Date ", row[0], " sum: ", row[1])
    househum += [row[0]]
    human += [row[1]]

order_date_prices = go.Scatter(
    x=househum,
    y=human,
    mode='lines+markers'
)
data = [order_date_prices]
order_date_prices_url = py.plot(data, filename='Orders price by date')

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

customers_orders_sum_id = fileId_from_url(customers_orders_sum)
vendors_products_sum_id = fileId_from_url(vendors_products_sum)
order_date_prices_id = fileId_from_url(order_date_prices_url)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': customers_orders_sum_id,
    'title': 'square and house'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': vendors_products_sum_id,
    'title': 'house and flat'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': order_date_prices_id,
    'title': 'house and human'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')


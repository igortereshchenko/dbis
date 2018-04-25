

import cx_Oracle

import plotly.plotly as py

import plotly.graph_objs as go

import re

import plotly.dashboard_objs as dashboard

 

 

def fileId_from_url(url):

    """Return fileId from a url."""

    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]

    return raw_fileId.replace('/', ':')
 

username = 'Dima'

password = '01200120'

databaseName = "xe"

 
 
connection = cx_Oracle.connect (username,password,databaseName)
 
cursor = connection.cursor()

 

 

 

""" create plot 1   Вивести кількість прогрпам які вствновлені на різних версіях."""

 

cursor.execute("""

select 
    SOFT_IS_INCTALL.version,
    count(SOFT_IS_INCTALL.version)
    
    from SOFT_IS_INCTALL
    
    GROUP BY  SOFT_IS_INCTALL.version
    ORDER BY  count(SOFT_IS_INCTALL.version) DESC """)

 

version = []

programs = []

 

 

for row in cursor:

    print("Version: ",row[0]," count of instal program ",row[1])

    version += [row[0]]

    programs += [row[1]]

 

 

data = [go.Bar(

            x=version,

            y=programs

    )]

 

layout = go.Layout(

    title='Version and program sum',

    xaxis=dict(

        title='Version',

        titlefont=dict(

            family='Courier New, monospace',

            size=18,

            color='#7f7f7f'

        )

    ),

    yaxis=dict(

        title='Program sum',

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

 

 

""" create plot 2   Вивести модель компьютера та кылькуість пам'яті що він використовує."""

 

 

cursor.execute("""

select 
    СOMPUTER.MODEL,
    SUM(SOFTWARE.MEMORY)
    
    from
    СOMPUTER
    JOIN OS_IS_INSTULL ON СOMPUTER.MAC_ADDRESS = OS_IS_INSTULL.MAC_ADDRESS
    JOIN OS_WINDOWS ON OS_IS_INSTULL.VERSION = OS_WINDOWS.VERSION
    JOIN SOFT_IS_INCTALL ON SOFT_IS_INCTALL.VERSION = OS_WINDOWS.VERSION
    JOIN SOFTWARE ON (SOFT_IS_INCTALL.NAME = SOFTWARE.NAME and SOFT_IS_INCTALL.DATA = SOFTWARE.DATA)
    
    
    GROUP BY  СOMPUTER.MODEL

""");

 

MODEL = []

MEMORY_sum = []

 

 

for row in cursor:

    print("Сomputer model ",row[0]," and memory sum: ",row[1])

    MODEL += [row[0]]

    MEMORY_sum += [row[1]]

 

 

 

pie = go.Pie(labels=MODEL, values=MEMORY_sum)

vendors_products_sum = py.plot([pie], filename='vendors-products-sum')

 

 

""" create plot 3   Вивести модель що вікоритовує данну мову"""

 

 

cursor.execute("""

select 
    COUNT(СOMPUTER.MODEL),
    OS_WINDOWS.LANGUAGE
    
    from
    СOMPUTER
    JOIN OS_IS_INSTULL ON СOMPUTER.MAC_ADDRESS = OS_IS_INSTULL.MAC_ADDRESS
    JOIN OS_WINDOWS ON OS_IS_INSTULL.VERSION = OS_WINDOWS.VERSION

    
    GROUP BY OS_WINDOWS.LANGUAGE

""")

LANGUAGE = []

MODEL = []

 

 

for row in cursor:

    print("LANGUAGE ",row[1]," is set on ", row[0]," models",)

    LANGUAGE += [row[1]]

    MODEL += [row[0]]

 

 

order_date_prices = go.Scatter(

    x=LANGUAGE,

    y=MODEL,

    mode='lines+markers'

)

data = [order_date_prices]

order_date_prices_url=py.plot(data, filename='Orders price by date')

 

 

"""--------CREATE DASHBOARD------------------ """

    

 

my_dboard = dashboard.Dashboard()

 

customers_orders_sum_id = fileId_from_url(customers_orders_sum)

vendors_products_sum_id = fileId_from_url(vendors_products_sum)

order_date_prices_id = fileId_from_url(order_date_prices_url)

 

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

 

 

 

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')

 

 
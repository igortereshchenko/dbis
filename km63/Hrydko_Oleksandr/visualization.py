import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
 
username = 'System'
password = 'Meizu123'
databaseName = "192.168.0.103"
 
connection = cx_Oracle.connect (username,password,databaseName)
 
cursor = connection.cursor()
 
 
 
""" create plot 1   Вивести кількість будинків на вулиці."""
 
cursor.execute("""
select trim(STREET_NAME) ||','|| trim(STREET_NUMBER) as street,count_of_house as count_
from STREET_ON_HOUSE """)
 
street = []
count_= []
 
for row in cursor:
   print("street: ",row[0]," and his count_of_house: ",row[1])
   street += [row[0]]
   count_ += [row[1]]
   


 
 
data = [go.Bar(
            x=street,
            y=count_
    )]
 
layout = go.Layout(
    title='street and count_of_house',
    xaxis=dict(
        title='street',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='count_of_house',
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
 
count_of_house_ = py.plot(fig, filename='count-of-house-')
 
 
""" create plot 2   Вивести кількість будинків та % його співвідношення на вулицях."""
 
 
cursor.execute("""
select trim(STREET_NAME) ||','|| trim(STREET_NUMBER) as street,
count_of_house as count_
from STREET_ON_HOUSE
""");
 
street = []
count_of_house = []
 
 
for row in cursor:
    print("street ",row[0],") and his count_of_house: ",row[1])
    street += [row[0]]
    count_of_house += [row[1]]
 
 
 
pie = go.Pie(labels=street, values=count_of_house)
house_on_street_= py.plot([pie], filename='house-on-street-')
 
 
""" create plot 3   Вивести динаміку заснування вулиць по датах"""
 
 
cursor.execute("""
select street.STREET_DATA as data_,street_on_house.count_of_house as count_
from street left join STREET_ON_HOUSE 
on street.street_name = STREET_ON_HOUSE.STREET_NAME
""")
data_ = []
count_ = []
 
 
for row in cursor:
    print("Date ",row[0]," sum: ",row[1])
    data_+= [row[0]]
    count_ += [row[1]]
 
 
order_date_prices = go.Scatter(
    x=data_,
    y=count_,
    mode='lines+markers'
)
data = [order_date_prices]
date_foundation=py.plot(data, filename='date-foundation')
 
 
"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
count_of_house_id = fileId_from_url(count_of_house_)
house_on_street_id = fileId_from_url(house_on_street_)
date_foundation_id = fileId_from_url(date_foundation)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': count_of_house_id ,
    'title': 'count_of_house_'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': house_on_street_id,
    'title': 'count_of_house_'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': date_foundation_id,
    'title': 'date_foundation'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')

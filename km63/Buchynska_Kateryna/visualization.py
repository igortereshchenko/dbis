

""""------1. Для кожної квартири вивести імя власника і середній метраж на людину-----------------------------------"""
""""----2. Вивести відсотковий розподіл кількості будинків по районах-------------------------------------"""
""""---------3.Вивести скільки людей живе в кожному районі.--------------------------------"""
""""-------------------Створення dashboard----------------------"""

 
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
 
connection = cx_Oracle.connect("", "killmyself13", "xe")
 
cursor = connection.cursor()
 
 
 
""" create plot 1  Для кожної квартири вивести імя власника і середній метраж на людину  """
 
cursor.execute("""
  sELECT  owner_name , room_number, ROUND(number_of_inhabit/number_of_sqr_meters) 
from Room """)
 
 
people = []
avg_square = []
 
 
for row in cursor:
    print("People: ",row[0]," andavarage meter per person:",row[1])
    people += [row[0]]
    avg_square += [row[1]]
 
 
data = [go.Bar(
            x=people,
            y=avg_square
    )]
 
layout = go.Layout(
    title='People and avg meter per person',
    xaxis=dict(
        title='People',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='avg square per person ',
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
 
avg_square_per_person = py.plot(fig, filename='avg-square-per-person')
 
 
""" create plot 2. Вивести відсотковий розподіл кількості будинків по районах-----."""
 
 
cursor.execute("""

SELECT 
	TRIM(Room_in_house.street_area), 
	COUNT(House.house_number)
FROM Room_in_house join  House on House.house_number=Room_in_house.house_number 
GROUP BY Room_in_house.street_area
""");
 
street_area = []
count_of_houses = []
 
 
for row in cursor:
    print("Vendor name ",row[1]+" id: ("+row[0],") and his products sum: ",row[2])
    street_area += [row[1]+" "+row[0]]
    count_of_houses += [row[2]]
 
 
 
pie = go.Pie(labels=street_area, values=count_of_houses)
street_area_count_of_houses = py.plot([pie], filename='street-area-count-of-houses')
 
 
""" create plot 3.Вивести скільки людей живе в кожному районі."""
 
 
cursor.execute("""
SELECT 
	Room_in_house.street_area, 
	SUM(Room.number_of_inhabit)
FROM 
	Room join Room_in_house on Room.room_number = Room_in_house.room_number
GROUP BY  
	Room_in_house.street_area 
""")
area_names = []
people_count = []
 
 
for row in cursor:
    print("Date ",row[0]," sum: ",row[1])
    area_names += [row[0]]
    people_count += [row[1]]
 
 
order_date_prices = go.Scatter(
    x=area_names,
    y=people_count,
    mode='lines+markers'
)
data = [order_date_prices]
area_names_people_count=py.plot(data, filename='area-names-people-count')
 
 
"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
avg_square_per_person_id = fileId_from_url(avg_square_per_person)
street_area_count_of_houses_id = fileId_from_url(street_area_count_of_houses)
area_names_people_count_id = fileId_from_url(area_names_people_count)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': avg_square_per_person_id,
    'title': 'Customers and Orders sum'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': street_area_count_of_houses_id,
    'title': 'Customers and Orders sum'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': area_names_people_count_id,
    'title': 'Orders price by date'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')
 
 
 

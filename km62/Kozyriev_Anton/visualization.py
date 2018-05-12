import cx_Oracle
import plotly
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')

plotly.tools.set_config_file(world_readable=True, sharing='public')

try:
    connection = cx_Oracle.connect("antonacer", "antonace", "xe")
    print("Connecting to DB")
except cx_Oracle.DatabaseError:
    print("Connection failed!")
 
cursor = connection.cursor()

''' Task 1: Create bar chart 'Count of vendors for each brand' '''

cursor.execute("SELECT PHONEBRAND.BRAND_NAME, VENDOR_COUNT.VCOUNT FROM PHONEBRAND JOIN (SELECT BRAND_SERIAL, COUNT(DISTINCT VEND_ID) AS VCOUNT FROM PHONE GROUP BY BRAND_SERIAL) VENDOR_COUNT ON PHONEBRAND.BRAND_SERIAL = VENDOR_COUNT.BRAND_SERIAL ORDER BY VENDOR_COUNT.VCOUNT DESC")

brand_names = []
count_of_vendors = []

print("Create bar chart: 'Count of vendors for each brand'\n")
 
for row in cursor:
    print("Brand name '" + str(row[0]) + "', has " + str(row[1]) + " vendor(s).")
    brand_names.append(str(row[0]))
    count_of_vendors.append(int(row[1]))

data = [go.Bar(x=brand_names, y=count_of_vendors, name='Count of vendors')]
 
layout = go.Layout(
    barmode='group',
    title='Brand name and count of vendors',
    xaxis=dict(
        title='Brand name',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Count of vendors',
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
brand_count_of_vendors = py.plot(fig, filename='brand_name_and_count_of_vendors', auto_open=True)
print(brand_count_of_vendors) 
print("Create pie chart: 'Total sells for each brand'\n") 
cursor.execute("SELECT PHONEBRAND.BRAND_NAME, PHONEBRAND.BRAND_COMPANY, SUMTABLE.TOTAL FROM PHONEBRAND JOIN (SELECT BRAND_SERIAL, SUM(PHONE.PHONE_PRICE) as TOTAL FROM PHONE GROUP BY BRAND_SERIAL ORDER BY TOTAL ASC) SUMTABLE ON PHONEBRAND.BRAND_SERIAL = SUMTABLE.BRAND_SERIAL");
 
phonebrands = []
products_sum = []
 
 
for row in cursor:
    print("Company '" + str(row[1]) + "' has brand name '" + str(row[0]) + "', which sold products on " + str(row[2]) + "$.")
    phonebrands.append(str(row[1]) + ", "+ str(row[0]))
    products_sum.append(float(row[2]))

pie = go.Pie(labels=phonebrands, values=products_sum)
phone_brand_sum = py.plot([pie], filename='phone_brand_total_sum')
print(phone_brand_sum)
print("Create scatter: 'MIN, AVG, MAX rating of vendors for each brand'\n")

cursor.execute("SELECT PHONEBRAND.BRAND_NAME, ESTIMATES.minimal_rating, ESTIMATES.average_rating, ESTIMATES.maximal_rating FROM PHONEBRAND JOIN (SELECT PHONE.BRAND_SERIAL, MIN(VENDOR.VEND_RATING) as minimal_rating, AVG(VENDOR.VEND_RATING) as average_rating, MAX(VENDOR.VEND_RATING) as maximal_rating FROM PHONE JOIN VENDOR ON PHONE.VEND_ID = VENDOR.VEND_ID GROUP BY PHONE.BRAND_SERIAL) ESTIMATES ON PHONEBRAND.BRAND_SERIAL = ESTIMATES.BRAND_SERIAL")

brand_names = []
minimal_rating = []
average_rating = []
maximal_rating = []
 
 
for row in cursor:
    print("Brand '" + str(row[0]) + "' has vendors with minimal rating: " + str(row[1]) + ", average rating: " + str(row[2]) + ", maximal rating: " + str(row[3]))
    brand_names.append(str(row[0]))
    minimal_rating.append(int(row[1]))
    average_rating.append(float(row[2]))
    maximal_rating.append(int(row[3]))
 
 
brand_minimal_rating = go.Scatter(
    x=brand_names,
    y=minimal_rating,
    mode='lines+markers',
    name = 'Minimal Rating'
)

brand_average_rating = go.Scatter(
    x=brand_names,
    y=average_rating,
    mode='lines+markers',
    name = 'Average Rating'
)

brand_maximal_rating = go.Scatter(
    x=brand_names,
    y=maximal_rating,
    mode='lines+markers',
    name = 'Maximal Rating'
)

data = [brand_minimal_rating, brand_average_rating, brand_maximal_rating]
brand_rating_url = py.plot(data, filename='Vendor rating for each brand')
 
 
"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
brand_count_of_vendors_id = fileId_from_url(brand_count_of_vendors)
phone_brand_sum_id = fileId_from_url(phone_brand_sum)
brand_rating_id = fileId_from_url(brand_rating_url)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': brand_count_of_vendors_id,
    'title': 'Count of vendors for each brand'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': phone_brand_sum_id,
    'title': 'Total sells for each brand'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': brand_rating_id,
    'title': 'MIN, AVG, MAX rating of vendors for each brand'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')

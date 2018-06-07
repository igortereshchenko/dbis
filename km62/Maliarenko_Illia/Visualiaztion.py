import cx_Oracle
import re
import plotly.plotly as py
import plotly.dashboard_objs as dashboard
import plotly.graph_objs as go
from pprint import pprint

username = 'ASIMER'
password = '253161977'
databaseName = 'localhost:1521/XE'
db = cx_Oracle.connect (username,password,databaseName) 
cursor = db.cursor()

def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    print (raw_fileId)
    return raw_fileId.replace('/', ':')

"""------------BAR CHART------------------------------"""
"""Вивести кількість встановлених деталей для кожного компьютера"""
def barchart(cursor, query, title, x_name, y_name):
	x = []
	y = []
	cursor.execute (query)
	for row in cursor:
		x += [x_name + " " + str(row[0])]
		y += [row[1]]
	data = [go.Bar (
		x = x,
		y = y
		)]
	layout = go.Layout(
		title = title,
		xaxis = dict(
			title = x_name,
			),
		yaxis = dict(
			title = y_name,
			rangemode = "nonegative",
			autorange = True,
			))
	bar = go.Figure(layout = layout, data = data)
	return py.plot(bar)

query = """
SELECT 
	COMPUTER_ID, 
	count(HARDWARE_ID)
FROM 
	COMPUTER left join HAS_HARDWARE
	using(COMPUTER_ID) 
group by COMPUTER_ID"""
query_1 = barchart (
	cursor,
	query,
	"Number of installed hardware",
	"Computers",
	"Number of hardware")
"""------------DONUT CHART----------------------------"""
"""Вивести встановлені деталі та їх % відносно всіх встановлених у компьютери"""
def piechart(cursor, query):
	labels = []
	values = []
	cursor.execute (query)
	for row in cursor:
		labels += [row[0]]
		values += [row[1]]
	pie = go.Pie (
		labels = labels,
		values = values
		)
	return py.plot([pie])

query = """
SELECT 
	TYPE || ' ' || MODEL, 
	count(computer_id)
FROM 
	COMPUTER inner join HAS_HARDWARE
	using(COMPUTER_ID)
	right join HARDWARE
	using(HARDWARE_ID) 
group by MODEL, TYPE"""
query_2 = piechart(cursor, query)

"""------------SCATTER CHART----------------------------"""
"""Вивести дати створення деталей на заводі"""
def scatterchart(cursor, query):
	x = []
	y = []
	cursor.execute (query)	
	"""if row[0].date() in x:
			y[x.index(row[0].date())] += 1
		else:
	"""
	for row in cursor:
		x += [row[0].date()]
		y += [row[1]]
	scatter = go.Scatter (
		x = x,
		y = y,
		mode = "lines + markers"
		)
	return py.plot([scatter])

query = """
SELECT PRODUCTION_TIME, sum(count)
FROM (SELECT 
		TRUNC(PRODUCTION_TIME, 'MONTH') as PRODUCTION_TIME, count(HARDWARE_ID) as count
	FROM 
		HARDWARE
	group by PRODUCTION_TIME)
group by PRODUCTION_TIME
order by PRODUCTION_TIME"""
query_3 = scatterchart(cursor, query)

"""------------DASHBOARD----------------------------"""
dashboard = dashboard.Dashboard()
query_1_id = fileId_from_url(query_1)
query_2_id = fileId_from_url(query_2)
query_3_id = fileId_from_url(query_3)
part_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': query_1_id,
    'title': 'Number of installed hardware'
}
 
part_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': query_2_id,
    'title': 'All installed hardware ratio'
}
 
part_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': query_3_id,
    'title': 'Hardware manufactory time'
}
dashboard.insert(part_1)
dashboard.insert(part_2, 'below', 1)
dashboard.insert(part_3, 'left', 2)

py.dashboard_ops.upload(dashboard, 'Data Bases Task 2 - Visualization')
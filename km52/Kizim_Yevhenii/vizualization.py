import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import numpy
import dateparser
import plotly.dashboard_objs as dashboard
 
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')

connection = cx_Oracle.connect("testuser", "testuser", "localhost:1521/xe")

cursor = connection.cursor()
 
 
 
""" create plot 1   Вивести університети та кількість їх факультетів."""
 
cursor.execute("""
    SELECT report.UNIVER_ID||': '||TRIM(report.UNIVER_NAME) AS UNIVERSITY, NVL(QUANTITY, 0) AS QUANTITY
	FROM
		(
		SELECT  UNIVERSITIES.UNIVER_ID, UNIVERSITIES.UNIVER_NAME, COUNT(FACULTIES.FACULTY_ID) AS QUANTITY
		FROM UNIVERSITIES LEFT JOIN FACULTIES 
			ON UNIVERSITIES.UNIVER_ID = FACULTIES.UNIVER_ID_FK
		GROUP BY UNIVERSITIES.UNIVER_ID, UNIVERSITIES.UNIVER_NAME
		) report   """)
 
universities = []
faculty_quantity = []
 
 
 
for row in cursor:
    print("University: ",row[0]," and his quantity of faculties: ",row[1])
    universities += [row[0]]
    faculty_quantity += [row[1]]
 
 
data = [go.Bar(
            x=universities,
            y=faculty_quantity
    )]
 
layout = go.Layout(
    title='Universities and quantity of faculties',
    xaxis=dict(
        title='Universitites',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Quantity of faculties',
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
 
universities_fuculty_quantity = py.plot(fig, filename='universities-fuculty-quantity')


""" create plot 2   Вивести кафедри прикладної математики та їх відсоток щорічної квоти місць відносно одне одного."""
 
 
cursor.execute("""
	SELECT DEPARTMENT_ID, TRIM(DEPARTMENT_NAME), DEPARTMENT_STUDENTS_QUOTA
	FROM DEPARTMENTS
	WHERE FACULTY_ID_FK = 1
""");
 
departments = []
students_quota = []
 
 
for row in cursor:
    print("Department name ",row[1]+" id: ("+str(row[0]),") and his quota: " +str(row[2]))
    departments += [row[1]+" "+str(row[0])]
    students_quota += [row[2]]
 
 
 
pie = go.Pie(labels=departments, values=students_quota)
departments_students_quota = py.plot([pie], filename='departments-students-quota')

""" create plot 3   Вивести динаміку заснувань факультетів"""
 
 
cursor.execute("""
	SELECT FACLULTY_DATE_FOUNDATION, COUNT(FACULTY_ID) AS QUANTITY
	FROM FACULTIES
	WHERE FACLULTY_DATE_FOUNDATION IS NOT NULL 
	GROUP BY FACLULTY_DATE_FOUNDATION
	ORDER BY FACLULTY_DATE_FOUNDATION
""")
foundation_dates = []
quantity = []
 
 
for row in cursor:
    print("Date ",row[0]," sum: ",row[1])
    foundation_dates += [str(row[0])[:4]]
    quantity += [row[1]]


 
 
foundation_quantity = go.Scatter(
    x=foundation_dates,
    y=quantity,
    mode='lines+markers'
)
data = [foundation_quantity]
foundation_quantity_url=py.plot(data, filename='foundation-quantity')

"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
universities_fuculty_quantity_id = fileId_from_url(universities_fuculty_quantity)
departments_students_quota_id = fileId_from_url(departments_students_quota)
foundation_quantity_id = fileId_from_url(foundation_quantity_url)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': universities_fuculty_quantity_id,
    'title': 'Universities and quantity of Faculties'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': departments_students_quota_id,
    'title': 'Departments and students quota'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': foundation_quantity_id,
    'title': 'Faculties foundation by date'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'Universities Dashboard')
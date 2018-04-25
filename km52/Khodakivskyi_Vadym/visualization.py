
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
connection = cx_Oracle.connect("vadimka", "vadimka", "localhost:1521/xe")
 
cursor = connection.cursor()
 
 
 
""" create plot 1   Вивести номер класу та загальну кількість мелблів у кожному з них."""
 
cursor.execute("""
    SELECT
    chairs.class_number,
    nvl(chair_count + table_count,0) AS furniture_count
FROM
    (
        SELECT
            classroom.class_number,
            COUNT(chair_id) AS chair_count
        FROM
            classroom left
            JOIN chair ON chair.class_number = classroom.class_number
        GROUP BY
            classroom.class_number
    ) chairs
    JOIN (
        SELECT
            classroom.class_number,
            COUNT(table_id) AS table_count
        FROM
            classroom left
            JOIN "Table" ON "Table".class_number = classroom.class_number
        GROUP BY
            classroom.class_number
    ) table_s ON chairs.class_number = table_s.class_number
    order by class_number   
    """);
 
classrooms = []
furniture_count = []
 
 
 
for row in cursor:
    
    print("classroom: ",row[0]," and its amount of furniture: ",row[1])
    classrooms += ["Number " + str(row[0])]
    furniture_count += [row[1]]
 
 
data = [go.Bar(
            x=classrooms,
            y=furniture_count
    )]
 
layout = go.Layout(
    title='Classrooms and amount of furniture',
    xaxis=dict(
        title='Classrooms',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Amount of furniture',
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
 
classrooms_furniture_count = py.plot(fig, filename='scatter')

print(classrooms_furniture_count)


# In[4]:


print(""" create plot 2   Вивести номер класу та відсоток усіх меблів у ньому.""")
 
 
cursor.execute("""
SELECT
    chairs.class_number,
    nvl(chair_count + table_count,0) AS furniture_count
FROM
    (
        SELECT
            classroom.class_number,
            COUNT(chair_id) AS chair_count
        FROM
            classroom left
            JOIN chair ON chair.class_number = classroom.class_number
        GROUP BY
            classroom.class_number
    ) chairs
    JOIN (
        SELECT
            classroom.class_number,
            COUNT(table_id) AS table_count
        FROM
            classroom left
            JOIN "Table" ON "Table".class_number = classroom.class_number
        GROUP BY
            classroom.class_number
    ) table_s ON chairs.class_number = table_s.class_number
    order by class_number
""");
 
classrooms_1 = []
furniture_count_1 = []
 
 
for row in cursor:
    print("Classroom number ",row[0],"and its amount of furniture: ",row[1])
    classrooms_1 += ["number "+str(row[0])]
    furniture_count_1 += [row[1]]
 
 
 
pie = go.Pie(labels=classrooms_1, values=furniture_count_1)
classrooms_furniture_count_1 = py.plot([pie], filename='classrooms_furniture_count')
 
 


# In[6]:


print(""" create plot 3   Вивести зміну кількості стільців по поверхах""")
 
 
cursor.execute("""
SELECT
    classroom.class_floor,
    nvl(count(chair.chair_id),0) AS chair_count
FROM CLASSROOM left join chair
on classroom.class_number = chair.CLASS_NUMBER
group by classroom.class_floor
""")
classrooms_floor = []
chair_count_2 = []
 
 
for row in cursor:
    print("Floor ",row[0]," amount of furniture: ",row[1])
    classrooms_floor += [row[0]]
    chair_count_2 += [row[1]]
 
 
floor_furniture = go.Scatter(
    x=classrooms_floor,
    y=chair_count_2,
    mode='lines+markers'
)
data = [floor_furniture]
floor_furniture_url=py.plot(data, filename='Orders price by date')
 
 


# In[8]:


"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
classrooms_furniture_count_id = fileId_from_url(classrooms_furniture_count)
classrooms_furniture_count_1_id = fileId_from_url(classrooms_furniture_count_1)
floor_furniture_url_id = fileId_from_url(floor_furniture_url)

print(classrooms_furniture_count_id)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': classrooms_furniture_count_id,
    'title': 'classrooms'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': classrooms_furniture_count_1_id,
    'title': 'classrooms and furniture'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': floor_furniture_url_id,
    'title': 'the amount of firniture by floor'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'Dashboard with Python')


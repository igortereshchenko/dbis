
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
connection = cx_Oracle.connect("SYSTEM", "12345", "localhost:1521/xe")
 
cursor = connection.cursor()
 
 
 
""" create plot 1   Вивести номер класу та загальну кількість стільців у ньому"""
 
cursor.execute("""
SELECT
    Classroom.classroom_number,
    NVL(COUNT(chair_zip),0) as Chair_Count
 FROM
    Classroom LEFT JOIN Chair
        ON Classroom.classroom_number = Chair.classroom_number_fk_ch
    GROUP BY Classroom.classroom_number
    ORDER BY Classroom.classroom_number
    """);
 
classrooms = []
Chair_Count = []
 
 
for row in cursor:
    print("Classroom number: ",row[0]," and count of chairs: ",row[1])
    classrooms += ["№ " + str(row[0])]
    Chair_Count += [row[1]]
 
 
data = [go.Bar(
            x=classrooms,
            y=Chair_Count
    )]
 
layout = go.Layout(
    title='Classrooms and count of chairs',
    xaxis=dict(
        title='Classrooms',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Count of Chairs',
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

classrooms_chair_count = py.plot(fig, filename='barchart')

print(classrooms_chair_count)


# In[4]:


print(""" create plot 2   Вивести колір та відсоток парт цього кольору від загальної цількості парт.""")
 

cursor.execute("""
SELECT
    Desk.desk_color,
    NVL(COUNT(Distinct desk_zip),0) as Desk_Count
 FROM
    Desk
    GROUP BY desk_color
    """);

Colors = []
Desk_count = []
 
 
for row in cursor:
    print("Color: ",row[0]," and number of current desks: ",row[1])
    Colors+= [row[0]]
    Desk_count += [row[1]]
 
 
 
pie = go.Pie(labels=Colors, values=Desk_count)
py.plot([pie])

color_desk_count = py.plot([pie], filename='piechart')
 
 


# In[6]:


print(""" create plot 3   Вивести динаміку меблів по класним кімнатам""")
 
 
cursor.execute("""
   
SELECT 
    desks.classroom_number,
    NVL(chair_count + desk_count + blackboard_count,0) AS chair_desk_blackboard_count
FROM
    (
        SELECT
            Classroom.classroom_number,
            COUNT(chair_zip) AS chair_count
        FROM
            Classroom LEFT JOIN Chair
            ON Chair.classroom_number_fk_ch = Classroom.classroom_number
        GROUP BY
            Classroom.classroom_number
    ) chairs
    JOIN (
        SELECT
            Classroom.classroom_number,
            COUNT(desk_zip) AS desk_count
        FROM
            Classroom LEFT JOIN Desk
            ON Desk.classroom_number_fk_ds = Classroom.classroom_number
        GROUP BY
            Classroom.classroom_number
    ) desks ON chairs.classroom_number = desks.classroom_number
    JOIN (
        SELECT
            Classroom.classroom_number,
            COUNT(blackboard_zip) AS blackboard_count
        FROM
            Classroom LEFT JOIN Blackboard
            ON Blackboard.classroom_number_fk_bb = Classroom.classroom_number
        GROUP BY
            Classroom.classroom_number
    ) blackboards ON desks.classroom_number = blackboards.classroom_number
    order by classroom_number
""");

classroom_number_2 = []
chair_desk_blackboard_count = []
 
 
for row in cursor:
    print("Classroom number: ",row[0]," and number of objects : ",row[1])
    classroom_number_2 += ["№ " + str(row[0])]
    chair_desk_blackboard_count += [row[1]]
 
 
Classroom_objects = go.Scatter(
    x=classroom_number_2,
    y=chair_desk_blackboard_count,
    mode='lines+markers'
)

data = [Classroom_objects]
Classroom_objects_url=py.plot(data, filename='scatter')
 
 


# In[8]:


"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
classrooms_chair_count_id = fileId_from_url(classrooms_chair_count)
color_desk_count_id = fileId_from_url(color_desk_count)
Classroom_objects_url_id = fileId_from_url(Classroom_objects_url)

print(classrooms_chair_count_id)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': classrooms_chair_count_id,
    'title': 'Classrooms and count of chairs'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': color_desk_count_id,
    'title': 'Colors and amount of desks'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': Classroom_objects_url_id,
    'title': 'Classrooms and amount of all objects'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'Dashboard for 1st laboratory')


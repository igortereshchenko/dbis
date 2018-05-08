import re
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import plotly.dashboard_objs as dashboard

def fileId_from_url(url):
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')

user_name = 'whakarewarewa'
password = 'whakarewarewa'
server = 'xe'

connection = cx_Oracle.connect(user_name, password, server)
cursor = connection.cursor()

cursor.execute("""
SELECT
    ROOM_ID, NUMBER_CHAIRS
FROM
    CLASSROOM""")

ROOM_ID = []
NUMBER_CHAIRS = []

for row in cursor:
    print("ROOM_ID: ", row[0], " and NUMBER_CHAIRS: ", row[1])
    ROOM_ID += [row[0]]
    NUMBER_CHAIRS += [row[1]]

data = go.Bar(x=ROOM_ID,
              y=NUMBER_CHAIRS)


layout = go.Layout(
    title='ROOM_ID and NUMBER_CHAIRS',
    xaxis=dict(
        title='ROOM_ID',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),

    yaxis=dict(
        title='NUMBER_CHAIRS',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    )
)

fig = go.Figure(data=[data], layout=layout)

room_number_chairs = py.plot(fig, filename='room-number-chairs')

cursor.execute("""
SELECT
    DESK_MODEL, COUNT(DESK_MODEL) DESK_SUM
FROM
    DESKS
GROUP BY
    DESK_MODEL""");

DESK_MODEL = []
DESK_SUM = []

for row in cursor:
    print("DESK_MODEL ", row[0], " DESK_SUM: ", row[1])
    DESK_MODEL += [row[0]]
    DESK_SUM += [row[1]]

pie = go.Pie(labels=DESK_MODEL, values=DESK_SUM)
DESKS_MODEL_SUM = py.plot([pie], filename='desks-model-sum')

cursor.execute("""
SELECT
    RECONDITIONING_DATE, ROOM_ID
FROM
    RECONDITIONING
""")

RECONDITIONING_DATE = []
ROOM_ID = []

for row in cursor:
    print("Date ", row[0], " room: ", row[1])
    RECONDITIONING_DATE += [row[0]]
    ROOM_ID += [row[1]]

reconditioning_date_room = go.Scatter(
    x=RECONDITIONING_DATE,
    y=ROOM_ID,
    mode='lines+markers'
)

data = [reconditioning_date_room]
reconditioning_date_room_url = py.plot(data, filename='Room reconditioning by date')

my_dboard = dashboard.Dashboard()

room_number_chairs_id = fileId_from_url(room_number_chairs)
DESKS_MODEL_SUM_id = fileId_from_url(DESKS_MODEL_SUM)
reconditioning_date_room_id = fileId_from_url(reconditioning_date_room_url)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': room_number_chairs_id,
    'title': 'Room and chairs sum'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': DESKS_MODEL_SUM_id,
    'title': 'Desks models and sum'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': reconditioning_date_room_id,
    'title': 'Classrooms by reconditioning date'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')

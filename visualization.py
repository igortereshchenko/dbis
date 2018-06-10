import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
 
connection = cx_Oracle.connect("vad1", "25436762", "xe") 
cursor = connection.cursor()
 
 
 
""" create plot 1   Вивести користувачів та кількість операційних систем які вони використовують."""
 
cursor.execute("""
SELECT
   USERS.NAME,
    NVL(COUNT(WINDOWS.KEY),0) as COUNT_OF_USING_WINDOWS
 FROM
    USERS LEFT JOIN WINDOWS
        ON USERS.NAME = WINDOWS.NAME_USER_C
        AND
        USERS.PASSWORD = WINDOWS.PASSWORD_USER_C
    GROUP BY USERS.NAME
    ORDER BY COUNT_OF_USING_WINDOWS DESC""")
 
USERS = []
COUNT_OF_USING_WINDOWS = []
 

for row in cursor:
    print("USER name: ",row[0]," and his count of using windows: ",row[1])
    USERS += [row[0]]
    COUNT_OF_USING_WINDOWS += [row[1]]
 
 
data = [go.Bar(
            x=USERS,
            y=COUNT_OF_USING_WINDOWS
    )]
 
layout = go.Layout(
    title='Users and their windows',
    xaxis=dict(
        title='Users',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Count of windows',
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
 
users_using_windows = py.plot(fig,filename='users_using_windows')
 
 
""" create plot 2   Вивести операційну систему та кількість програм які на ній встановлено."""
 
 
cursor.execute("""
SELECT
   TRIM(WINDOWS.KEY),
   TRIM(WINDOWS.VERSION),
    NVL(COUNT(COMPUTER.WINDOWS_C),0) as COUNT_OF_USING_PROGRAMS
 FROM
    WINDOWS LEFT JOIN COMPUTER
        ON COMPUTER.WINDOWS_C = WINDOWS.KEY
    GROUP BY WINDOWS.KEY,WINDOWS.VERSION
    ORDER BY COUNT_OF_USING_PROGRAMS DESC
    """);
 
windows = []
count_of_programs = []
 
 
for row in cursor:
    print("Windows version ",row[1]+" key: ("+row[0],") and his using programs: ",row[2])
    windows += [row[1]+" ("+row[0]+")"]
    count_of_programs += [row[2]]
 
 
 
pie = go.Pie(labels=windows, values=count_of_programs)
programs_on_windows=py.plot([pie], filename='programs_on_windows')

 
 
""" create plot 3   Вивести комп'ютер та кількість його користувачів"""
 

cursor.execute("""
SELECT
   WINDOWS.KEY,
   WINDOWS.VERSION,
    NVL(COUNT(WINDOWS.VERSION),0) as WINDOWS_ON_COMPUTER
 FROM
    WINDOWS LEFT JOIN COMPUTER
         ON COMPUTER.WINDOWS_C = WINDOWS.KEY
    GROUP BY  WINDOWS.KEY,
   WINDOWS.VERSION

""")
windows = []
COMPUTER = []
 
 
for row in cursor:
    print("Windows version ",row[1]+" key: ("+row[0],") his count on computer ",row[2])
    windows += [row[0]+row[1]]
    COMPUTER += [row[2]]
 
 
WINDOWS_ON_COMPUTER = go.Scatter(
    x=windows,
    y=COMPUTER,
    mode='lines+markers'
)
data = [WINDOWS_ON_COMPUTER]
WINDOWS_ON_COMPUTER_url=py.plot(data, filename='WINDOWS_ON_COMPUTER_url')
 
 
"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
users_using_windows_id = fileId_from_url(users_using_windows)
programs_on_windows_id = fileId_from_url(programs_on_windows)
WINDOWS_ON_COMPUTER_id = fileId_from_url(WINDOWS_ON_COMPUTER_url)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': users_using_windows_id,
    'title': 'Users use windows'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': programs_on_windows_id,
    'title': 'programs on windows'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': WINDOWS_ON_COMPUTER_id,
    'title': 'WINDOWS ON COMPUTER'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')
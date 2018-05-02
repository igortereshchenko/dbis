
# coding: utf-8

# In[22]:


import plotly
plotly.tools.set_credentials_file(username='Katya_Kollehina', api_key='tVeOqtxhhASLcb9FSv5B')

import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard

def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z]+/[0-9]+", url)[0][1:]
    print(raw_fileId)
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("SYSTEM", "florist98", "localhost:1521/xe")

cursor = connection.cursor()

""" create plot 1   Вивести назву пісні та її тривалість ."""

cursor.execute("""
SELECT
  song_name,
  song_duration
FROM SONG
  JOIN Human_wrote_song ON song.song_id = Human_wrote_song.song_id
""")

song_name = []
song_duration = []

for row in cursor:
    print("Song_name: ", row[0], " and its duration: ", row[1])
    song_name.append(row[0])
    song_duration.append(row[1])


data = [go.Bar(
    x=song_name,
    y=song_duration
)]

layout = go.Layout(
    title='Song_name and its duration',
    xaxis=dict(
        title='Song_name',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='duration',
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

song_name_duration = py.plot(fig, filename='song_name_duration')

""" create plot 2   Вивести ім'я співака, назву пісні та %відношення її тривалості відносно інших."""

cursor.execute("""
SELECT
  human_name singer,
  song_name song,
  song_duration duration
FROM HUMAN
  JOIN Human_wrote_song ON human.human_id = Human_wrote_song.human_id
  JOIN SONG ON song.song_id = Human_wrote_song.song_id
""");

song = []
duration = []

for row in cursor:
    print("singer ", row[0] + ", song : (" + row[1], ") and its duration: ", row[2])
    song.append(row[0] + " " + row[1])
    duration.append(row[2])

pie = go.Pie(labels=song, values=frequency)
song_duration = py.plot([pie], filename='song duration relative to others')

""" create plot 3   Вивести динаміку створення пісень по датах"""

cursor.execute("""
SELECT
  song_name song,
  song_birth birthday
FROM SONG
  JOIN HUMAN_WROTE_SONG ON song.song_id = Human_wrote_song.song_id
""")
song = []
birthday = []

for row in cursor:
    print("Song ", row[0], " Date, when it was written: ", row[1])
    song.append(row[0])
    birthday.append(row[1])

song_birthday = go.Scatter(
    x=song,
    y=birthday,
    mode='lines+markers'
)
data = [song_birthday]
song_birthday = py.plot(data, filename='Song by date, when it was written')

"""--------CREATE DASHBOARD------------------ """

song_name_duration_id = fileId_from_url(song_name_duration)  
song_duration_id = fileId_from_url(song_duration)
song_birthday_id = fileId_from_url(song_birthday)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': song_name_duration_id,
    'title': 'Song_name and its duration'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': song_duration_id,
    'title': 'song duration relative to others'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': song_birthday_id,
    'title': 'Song by date, when it was written'
}
my_dboard = dashboard.Dashboard()
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')


import cx_Oracle
import plotly
import plotly.plotly as py
import plotly.graph_objs as go
import plotly.dashboard_objs as dashboard
import re

# Users and Playlist Diagram https://plot.ly/~vicodin/0
# Author ans Songs count Pie https://plot.ly/~vicodin/2
# New Contacts by Date Graphic https://plot.ly/~vicodin/4
# Dashboard: https://plot.ly/dashboard/vicodin:6/view

plotly.tools.set_credentials_file(username='vicodin', api_key='9KnhfWA8tUcb6fi6rMrF')
connection = cx_Oracle.connect("code_review", "code_review", "127.0.0.1")
cursor = connection.cursor()

# Запит – числова характеристика екземплярів сутності.
# Вивід кількості плейлістів у кожного кристувача.
# Візуалізація – стовпчикова діаграма.

cursor.execute("""
SELECT
    USERS.EMAIL,
    TRIM(USERS.USER_NAME),
    TRIM(USERS.USER_LASTNAME),
    NVL(COUNT(DISTINCT PLAYLIST.PLAYLIST_NAME),0) as PLAYLIST_SUM
 FROM
    USERS LEFT JOIN PLAYLIST
        ON USERS.EMAIL = PLAYLIST.EMAIL_FK
    GROUP BY USERS.EMAIL, TRIM(USERS.USER_NAME), TRIM(USERS.USER_LASTNAME) """)

users = []
playlist_count = []

for row in cursor:
    print("User name: ", row[1], row[2], " playlist count: ", row[3])
    users += [row[0] + " " + row[1] + " " + row[2]]
    playlist_count += [row[3]]

data = [go.Bar(
    x=users,
    y=playlist_count)]

layout = go.Layout(
    title='Users and Playlists count',
    xaxis=dict(
        title='Users',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Playlists count',
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
users_playlist_count = py.plot(fig, filename='users_playlist')

# Запит – відсоткова характеристика екземплярів сутності.
# Вивести автора та % його пісень у плейлістах користувачів.
# Візуалізація – секторна діаграма.

cursor.execute("""
SELECT
    DISTINCT TRIM(MUSIC.AUTHOR),
    NVL(COUNT(PLAYLIST.AUTHOR_FK),0) as MUSIC_COUNT
 FROM
    MUSIC LEFT JOIN PLAYLIST
        ON (MUSIC.AUTHOR = PLAYLIST.AUTHOR_FK )
    GROUP BY TRIM(MUSIC.AUTHOR), TRIM(MUSIC.MUSIC_NAME)
""")

authors = []
song_count = []

for row in cursor:
    print("Author name ", row[0], "and his songs count: ", row[1])
    authors += [row[0]]
    song_count += [row[1]]

pie = go.Pie(labels=authors, values=song_count)
author_songs = py.plot([pie], filename='author_songs')

# Запит - динаміка зміни інформації.
# Кількість нових контактів у певні дні.
# Візуалізація – графік залежності.

cursor.execute("""
SELECT
    DATE_ADDED,
    NVL(COUNT(CONTACT_EMAIL),0) as CONTACTS
 FROM
    USER_CONTACTS
    GROUP BY DATE_ADDED
    ORDER BY  DATE_ADDED
""")
dates = []
contacts_count = []

for row in cursor:
    print("Date ", row[0], " sum: ", row[1])
    dates += [row[0]]
    contacts_count += [row[1]]

date_contacts = go.Scatter(
    x=dates,
    y=contacts_count,
    mode='lines+markers'
)
data = [date_contacts]
date_cont = py.plot(data, filename='date_cont')

# CREATE DASHBOARD

dboard = dashboard.Dashboard()


def fileId_from_url(url):
    """Return fileId from a url."""
    print(url)
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')


users_playlist_count = fileId_from_url(users_playlist_count)
author_songs = fileId_from_url(author_songs)
date_cont = fileId_from_url(date_cont)

box_diagram = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': users_playlist_count,
    'title': 'Users and Playlists count'
}

box_pie = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': author_songs,
    'title': 'Authors and Songs count'
}

box_graphic = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': date_cont,
    'title': 'Added contacts by date'
}

dboard.insert(box_diagram)
dboard.insert(box_pie, 'below', 1)
dboard.insert(box_graphic, 'left', 2)

py.dashboard_ops.upload(dboard, 'Dashboard with Python')
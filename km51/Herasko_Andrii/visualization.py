import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')

connection = cx_Oracle.connect("herasko", "herasko", "xe")

cursor = connection.cursor()


cursor.execute("""
SELECT
    ( person_name
    || ' '
    || person_surname ) AS person,
    COUNT(song_title
    || song_release_year) AS song_count
FROM
    person left
    JOIN author ON person.person_id_number = author.person_id_number
GROUP BY
    person_name,
    person_surname
""")

authors = []
song_count = []

for row in cursor:
    print("Author ", row[0], " and quantity of songs: ", row[1])
    authors+= [row[0]]
    song_count += [row[1]]

data = [go.Bar(
        x=authors,
        y=song_count
    )]

layout = go.Layout(
        title='Author writes songs',
        xaxis=dict(
            title='Person',
            titlefont=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        ),
        yaxis=dict(
            title='Quantity of song',
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

authors_songs = py.plot(fig, filename='Author writes song', auto_open=False)



cursor.execute("""

SELECT
    ( person_name
    || ' '
    || person_surname ) AS person,
    COUNT(song_title
    || song_release_year) AS song_count
FROM
    person left
    JOIN singer ON person.person_id_number = singer.person_id_number
GROUP BY
    person_name,
    person_surname
""")

singers = []
song_count = []

for row in cursor:
    print("Persons ", row[0] , " sings " , row[1], " songs")
    singers += [row[0]]
    song_count+= [row[1]]

pie = go.Pie(labels=singers , values=song_count)

singer_songs = py.plot([pie], filename='Singer sings a song', auto_open=False)

cursor.execute("""
SELECT
    song_release_year,
    COUNT(*)
FROM
    song
GROUP BY
    song_release_year

""")
years= []
computer_count= []

for row in cursor:
    print("Year ", row[0], " quantity of songs ", row[1])
    years+= [row[0]]
    computer_count += [row[1]]

order_date_prices = go.Scatter(
    x=years,
    y=computer_count,
    mode='lines+markers'
)
data = [order_date_prices]

years_song = py.plot(data, filename='Songs in year', auto_open=False)



"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

authors_songs_id = fileId_from_url(authors_songs)
singer_songs_id = fileId_from_url(singer_songs)
years_song_id = fileId_from_url(years_song)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': authors_songs_id,
    'title': 'computer_os'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': singer_songs_id,
    'title': 'computer_os_days'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': years_song_id,
    'title': 'computers_date'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')




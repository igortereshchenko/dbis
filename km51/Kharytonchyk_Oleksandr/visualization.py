import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("Kharytonchyk", "P12345", "xe")

cursor = connection.cursor()

""" create plot 1   Вивести людину та загальну кількість написаних ним пісень."""

cursor.execute("""
SELECT
    human.human_identific_number,
    TRIM(human_name)
    || ' '
    || TRIM(human_surname) AS human_full_name,
    nvl(COUNT(human_writes_song.song_title),0) AS quantity_of_written_songs
FROM
    human left
    JOIN human_writes_song ON human.human_identific_number = human_writes_song.human_identific_number
GROUP BY
    human.human_identific_number,
    human_name,
    human_surname  
""")

humans = []
written_songs_quantity = []

for row in cursor:
        print("Human full name : ", row[1], " and quantity of written songs : ", row[2])
        humans += [row[1]]
        written_songs_quantity+= [row[2]]

data = [go.Bar(
        x=humans,
        y=written_songs_quantity
    )]

layout = go.Layout(
        title='Humans and written songs quantity',
        xaxis=dict(
            title='Humans',
            titlefont=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        ),
        yaxis=dict(
            title='Written songs quantity',
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

humans_written_songs_quantity = py.plot(fig, filename='humans-written-songs-quantity', auto_open=False)

""" create plot 2   Вивести людину та % його написаних пісень відносно решти людей."""

cursor.execute("""
SELECT
    human.human_identific_number,
    TRIM(human_name)
    || ' '
    || TRIM(human_surname) AS human_full_name,
    nvl(COUNT(human_sings_song.song_title),0) AS quantity_of_song_songs
FROM
    human left
    JOIN human_sings_song ON human.human_identific_number = human_sings_song.human_identific_number
GROUP BY
    human.human_identific_number,
    human_name,
    human_surname
""");

humans = []
quantity_of_song_songs = []

for row in cursor:
        print("Human full name ", row[1] , " id: (" , row[0], ") and his quantity of song songs: ", row[2])
        humans += [row[1]]
        quantity_of_song_songs += [row[2]]

pie = go.Pie(labels=humans, values=quantity_of_song_songs)
py.plot([pie])

humans_quantity_of_song_songs = py.plot([pie], filename='humans-quantity-of-song-songs', auto_open=False)

""" create plot 3   Вивести динаміку написання пісень по датах"""

cursor.execute("""
SELECT
    song_release_year,
    nvl(COUNT(human_writes_song.song_title),0) AS song_quantity
FROM
    human_writes_song
GROUP BY
    song_release_year
ORDER BY
    song_release_year
""")
songs_release_years = []
songs_quantity = []

for row in cursor:
        print("Release year : ", row[0], " quantity : ", row[1])
        songs_release_years += [row[0]]
        songs_quantity += [row[1]]

songs_release_years_quantity = go.Scatter(
        x=songs_release_years,
        y=songs_quantity,
        mode='lines+markers'
    )
data = [songs_release_years_quantity]
songs_release_years_quantity_url = py.plot(data, filename='Written songs by release year', auto_open=False)

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

humans_written_songs_quantity_id = fileId_from_url(humans_written_songs_quantity)
humans_quantity_of_song_songs_id = fileId_from_url(humans_quantity_of_song_songs)
songs_release_years_quantity_id = fileId_from_url(songs_release_years_quantity_url)

box_1 = {
        'type': 'box',
        'boxType': 'plot',
        'fileId': humans_written_songs_quantity_id,
        'title': 'Humans and written songs quantity'
}

box_2 = {
        'type': 'box',
        'boxType': 'plot',
        'fileId': humans_quantity_of_song_songs_id,
        'title': 'Humans and written songs quantity'
}

box_3 = {
        'type': 'box',
        'boxType': 'plot',
        'fileId': songs_release_years_quantity_id,
        'title': 'Written songs by release year'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')



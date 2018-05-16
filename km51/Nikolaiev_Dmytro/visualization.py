 
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
 
 
connection = cx_Oracle.connect("dima", "dima", "127.0.0.1")
 
cursor = connection.cursor()
 
cursor.execute("""
Select Humans.human_name, count (Human_sing_song.song_name) as songs
FROM HUMANS JOIN HUMAN_SING_SONG
ON humans.human_id=HUMAN_SING_SONG.HUMAN_ID
Group by humans.human_name """)
 
humans = []
songs = []
 
 
for row in cursor:
    humans += [row[0]];  songs += [row[1]]
 
 
data = [go.Bar(
            x=humans,
            y=songs
    )]
 
layout = go.Layout(
    title='People and songs they sing',
    xaxis=dict(
        title='Human',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Songs',
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
 
humans_songs = py.plot(fig)

pie = go.Pie(labels=humans, values=songs)
py.plot([pie])

human_songs = go.Scatter(
    x=humans,
    y=songs,
    mode='lines+markers'
)
data = [human_songs]
py.plot(data)
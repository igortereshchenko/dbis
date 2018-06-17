import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
from plotly.tools import set_credentials_file


class Vizualizator:
	def __init__(self, username, api_key):
		set_credentials_file(username=username, api_key=api_key)

	@staticmethod
	def bar(x, y, x_title, y_title, main_title, filename):
		data = [go.Bar(
		            x=x,
		            y=y
		    )]
		layout = go.Layout(
		    title=main_title,
		    xaxis=dict(
		        title=x_title,
		        titlefont=dict(
		            family='Courier New, monospace',
		            size=18,
		            color='#7f7f7f'
		        )
		    ),
		    yaxis=dict(
		        title=y_title,
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
		py.plot(fig, filename=filename)

	@staticmethod
	def pie(labels, values, filename):
		pie = go.Pie(labels=labels, values=values)
		py.plot([pie], filename=filename)


class DB_Wrapper:
	def __init__(self, db_port, db_host, username, password, db):
		connstr = '{0}/{1}@{2}:{3}/{4}'.format(username, password, db_host, db_port, db)
		self.conn = cx_Oracle.connect(connstr)
		self.cursor = self.conn.cursor()

	def get_songs_per_date(self):
		query = """
			SELECT songs.created, COUNT(*) as song_count
			FROM tourist
				GROUP BY tourist.vacation_from ORDER BY COUNT(tourist.vacation_from)
			"""
		dates = []
		songs = []
		self.cursor.execute(query)
		for date, count in self.cursor:
			dates.append(date)
			songs.append(count)
		return (dates, songs)

	def get_songs_count_per_singer(self):
		query = """
			SELECT singer_last_name, COUNT(Song.song_id) as songs
			FROM Singer JOIN Song on Singer.singer_id=Song.singer_id
				GROUP BY singer_last_name ORDER BY COUNT(Song.song_id)
			"""
		singers = []
		songs = []
		self.cursor.execute(query)
		for name, count in self.cursor:
			singers.append(name)
			songs.append(count)
		return (singers, songs)


if __name__ == '__main__':
	db_client = DB_Wrapper(
			username='username',
			password='password',
			db='db_name',
			db_host='127.0.0.1',
			db_port=1521
		)
	vizualizator = Vizualizator(username='username', api_key='api_key')
	x, y = db_client.get_songs_per_date()
	data = {
			'x': x,
			'y': y,
			"main_title": "Songs per date",
			"x_title": "Dates",
			"y_title": "Songs count",
			"filename": "date-songs-count"
		}
	vizualizator.bar(**data)

	x, y = db_client.get_tourists_count_per_hotel()
	data = {
			'x': x,
			'y': y,
			"main_title": "Songs per singer",
			"x_title": "Singer",
			"y_title": "Song count",
			"filename": "singer-song-count"
		}
	vizualizator.bar(**data)

	data = {
		"filename": "singer-song-sum",
		"labels": x,
		"values": y
	}
	vizualizator.pie(**data)
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

	def get_tourists_per_date(self):
		query = """
			SELECT tourist.vacation_from, COUNT(tourist.tourist_id) as tourists
			FROM tourist
				GROUP BY tourist.vacation_from ORDER BY COUNT(tourist.vacation_from)
			"""
		dates = []
		tourists = []
		self.cursor.execute(query)
		for date, count in self.cursor:
			dates.append(date)
			tourists.append(count)
		return (dates, tourists)

	def get_tourists_count_per_hotel(self):
		query = """
			SELECT hotel.hotel__name, COUNT(tourist.hotel_id) as tourists
			FROM tourist JOIN hotel on tourist.hotel_id=hotel.hotel_id
				GROUP BY hotel.hotel__name ORDER BY COUNT(tourist.hotel_id)
			"""
		hotels = []
		tourists = []
		self.cursor.execute(query)
		for name, count in self.cursor:
			hotels.append(name)
			tourists.append(count)
		return (hotels, tourists)


if __name__ == '__main__':
	db_client = DB_Wrapper(
			username='username',
			password='password',
			db='db_name',
			db_host='127.0.0.1',
			db_port=1521
		)
	vizualizator = Vizualizator(username='username', api_key='api_key')
	x, y = db_client.get_tourists_per_date()
	data = {
			'x': x,
			'y': y,
			"main_title": "Tourists per date",
			"x_title": "Dates",
			"y_title": "Tourists count",
			"filename": "hotels-date-tourists-count"
		}
	vizualizator.bar(**data)

	x, y = db_client.get_tourists_count_per_hotel()
	data = {
			'x': x,
			'y': y,
			"main_title": "Tourists per hotel",
			"x_title": "Hotels",
			"y_title": "Tourists count",
			"filename": "hotels-tourists-count"
		}
	vizualizator.bar(**data)

	data = {
		"filename": "hotels-tourists-sum",
		"labels": x,
		"values": y
	}
	vizualizator.pie(**data)
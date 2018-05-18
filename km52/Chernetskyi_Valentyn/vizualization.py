import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import plotly.dashboard_objs as dashboard
from plotly.tools import set_credentials_file


connstr = '{0}/{1}@127.0.0.1:1521/{2}'.format('username', 'password', 'db')
conn = cx_Oracle.connect(connstr)
cursor = self.conn.cursor()
set_credentials_file(username='username', api_key='api_key')


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
	customers_orders_sum = py.plot(fig, filename=filename)


def pie(labels, values, filename):
	pie = go.Pie(labels=labels, values=values)
	vendors_products_sum = py.plot([pie], filename=filename)


def get_tourists_per_date():
	query = """
		SELECT tourist.vacation_from, COUNT(tourist.tourist_id) as tourists
		FROM tourist
			GROUP BY tourist.vacation_from ORDER BY COUNT(tourist.vacation_from)
		"""
	dates = []
	tourists = []
	cursor.execute(query)
	for date, count in cursor:
		dates.append(date)
		tourists.append(count)
	return (dates, tourists)


def get_empty_room_count_per_hotel():
	query = """
		SELECT hotel.hotel__name, COUNT(rooms.hotel_id) as rooms_count
			FROM rooms JOIN hotel on rooms.hotel_id=hotel.hotel_id
				GROUP BY hotel.hotel__name ORDER BY COUNT(rooms_count.hotel_id)
		"""
	hotels = []
	rooms_count = []
	cursor.execute(query)
	for hotel, count in cursor:
		hotels.append(hotel)
		rooms_count.append(count)
	return (hotels, rooms_count)


if __name__ == '__main__':
	x, y = get_tourists_per_date()
	data = {
			'x': x,
			'y': y,
			"main_title": "Tourists per date",
			"x_title": "Dates",
			"y_title": "Tourists count",
			"filename": "hotels-date-tourists-count"
		}
	bar(**data)

	x, y = get_empty_room_count_per_hotel()
	data = {
			'x': x,
			'y': y,
			"main_title": "Tourists per hotel",
			"x_title": "Hotels",
			"y_title": "Tourists count",
			"filename": "hotels-empy_rooms-count"
		}
	bar(**data)

	data = {
		"filename": "hotels-rooms-sum",
		"labels": x,
		"values": y
	}
	pie(**data)
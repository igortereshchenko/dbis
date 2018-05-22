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

	def get_pages_per_book(self):
		query = """
			SELECT books.book_name, count(1) as pages_count
			FROM pages JOIN books
				GROUP BY pages.book_id ORDER BY COUNT(1)
			"""
		books = []
		pages = []
		self.cursor.execute(query)
		for book_name, count in self.cursor:
			books.append(book_name)
			pages.append(count)
		return (books, pages)

	def get_books_count_pages_per_author(self):
		query = """
			SELECT authors.author_name, count(1) as pages_count
			FROM authors JOIN books JOIN pages
				GROUP BY authors.author_id ORDER BY COUNT(1)
			"""
		authors = []
		pages = []
		self.cursor.execute(query)
		for name, count in self.cursor:
			authors.append(name)
			pages.append(count)
		return (authors, pages)


if __name__ == '__main__':
	db_client = DB_Wrapper(
			username='username',
			password='password',
			db='db_name',
			db_host='127.0.0.1',
			db_port=1521
		)
	vizualizator = Vizualizator(username='username', api_key='api_key')
	x, y = db_client.get_pages_per_book()
	data = {
			'x': x,
			'y': y,
			"main_title": "Pages per books",
			"x_title": "Dates",
			"y_title": "Tourists count",
			"filename": "books-pages-count"
		}
	vizualizator.bar(**data)

	x, y = db_client.get_books_count_pages_per_author()
	data = {
			'x': x,
			'y': y,
			"main_title": "Pages per author",
			"x_title": "Authors",
			"y_title": "Pages count",
			"filename": "authors-pages-count"
		}
	vizualizator.bar(**data)

	data = {
		"filename": "books-pages-count-sum",
		"labels": x,
		"values": y
	}
	vizualizator.pie(**data)

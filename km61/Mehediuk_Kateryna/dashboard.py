import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall(r"~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("Katia", "Katia", "xe")

cursor = connection.cursor()

""" create plot 1 """

cursor.execute("""
SELECT
    viewers.viewer_name || ' ' || viewers.viewer_surname,
    COUNT(cinema_session.ticket_number_fk)
FROM
    cinema_session INNER JOIN viewers ON cinema_session.viewer_id_fk = viewers.viewer_id
GROUP BY
    cinema_session.viewer_id_fk, 
    viewers.viewer_name,
    viewers.viewer_surname
""")

viewers = []
tickets = []

for row in cursor.fetchall():
    viewers.append(row[0])
    tickets.append(row[1])

data = [go.Bar(
    x = viewers,
    y = tickets
)]

fig = go.Figure(data=data)
tickets_per_person_url = py.plot(fig, filename = 'tickets-per-person')

""" create plot 2  """

cursor.execute("""
SELECT
    movies.movie_name,
    COUNT(cinema_session.ticket_number_fk)
FROM
    cinema_session INNER JOIN movies ON cinema_session.movie_id_fk = movies.movie_id
GROUP BY
    movies.movie_name
""");

movies = []
movie_tickets_count = []

for row in cursor.fetchall():
    movies.append(row[0]);
    movie_tickets_count.append(row[1]);

pie = go.Pie(labels=movies, values=movie_tickets_count)
movies_proportion_url = py.plot([pie], filename = 'movies-proportion')

""" create plot 3  """

cursor.execute("""
SELECT
    cinema_session.buy_date, COUNT(cinema_session.ticket_number_fk)
FROM
    cinema_session
GROUP BY
    cinema_session.buy_date
ORDER BY
    cinema_session.buy_date
""")

buy_dates = []
tickets_count = []

for row in cursor:
    buy_dates.append(row[0])
    tickets_count.append(row[1])

data = go.Scatter(
    x=buy_dates,
    y=tickets_count,
    mode='lines+markers'
)

ticket_buy_dates_url = py.plot([data], filename = 'tickets-buy-dates')

print(ticket_buy_dates_url)

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

tickets_per_person_id = fileId_from_url(tickets_per_person_url)
movies_proportion_id = fileId_from_url(movies_proportion_url)
ticket_buy_dates_id = fileId_from_url(ticket_buy_dates_url)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': tickets_per_person_id,
    'title': 'Tickets count per person'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': movies_proportion_id,
    'title': 'Movies cinema proportion'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': ticket_buy_dates_id,
    'title': 'Ticket buy dates'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')
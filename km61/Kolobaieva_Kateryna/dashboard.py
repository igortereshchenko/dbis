import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall(r"~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("kolobaieva", "kolobaieva", "xe")

cursor = connection.cursor()

""" create plot 1 """

cursor.execute("""
SELECT
    movie_name,
    movie_rating
FROM
    movies
""")

viewers = []
ratings = []

for row in cursor.fetchall():
    viewers.append(row[0])
    ratings.append(row[1])

data = [go.Bar(
    x = viewers,
    y = ratings
)]

fig = go.Figure(data=data)
ratings_url = py.plot(fig, filename = 'movies-rating')

""" create plot 2  """

cursor.execute("""
SELECT
    movies.movie_name,
    COUNT(watched_movies.review_id_fk)
FROM
    watched_movies INNER JOIN movies ON watched_movies.movie_id_fk = movies.movie_id
GROUP BY
    movies.movie_name
""");

movies = []
movie_reviews_count = []

for row in cursor.fetchall():
    movies.append(row[0]);
    movie_reviews_count.append(row[1]);

pie = go.Pie(labels=movies, values=movie_reviews_count)
movies_reviews_proportion_url = py.plot([pie], filename = 'reviews-count')

""" create plot 3  """

cursor.execute("""
SELECT
    reviews.review_date, COUNT(DISTINCT profiles.profile_id)
FROM
    profiles INNER JOIN watched_movies ON profiles.profile_id = watched_movies.profile_id_fk
    INNER JOIN reviews ON reviews.review_id = watched_movies.review_id_fk 
GROUP BY
    reviews.review_date
ORDER BY
    reviews.review_date
""")

review_dates = []
user_activity = []

for row in cursor:
    review_dates.append(row[0])
    user_activity.append(row[1])

data = go.Scatter(
    x=review_dates,
    y=user_activity,
    mode='lines+markers'
)

user_activity_url = py.plot([data], filename = 'user-review-activity')

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

ratings_id = fileId_from_url(ratings_url)
movies_reviews_proportion_id = fileId_from_url(movies_reviews_proportion_url)
user_activity_id = fileId_from_url(user_activity_url)

print()

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': ratings_id,
    'title': 'Movie ratings'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': movies_reviews_proportion_id,
    'title': 'Movies reviews proportion'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': user_activity_id,
    'title': 'User activity dates'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'Online cinema')
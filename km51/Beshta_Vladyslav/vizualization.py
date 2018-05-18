import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("Beshta", "beshta", "xe")

cursor = connection.cursor()

""" create plot 1   Вивести книжки та кількість рядків."""

cursor.execute("""
    SELECT
    book.book_id,
    COUNT(page_row.row_number) how_many_book_row
FROM
    book left
    JOIN book_page ON book.book_id = book_page.book_id
    LEFT JOIN page_row ON book_page.page_id = page_row.page_id
GROUP BY
    book.book_id""")

book = []
page_row = []

for row in cursor:
    print("Book: ", row[0], " has : ", row[1]," rows" )
    book += [row[0]]
    page_row += [row[1]]

data = [go.Bar(
    x=book,
    y=page_row
)]

layout = go.Layout(
    title='Count rows in books',
    xaxis=dict(
        title='Book',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Count rows',
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

page_row = py.plot(fig, filename='book-row')

""" create plot 2   Вивести книжки та кількість сторінок."""

cursor.execute("""
SELECT
    book.book_id,
    COUNT(book_page.page_number) how_many_book_page
FROM
    book left
    JOIN book_page ON book.book_id = book_page.book_id
GROUP BY
    book.book_id
""")

book = []
book_page = []

for row in cursor:
    print("Book id:", + row[0],  "has:" , + row[1],"rows")
    book += [ row[0]]
    book_page += [row[1]]

pie = go.Pie(labels=book , values=book_page)
book_page = py.plot([pie], filename='book-page')

""" create plot 3   Вивести кількість книжок випущенних відповідного року"""

cursor.execute("""
SELECT DISTINCT
    book.book_year,
    COUNT(book.book_id) how_many_book_in_this_year
FROM
    book
GROUP BY
    book.book_year
""")
book_year = []
count = []

for row in cursor:
    print("Date ", row[0], " count: ", row[1])
    book_year += [row[0]]
    count += [row[1]]

count_book_year = go.Scatter(
    x=book_year,
    y=count,
    mode='lines+markers'
)
data = [count_book_year]
count_book_year_url = py.plot(data, filename='Book in this year')

"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

page_row_id = fileId_from_url(page_row)
book_page_id = fileId_from_url(book_page)
count_book_year_id = fileId_from_url(count_book_year_url)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': page_row_id,
    'title': 'Count rows from book'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': book_page_id,
    'title': 'Count pages from book'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': count_book_year_id,
    'title': 'Book in this year'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')
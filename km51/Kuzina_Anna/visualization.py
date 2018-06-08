import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


connection = cx_Oracle.connect("ann", "ann", "xe")

cursor = connection.cursor()

""" create plot 1   Вивести назву книги та кількість сторінок ."""

cursor.execute("""
SELECT
    books.book_id,
    books.book_name,
    COUNT(BOOKS_HAVE_PAGES.page_id)
FROM
    books LEFT JOIN BOOKS_HAVE_PAGES
    on books.book_id = BOOKS_HAVE_PAGES.book_id
 GROUP BY books.book_id, books.book_name
    """)

BOOK_NAME = []
COUNT_PAGES = []

for row in cursor:
    print("Book name: ", row[1], " and quantity pages: ", row[2])
    BOOK_NAME += [row[1]]
    COUNT_PAGES += [row[2]]

data = [go.Bar(
    x=BOOK_NAME,
    y=COUNT_PAGES
)]

layout = go.Layout(
    title='Book name and quantity pages',
    xaxis=dict(
        title='Book name',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Quantity pages',
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

Book_name_quantity_pages = py.plot(fig, filename='Book_name-quantity_pages', auto_open=False)


""" create plot 2   Вивести назву книги, номер сторінки та кількість рядків."""

cursor.execute("""
SELECT
    books.book_id,
    books.book_name,
    PAGES.PAGE_ID,
    PAGES.PAGE_NUMBER,
    COUNT(PAGES_HAVE_ROWS.ROW_ID)
FROM
    books JOIN BOOKS_HAVE_PAGES
    on books.book_id = BOOKS_HAVE_PAGES.book_id
    
    LEFT JOIN PAGES_HAVE_ROWS
    ON BOOKS_HAVE_PAGES.PAGE_ID = PAGES_HAVE_ROWS.PAGE_ID
    
    LEFT JOIN PAGES
    ON PAGES_HAVE_ROWS.PAGE_ID = PAGES.PAGE_ID
    
 GROUP BY books.book_id, books.book_name, PAGES.PAGE_ID, PAGES.PAGE_NUMBER
    
""");

book_name = []
quantity_rows = []

for row in cursor:
    print("Book name ", row[1], " number pages", row[3], " and quantity rows: ", row[4])
    book_name.append(str(row[1]) + ", page " + str(row[3]))
    quantity_rows += [row[4]]

layout = go.Layout(title='Book name, number pages and quantity rows')


pie = [go.Pie(labels=book_name, values=quantity_rows)]
fig = go.Figure(data=pie, layout=layout)
Book_name_pages_quantity_rows = py.plot(fig, filename='vendors-products-sum', auto_open=False)


""" create plot 3   Вивести рік видачі книги та кількість виданих книг за цей рік """

cursor.execute("""
SELECT
    books.BOOK_YEAR,
    COUNT(books.BOOK_ID)
FROM
    books 
     GROUP BY books.BOOK_YEAR
ORDER BY books.BOOK_YEAR
""")

BOOK_YEAR = []
COUNT_BOOK_ID = []

for row in cursor:
    print("Year ", row[0], " count: ", row[1])
    BOOK_YEAR += [row[0]]
    COUNT_BOOK_ID += [row[1]]

year_quantity_book = go.Scatter(
    x=BOOK_YEAR,
    y=COUNT_BOOK_ID,
    mode='lines+markers'
)
data = [year_quantity_book]

layout = go.Layout(title='Year of issue and quantity of books')

pie = [go.Pie(labels=BOOK_YEAR, values=COUNT_BOOK_ID)]
fig = go.Figure(data=data, layout=layout)

year_quantity_book = py.plot(fig, filename='Year of issue and quantity of books', auto_open=False)






"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

Book_name_quantity_pages_id = fileId_from_url(Book_name_quantity_pages)
Book_name_pages_quantity_rows_id = fileId_from_url(Book_name_pages_quantity_rows)
year_quantity_book_id = fileId_from_url(year_quantity_book)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': Book_name_quantity_pages_id,
    'title': 'Book names and quantity pages'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': Book_name_pages_quantity_rows_id,
    'title': 'Books name, number pages and quantity rows'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': year_quantity_book_id,
    'title': 'Year of issue and quantity of books'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')
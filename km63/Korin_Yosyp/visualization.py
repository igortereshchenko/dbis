import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
 
connection = cx_Oracle.connect ('system/yopes1999@192.168.1.103/xe')
 
cursor = connection.cursor()
 
 
 
""" create plot 1   Вивести користувачів та кількість новин що кожен з них прочитав."""
 
cursor.execute("""
SELECT
    users.user_id,
    rtrim(users.user_name) u_name,
    COUNT(users_news.news_id_fk)
FROM
    users left
    JOIN users_news ON users.user_id = users_news.user_id_fk
GROUP BY
    users.user_id,
    users.user_name """)
user = []
count_read_news = []

for row in cursor:
	print("User name: ",row[1], "count red news: ", row[2])
	user += [str(row[0])+""+row[1]]
	count_read_news += [row[2]]
	
data = [go.Bar(x=user, y=count_read_news)]	

layout = go.Layout(
    title='Users and red news',
    xaxis=dict(
        title='Users',
        titlefont=dict(
            family='Courier New, monospace',
            size=20,
            color='#aaa'
        )
    ),
    yaxis=dict(
        title='count news',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=20,
            color='#aaa'
        )
    )
)
figure = go.Figure(data=data, layout=layout)
 
users_red_news = py.plot(figure, filename='users red news')
 
""" create plot 2   Вивести новини та % їх в загальній кількості прочитаних."""
 
 
cursor.execute("""
SELECT
    news.news_id,
    rtrim(news.news_heder) head_news,
    COUNT(news.news_id) news_count
FROM
    news left
    JOIN users_news ON news.news_id = users_news.news_id_fk
GROUP BY
    news.news_id, news.news_heder
""");
news = []
news_count = []

for row in cursor:
	print('News with header: ',row[1],' id(',row[0],')', ' number of red', row[2])
	news += [row[1]+""+str(row[0])]
	news_count += [row[2]]
	
pie = go.Pie(labels = news, values=news_count )
news_news_count = py.plot([pie], filename='news count')	
 
 
""" create plot 3   Вивести динаміку поблікування новин """
 
 
cursor.execute("""
SELECT
    ORDERS.ORDER_DATE,
    NVL(SUM(ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE),0) as PRODUCTS_PRICE
 FROM
    ORDERS LEFT JOIN ORDERITEMS
        ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    GROUP BY ORDERS.ORDER_DATE
    ORDER BY  ORDERS.ORDER_DATE
""")
cursor.execute("""
SELECT
    news.publish,
    COUNT(news.news_id)
FROM
    news left
    JOIN users_news ON news.news_id = users_news.news_id_fk
GROUP BY
    news.publish
ORDER BY
    news.publish
""")

publish_dates = []
count_published_news = []

for row in cursor:
	print('Data',row[0],'count news publish', row[1])
	publish_dates += [row[0]]
	count_published_news += [row[1]]
	
publish_dates_count = go.Scatter(
	x=publish_dates,
	y=count_published_news,
	mode='lines+markers'
)
data = [publish_dates_count]
count_news_publish = py.plot(data, filename='count news by publish')
 
 
"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
users_red_news_id = fileId_from_url(users_red_news)
news_news_count_id = fileId_from_url(news_news_count)
count_news_publish_id = fileId_from_url(count_news_publish)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': users_red_news_id,
    'title': 'Users and count of News'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': news_news_count_id,
    'title': 'Count of news and persent of news'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': count_news_publish_id,
    'title': 'Count of news and dinymics of publishing'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'homework visualization')
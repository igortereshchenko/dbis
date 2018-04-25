import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


class OracleDB:

    def __init__(self, ip="localhost", database="orcl", username="sys", password=""):
        self._connection_string = "{0}/{1}@{2}/{3}".format(username, password, ip, database)
        self._connection = cx_Oracle.connect(self._connection_string)
        self._cursor = self._connection.cursor()

    def execute(self, request):
        self._cursor.execute(request)
        return self._cursor.fetchall()


db = OracleDB(ip="127.0.0.1", database="main", username="akvtn", password="akvtn")

# CUSTOMER AND TOTAL SUM OF CARS BOUGHT BY HIM
cars_sum = db.execute("""SELECT TRIM(citizens.citizen_first_name) || ' ' || TRIM(citizens.citizen_second_name),
                            SUM(cars.car_price)
                     FROM citizens JOIN citizencar ON citizencar.citizen_id_fk = citizens.citizen_id
                                   JOIN cars ON citizencar.car_id_fk = cars.car_id
                     GROUP BY citizen_id, TRIM(citizens.citizen_first_name) || ' ' || TRIM(citizens.citizen_second_name)""")

customers = []
car_sum = []

for row in cars_sum:
    customers.append(row[0])
    car_sum.append(row[1])

data = [go.Bar(x=customers, y=car_sum)]

layout = go.Layout(
    title='Customers and Orders sum',
    xaxis=dict(
        title='Customers',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Cars price',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    )
)
figure = go.Figure(data=data, layout=layout)

customers_cars_price_plot = py.plot(figure, filename="customer-cars-price")

# CITIZEN AND % OF AREA OWNED BY HIM COMPARING TO OTHERS
citizen_house_area = db.execute("""SELECT TRIM(citizens.citizen_first_name) || ' ' || TRIM(citizens.citizen_second_name),
                            sum(houses.house_area)
                     FROM citizens JOIN citizenhouse ON citizens.citizen_id = citizenhouse.citizen_id_fk
                                   JOIN houses ON citizenhouse.house_id_fk = houses.house_id
                     GROUP BY citizen_id, TRIM(citizens.citizen_first_name) || ' ' || TRIM(citizens.citizen_second_name) """)

citizens = []
area = []

for row in citizen_house_area:
    citizens.append(row[0])
    area.append(row[1])

pie = go.Pie(labels=citizens, values=area)
citizen_house_area_plot = py.plot([pie], filename="citizen_house_area")

# DYNAMIC OF PURCHASE OF CARS BY MONTHS
months_purchases = db.execute(""" SELECT EXTRACT(month FROM purchase_date),
                              count(car_id_fk)
                       FROM citizencar
                       GROUP BY EXTRACT(month FROM purchase_date)
                       ORDER BY EXTRACT(month FROM purchase_date)""")

months = []
purchases = []

for row in months_purchases:
    months.append(row[0])
    purchases.append(row[1])

month_purchases = go.Scatter(
    x=months,
    y=purchases,
    mode='lines+markers'
)
data = [month_purchases]
month_car_purchase_plot = py.plot(data, filename="Purchases per month")

dboard = dashboard.Dashboard()

customers_cars_price_id = fileId_from_url(customers_cars_price_plot)
citizen_house_area_id = fileId_from_url(citizen_house_area_plot)
month_car_purchase_id = fileId_from_url(month_car_purchase_plot)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': customers_cars_price_id,
    'title': 'Customers and Cars prices'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': citizen_house_area_id ,
    'title': 'Citizen and house area owned'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': month_car_purchase_id,
    'title': 'Month car purchase'
}

dboard.insert(box_1)
dboard.insert(box_2, "below", 1)
dboard.insert(box_3, "below", 2)

py.dashboard_ops.upload(dboard, 'Dashboard with Oracle')


'''
RESULT:
https://plot.ly/dashboard/fennessy:10/view?share_key=cPrwkupGWL22VAuPhEkOAT
'''
import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import plotly.dashboard_objs as dashboard
import re


def fileid_from_url(url):
    """Return fileId from a url."""
    raw_fileid = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileid.replace('/', ':')

# For each country output how much films this country made
connection = cx_Oracle.connect("BlindProrok", "prorok2000", "User-PC/XE")

cursor = connection.cursor()

cursor.execute("""SELECT TRIM(Countries.Country), COUNT(Films.Title)
FROM Countries
LEFT OUTER JOIN Film_country ON Countries.Country = Film_country.Country
LEFT OUTER JOIN Films ON Film_country.Title = Films.Title
GROUP BY TRIM(Countries.Country)""")

countries = []
films_amount = []

for row in cursor:
    print("Country: %s  Amount of films: %s" % (row[0], row[1]))
    countries.append(row[0])
    films_amount.append(row[1])

data = [go.Bar(
    x=countries,
    y=films_amount
)]

layout = go.Layout(
    title='Countries and amount of their films',
    xaxis=dict(
        title='Countries',
        titlefont=dict(
            family='Courier New, monospace',
            size=16,
            color='#747474'
        )
    ),
    yaxis=dict(
        title='Films_amount',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=16,
            color='#747474'
        )
    )
)

fig = go.Figure(data=data, layout=layout)

countries_films_amount_url = py.plot(fig, filename='countries-films-amount-url')


# Output amount of viewed films for each client relatively to viewed films of other clients

cursor.execute("""SELECT TRIM(Client_first_name)||' '||TRIM(Client_last_name) Client_name, Films_amount
FROM(
    SELECT Client_first_name, Client_last_name, COUNT(*) Films_amount
    FROM Clients
    LEFT OUTER JOIN Seances ON (Clients.First_name = Seances.Client_first_name AND
                                Clients.Last_name = Seances.Client_last_name)
    GROUP BY Client_first_name, Client_last_name
)""")

clients = []
films_amount = []

for row in cursor:
    print("Client: %s   Films_amount: %s" % (row[0], row[1]))
    clients.append(row[0])
    films_amount.append(row[1])

pie = go.Pie(labels=clients, values=films_amount)
clients_films_amount_url = py.plot([pie], filename='clients-films-amount-url')


# Output the dynamic of viewers per date

cursor.execute("""SELECT Seance_date, COUNT(*) Clients_amount
FROM Seances
GROUP BY Seance_date""")

dates = []
clients_amount = []

for row in cursor:
    print("Date: %s    Clients_amount %s" %(row[0], row[1]))
    dates.append(row[0])
    clients_amount.append(row[1])

dates_clients_amount = go.Scatter(
    x=dates,
    y=clients_amount,
    mode='lines+markers'
)

data = [dates_clients_amount]
dates_clients_amount_url = py.plot(data, filename='dates-clients-amount-url')

# create dashboard

dboard = dashboard.Dashboard()

countries_films_amount_id = fileid_from_url(countries_films_amount_url)
clients_films_amount_id = fileid_from_url(clients_films_amount_url)
dates_clients_amount_id = fileid_from_url(dates_clients_amount_url)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': countries_films_amount_id,
    'title': 'Countries and films amount'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': clients_films_amount_id,
    'title': 'Clients and films amount'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': dates_clients_amount_id,
    'title': 'Amount of clients per date'
}

dboard.insert(box_1)
dboard.insert(box_2, 'below', 1)
dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(dboard, 'My First Dashboard With Python')
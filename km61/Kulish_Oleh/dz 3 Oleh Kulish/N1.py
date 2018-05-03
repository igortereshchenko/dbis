
import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
connection = cx_Oracle.connect("system", '123456', 'DESKTOP-R9NH18C/xe')
cursor = connection.cursor()
cursor.execute("""select * from buyers""")
customers = []
orders_sum = []
for row in cursor:
    print("Customer name: ", row[0], " and his order sum: ", row[1])
    customers += [row[0] + row[1]]
    orders_sum += [row[1]]
    data = [go.Bar(
        x=customers,
        y=orders_sum
    )]
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
            title='Orders sum',
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
    customers_orders_sum = py.plot(fig)


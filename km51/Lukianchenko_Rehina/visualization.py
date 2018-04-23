import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')

connection = cx_Oracle.connect("luk", "luk", "xe")

cursor = connection.cursor()


cursor.execute("""
SELECT
    COMPUTER.COMPUTER_CODE,
    COUNT(OPERATION_SYSTEM
    || ' '
    || OS_VERSION)
FROM
    COMPUTER
    LEFT  JOIN COMPUTER_HAS_SOFTWARE ON COMPUTER.COMPUTER_CODE = COMPUTER_HAS_SOFTWARE.COMPUTER_CODE
GROUP BY
    COMPUTER.COMPUTER_CODE
""")

computers = []
os_count = []

for row in cursor:
    print("Computer: ", row[0], " and quantity of os: ", row[1])
    computers += [row[0]]
    os_count += [row[1]]

data = [go.Bar(
        x=computers,
        y=os_count
    )]

layout = go.Layout(
        title='Computers and their quantity of os',
        xaxis=dict(
            title='Computers',
            titlefont=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        ),
        yaxis=dict(
            title='Quantity of os',
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

computer_os = py.plot(fig, filename='computer_os_quantity', auto_open=False)



cursor.execute("""
SELECT
    computer.computer_code,
    (OPERATION_SYSTEM
    || ' '
    || OS_VERSION),
    unistall_date - install_date
FROM
    computer
    LEFT  JOIN computer_has_software ON computer.computer_code = computer_has_software.computer_code
WHERE unistall_date IS  NOT NULL

UNION 

SELECT
    computer.computer_code,
      (OPERATION_SYSTEM
    || ' '
    || OS_VERSION),
    TO_DATE(current_date, 'DD.MM.YY') - install_date
FROM
    computer
    LEFT  JOIN computer_has_software ON computer.computer_code = computer_has_software.computer_code,
    SYS.dual 
WHERE unistall_date IS NULL


""")

computers = []
days_from_install = []

for row in cursor:
    print("Computer ", row[0] + ", and his his quantity of days" , row[2], " with os: " + row[1])
    computers+= [row[0]+" "+row[1]]

    days_from_install+= [row[2]]

pie = go.Pie(labels=computers, values=days_from_install)

computer_os_days = py.plot([pie], filename='computer_os_days_quantity', auto_open=False)

cursor.execute("""
SELECT
    build_date,
    COUNT(*)
 FROM
   computer_has_hardware 
    GROUP BY build_date
    ORDER BY build_date

""")
build_dates = []
computer_count= []

for row in cursor:
    print("Date ", row[0], " count of computers: ", row[1])
    build_dates += [row[0]]
    computer_count += [row[1]]

order_date_prices = go.Scatter(
    x=build_dates,
    y=computer_count,
    mode='lines+markers'
)
data = [order_date_prices]

computers_date = py.plot(data, filename='computers_quantity_date', auto_open=False)



"""--------CREATE DASHBOARD------------------ """

my_dboard = dashboard.Dashboard()

computer_os_id = fileId_from_url(computer_os)
computer_os_days_id = fileId_from_url(computer_os_days)
computers_date_id = fileId_from_url(computers_date)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': computer_os_id,
    'title': 'Customers and Orders sum'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': computer_os_days_id,
    'title': 'Customers and Orders sum'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': computers_date_id,
    'title': 'Orders price by date'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, 'My First Dashboard with Python')




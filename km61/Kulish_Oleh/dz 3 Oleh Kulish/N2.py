import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
connection = cx_Oracle.connect("system", '123456', 'DESKTOP-R9NH18C/xe')
cursor = connection.cursor()
cursor.execute("""select buyer_id, order_amount from buyers""")

data = []
for i in cursor:
    data.append(i)

sum = 0
for i in range(len(data)):
    sum += data[i][1]

user_list = []
for i in data:
    user_list.append(i[0])
user_list = set(user_list)

customers = []
orders_sum = []

for i in user_list:
    sum2 = 0
    for j in range(i, len(data) - 1):
        if data[i][0] == data[j][0]:
            sum2 += data[j][1]
    customers += [i]
    orders_sum += [sum2 / sum * 100]

pie = go.Pie(labels=vendors, values=products_sum)

py.plot([pie])


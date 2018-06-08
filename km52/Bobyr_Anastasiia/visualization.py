import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
 
connection = cx_Oracle.connect("Bobyr", "Bobyr", "localhost:1521/xe")
 
cursor = connection.cursor()
 
 
 
""" create plot 1   Вивести наявні медичні картки та кількість записів у кожній з них."""
 
cursor.execute("""
select
    medicalcard.card_id,
    count(records.record_id) as Count_of_records
from
    medicalcard left join records on medicalcard.card_id = records.card_id
group by medicalcard.card_id """)
 
cards = []
records_count = []
 
 
for row in cursor:
    print("Medical card id: ",row[0]," and count of its records: ",row[1])
    cards += [row[0]]
    records_count += [row[1]]
 
 
data = [go.Bar(
            x=cards,
            y=records_count,
			marker=dict(
                color='rgb(158,202,225)',
                line=dict(
                    color='rgb(8,48,107)',
                    width=1.5),
            ),
            opacity=0.6
    )]
 
layout = go.Layout(
    title='Records count in each card',
    xaxis=dict(
        title='Cards',
		dtick=1,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Records count',
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
 
cards_records_count = py.plot(fig, filename='cards-records-count')
 
 
""" create plot 2   Вивести ім'я пацієнта та % його звернень до лікарів відносно усіх звернень."""
 
 
cursor.execute("""
select
    human_name,
    Count_of_records
from
(select
    human.human_id,
    human.human_name,
    medicalcard.card_id,
    count(records.record_id) as Count_of_records
from
    human join medicalcard on human.human_id = medicalcard.human_id
    left join records on medicalcard.card_id = records.card_id
group by human.human_id, human.human_name, medicalcard.card_id)

""");
 
human = []
visits_count = []
 
 
for row in cursor:
    print("Human name ",row[0]," and count of his visits to doctor: ",row[1])
    human += [row[0]]
    visits_count += [row[1]]
 
 
 
pie = go.Pie(labels=human, values=visits_count)
human_visits_count = py.plot([pie], filename='human-visits-count')
 
 
""" create plot 3   Вивести динаміку звернень до лікарів по датах"""
 
cursor.execute("""
select 
records.record_date,
count(records.record_id)
from records
group by records.record_date
order by records.record_date
""")
visit_dates = []
recordsday_count = []
 
 
for row in cursor:
    print("Date ",row[0]," Count of records: ",row[1])
    visit_dates += [row[0]]
    recordsday_count += [row[1]]
 
 
visit_date_count = go.Scatter(
    x=visit_dates,
    y=recordsday_count,
    mode='lines+markers'
	
)
data = [visit_date_count]


layout = go.Layout(
    title='Count of records during each day',
    xaxis=dict(
        title='Date',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),

    yaxis=dict(
        title='Count of records',
		tick0=0,
		zeroline=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    )
)
fig = go.Figure(data=data, layout=layout)

visit_date_count_url=py.plot(fig, filename='visit-date-count')
 
 
"""--------CREATE DASHBOARD------------------ """
    
 
my_dboard = dashboard.Dashboard()
 
cards_records_count_id = fileId_from_url(cards_records_count)
human_visits_count_id = fileId_from_url(human_visits_count)
visit_date_count_id = fileId_from_url(visit_date_count_url)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': cards_records_count_id,
    'title': 'Records count in each card'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': human_visits_count_id,
    'title': 'Human names and count of their visits to doctor'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': visit_date_count_id,
    'title': 'Count of records during each day'
}
 
 
my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)
 
 
 
py.dashboard_ops.upload(my_dboard, 'Human has a Medical card')
 
 
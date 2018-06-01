import cx_Oracle
import plotly.offline as py
import plotly.graph_objs as go
from plotly.tools import set_credentials_file


connstr = '{0}/{1}@127.0.0.1:1521/{2}'.format('SYSTEM', 'josephlouis', 'xe')
connection = cx_Oracle.connect(connstr)
set_credentials_file(username='username', api_key='api_key')
cursor = connection.cursor()

query = """
    SELECT
        Students.stud_name,
        NVL(COUNT(Note.note_num), 0) as note_sum
     FROM
        Students LEFT JOIN Notebooks
            ON Students.stud_id= Notebooks.stud_id
        LEFT JOIN Notes
            ON Notebooks.notebook_id = Notes.notebook_id
    GROUP BY Students.stud_name
"""

cursor.execute(query)

student = []
notes_sum = []

for student, column_sum in cursor:
    student.append(student)
    notes_sum.append(column_sum)

data = [go.Bar(
    x=student,
    y=notes_sum
)]

layout = go.Layout(
    title='Student and Notes sum',
    xaxis=dict(
        title='Student',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Notes sum',
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
customers_notes_sum = py.plot(fig)


query = "SELECT note_date, COUNT(note_num) FROM Notes GROUP BY note_date"

cursor.execute(query)

note_dates = []
notes_count = []

for note_date, note_count in cursor:
    note_dates.append(note_date)
    notes_count.append(note_count)

data = [go.Bar(
    x=note_dates,
    y=notes_count
)]

layout = go.Layout(
    title='Notes per date',
    xaxis=dict(
        title='Dates',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Note count',
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
customers_notes_sum = py.plot(fig)


cursor.execute("""
SELECT
    TRIM(SUBJECT.SUBJECT_NAME),
    NVL(COUNT(NOTES.NOTE_ID),0) as NOTES_SUM
 FROM
    SUBJECT LEFT JOIN NOTEBOOKS
        ON SUBJECT.SUBJECT_ID = NOTEBOOKS.SUBJECT_ID
    LEFT JOIN NOTES
        ON NOTEBOOKS.NOTEBOOKS_ID = NOTES.NOTEBOOKS_ID
    GROUP BY SUBJECT.SUBJECT_NAME
""");

subjects = []
note_sums = []

for subject, note_sum in cursor:
    subjects.append(subject)
    notes_sum.append(note_sum)

pie = go.Pie(labels=subjects, values=note_sums)
py.plot([pie])





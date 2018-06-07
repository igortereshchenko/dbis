import cx_Oracle
import plotly.plotly as py
import plotly.graph_objs as go
import re
import plotly.dashboard_objs as dashboard
 
 
def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1: ]
    return raw_fileId.replace('/', ':')
 
connection = cx_Oracle.connect("SYSTEM", "qwerty13", "localhost:1521/xe")
 
  
cursor = connection.cursor()
 

 
""" create plot 1   Вивести лікарів та кількість прийомів хворих"""

cursor.execute("""
 SELECT
    TRIM(doctors.lisence),
	TRIM(doctors.surname),
    NVL(count(patientcard.patient_surname),0) as patient_count
 FROM
    patientcard JOIN doctors
        ON patientcard.doctor_license = doctors.lisence
     JOIN patient
        ON  patient.surname=patientcard.patient_surname
    GROUP BY doctors.lisence, doctors.surname """);
 
doctors = []
patient_count = []
 
 
for row in cursor:
    print("Doctor surname: ",row[1]," and his patient sum: ",row[2])
    doctors += [row[1]]
    patient_count += [row[2]]
 
 
data = [go.Bar(
            x=doctors,
            y=patient_count
    )]
 
layout = go.Layout(
    title='Doctors and patients count',
    xaxis=dict(
        title='Doctors',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Patients count',
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
 
doctors_patient_count = py.plot(fig, filename='Doctors and count of patients')
 
 
""" create plot 2   Вивести лікаря та відсоток його прийомів"""
 
 
cursor.execute("""
SELECT
    TRIM(doctors.lisence),
	TRIM(doctors.surname),
    NVL(count(patientcard.patient_surname),0) as patient_percent
 FROM
    patientcard JOIN doctors
        ON patientcard.doctor_license = doctors.lisence
     JOIN patient
        ON  patient.surname=patientcard.patient_surname
    GROUP BY doctors.lisence, doctors.surname """)

doctors = []
patient_percent = []
 
 
for row in cursor:
    print("Doctor surname: ",row[1]," and his patient percent: ",row[2])
    doctors += [row[1]]
    patient_percent += [row[2]]
 
 
 
pie = go.Pie(labels=doctors, values=patient_percent)
doctor_patient_percent = py.plot([pie], filename='Doctor and his appointment percent')
 
""" create plot 3   Вивести кількість звернень до лікарів по датах"""
 
 
cursor.execute("""
SELECT
    patientcard.appointment,
    NVL(count(patientcard.patient_surname),0) as patient_count
 FROM
    patientcard JOIN doctors
        ON patientcard.doctor_license = doctors.lisence
     JOIN patient
        ON  patient.surname=patientcard.patient_surname
    GROUP BY patientcard.appointment
    ORDER BY  patientcard.appointment
""")
dates = []
patients = []
 
 
for row in cursor:
    print("Date ",row[0]," count: ",row[1])
    dates += [row[0]]
    patients += [row[1]]
 
 
date_patients= go.Scatter(
    x=dates,
    y=patients,
    mode='lines+markers'
)
data = [date_patients]
date_patient=py.plot(data, filename='Appointments by date')
 
 
"""--------CREATE DASHBOARD------------------ """
    
 
my_board = dashboard.Dashboard()
 
doctors_patient_count_id = fileId_from_url(doctors_patient_count)
doctor_patient_percent_id = fileId_from_url(doctor_patient_percent)
date_patient_id = fileId_from_url(date_patient)
 
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': doctors_patient_count_id,
    'title': 'Doctors and count of his patients'
}
 
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': doctor_patient_percent_id,
    'title': 'Doctor and his percent of patients'
}
 
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': date_patient_id,
    'title': 'Appointments by date'
}
 
 
my_board.insert(box_1)
my_board.insert(box_2, 'below', 1)
my_board.insert(box_3, 'below', 2)
 
 
 
py.dashboard_ops.upload(my_board, 'My First Dashboard')
 
 

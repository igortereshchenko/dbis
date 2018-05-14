import csv

import cx_Oracle

connection = cx_Oracle.connect("luk", "luk", "xe")

filename = "computer_8468AA71-7916-4FDF-A680-E9FER4EFD4F4.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)

    code = next(reader)[1]
    mac_adress = next(reader)[1]

    insert_query = "insert into computer(computer_code, computer_mac_adress) values (:computer_code, :computer_mac_adress)"
    cursor_computer = connection.cursor()
    cursor_computer.execute(insert_query, computer_code=code, computer_mac_adress=mac_adress)
    cursor_computer.close()

    connection.commit()

    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO computer_has_hardware (cpu_code, psu_code,  build_date, computer_code) VALUES (:cpu_code, :psu_code,  TO_DATE(:build_date,'yyyy.mm.dd'), :computer_code)"
    cursor_computer_hardware = connection.cursor()

    cursor_computer_hardware.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [code])

    cursor_computer_hardware.executemany(None, rows)

    cursor_computer_hardware.close()
    connection.commit()
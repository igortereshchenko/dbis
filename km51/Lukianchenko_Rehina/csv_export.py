import csv
import cx_Oracle

connection = cx_Oracle.connect("luk", "luk", "xe")

cursor_computer = connection.cursor()

cursor_computer.execute("""
        SELECT
            TRIM(computer_code) AS computer_code,
            TRIM(computer_mac_adress) AS computer_mac_adress
        FROM
            computer""")

for computer_code, computer_mac_adress in cursor_computer:
    with open("computer_" + computer_code + ".csv", "w", newline="") as file:
        writer = csv.writer(file)

        writer.writerow(["Code", computer_code])
        writer.writerow(["Mac adress", computer_mac_adress])

        cursor_computer_hardware = connection.cursor()

        query = """
            SELECT
                cpu_code,
                psu_code,
                TO_CHAR(build_date,'yyyy.mm.dd')
            FROM
                computer
                NATURAL JOIN computer_has_hardware
            WHERE
                TRIM(computer_code) = :id"""

        cursor_computer_hardware.execute(query, id=computer_code)
        writer.writerow([])
        writer.writerow(["Cpu code ", "Psu code ", "Build date "])
        for computer_hardware_row in cursor_computer_hardware:
            writer.writerow(computer_hardware_row)

cursor_computer.close()
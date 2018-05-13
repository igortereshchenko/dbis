#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 13 13:40:20 2018

@author: anatoliy
"""
import csv
import cx_Oracle
import pandas as pd


user_name = 'reviwe_ihor'
password = 'password'
server = 'xe'

connection = cx_Oracle.connect(user_name, password, server)

sql_owners = '''
SELECT
    owner_name,
    owner_passport
FROM
    owner
'''

sql_owners_computers = '''
SELECT
    mac_address,
    comp_name
FROM
    owner
    JOIN computer ON computer.owner_owner_passport = :passport
                     AND owner.owner_passport = :passport
'''

owners = pd.read_sql_query(sql_owners, connection)

for owner_name, owner_passport in owners.values:
    with open("owner_" + owner_passport + ".csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["Passport", owner_passport])
        writer.writerow(["Name", owner_name])

        owners_computers = pd.read_sql_query(
            sql_owners_computers, connection, params={
                'passport': owner_passport})
        writer.writerow([])
        writer.writerow(["Mac address", "Computer name"])

        for computer_row in owners_computers.values:
            writer.writerow(computer_row)

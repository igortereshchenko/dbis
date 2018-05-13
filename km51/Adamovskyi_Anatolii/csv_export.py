#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 13 15:13:44 2018

@author: anatoliy
"""
import cx_Oracle
import pandas as pd

user_name = 'reviwe_ihor'
password = 'password'
server = 'xe'

connection = cx_Oracle.connect(user_name, password, server)

filename = 'owner_DF32482349.csv'

owner = pd.read_csv(filename, names=['key', 'value'], nrows=2).T
owner = pd.DataFrame([list(owner.loc['value'])], columns=[
                     'owner_passport', 'owner_name'])

computer = pd.read_csv(filename, skiprows=2)
computer.columns = ['mac_address', 'comp_name']

insert_query = '''
INSERT INTO owner (
    owner_name,
    owner_passport
) VALUES (
    :owner_name,
    :owner_passport
)'''
cursor_owner = connection.cursor()
cursor_owner.execute(insert_query,
                     owner_name=owner.owner_name[0],
                     owner_passport=owner.owner_passport[0][:-1] + '0')
cursor_owner.close()


insert_query = '''
INSERT INTO computer (
    mac_address,
    comp_name,
    owner_owner_passport
) VALUES (
    :mac_address,
    :comp_name,
    :owner_owner_passport
)
'''
cursor_computer = connection.cursor()
cursor_computer.prepare(insert_query)


rows = []
for row in computer.values:
    rows.append(list(row) + [owner.owner_passport[0][:-1] + '0'])

cursor_computer.executemany(None, rows)

cursor_computer.close()
connection.commit()

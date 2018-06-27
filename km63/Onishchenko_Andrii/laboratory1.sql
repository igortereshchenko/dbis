/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлення даних у таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER onishchenko IDENTIFY BY onishchenko;
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ALTER USER onishchenko QUOTE 100M ON USERS;
GRANT "CONNECT" TO onishchenko
GRANT SELECT ANY TABLE TO onsihchenko
GRANT UPDATE ANY TABLE TO onsihchenko








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент вивчає мови програмування.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE table1 ( table1_name VARCHAR2(30) NOT NULL);
ALTER TABLE table1
ADD CONSTRAINT table1_name_pk PRIMARY KEY (table1_name);

CREATE TABLE table2 ( table2_name VARCHAR2(30) NOT NULL);
ALTER TABLE table2
ADD CONSTRAINT table2_name_pk PRIMARY KEY (table2_name);

CREATE TABLE tablex (
tablex1_name VARCHAR(30) NOT NULL
tablex2_name VARCHAR(30) NOT NULL
tablenumbers NUMBER(8,3) NOT NULL
);

ALTER TABLE tablex 
ADD CONSTRAINT table_pk PRIMARY KEY  (table1_name_pk, table2_name_pk)

ALTER TABLE tablex 
ADD CONSTRAINT tablex1_name_fk FOREIGN KEY (tablex1_name) REFERENCES table1(table1_name_pk)


ALTER TABLE tablex
ADD CONSTRAINT tablex2_name_fk FOREIGN KEY (tablex2_name) REFERENCES table2(table2_name_pk)














  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO onsichenko;





/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав  не найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що мають поштову адресу та не живуть в USA, у верхньому регістрі - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар з найбільшою ціною.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


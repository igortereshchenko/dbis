-- LABORATORY WORK 1
-- BY Riasyk_Ihor
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлювати дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER Riasyk 
IDENTIFIED BY goodpasswordnet
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER Riasyk QUOTA 100M ON USERS;

GRANT CONNECT TO Riasyk;
GRANT SELECT ANY TABLE TO Riasyk;
GRANT UPDATE ANY TABLE TO Riasyk;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На вулиці стоїть будинок, що має 10 квартир.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE street
( name_of_street varchar2(40) NOT NULL);
ALTER TABLE street ADD CONSTRAINT street_key PRIMARY KEY name_of_street;

CREATE TABLE bydunok
( kilkictb_kvartir number(3,0) NOT NULL);
ALTER TABLE bydunok ADD CONSTRAINT kilkictb_kvartir_key PRIMARY KEY kilkictb_kvartir;

CREATE TABLE street_bydunok
( name_of_street_after varchar2(40) NOT NULL
  kilkictb_kvartir_after number(3,0) NOT NULL
  column_name varchar2(20) NOT NULL );
ALTER TABLE street_bydunok ADD CONSTRAINT street_bydunok_key PRIMARY KEY (name_of_street_after, kilkictb_kvartir_after);

ALTER TABLE street_bydunok ADD CONSTRAINT street_key FOREIGN KEY(name_of_street_after) REFERENCES street (name_of_street);
ALTER TABLE street_bydunok ADD CONSTRAINT kilkictb_kvartir_key FOREIGN KEY(kilkictb_kvartir_after) REFERENCES bydunok (kilkictb_kvartir);

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO Riasyk;
GRANT INSERT ANY TABLE TO Riasyk;
/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар та яке ім'я покупця цього замовлення?
Виконати завдання в алгебрі Кодда.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних електронних адрес покупців - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT COLUMN_NAME AS "vendor_name"
FROM VENDORS
WHERE VEND_ID AS "vend_id" 
AND VEND_NAME AS "vend_name" 
AND VEND_CITY AS "vend_city" 
AND VEND_STATE AS "vend_state"
AND VEND_ZIP AS "vend_zip"
AND VEND_COUNTRY AS "vend_country"


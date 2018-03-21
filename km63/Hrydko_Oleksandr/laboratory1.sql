-- LABORATORY WORK 1
-- BY Hrydko_Oleksandr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлювати дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER hrydko
IDENTIFIED BY hrydko
DEFAULT tablespace "USERS"
TEMPORARY tablespace "TEMP"

ALTER USER hrydko
QUOTA 100M ON USERS

GRANT "CONNECT" TO hrydko;

GRANT SELECT  ANY TABLE TO hrydko;
GRANT UPDATE ANY TABLE TO hrydko;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На вулиці стоїть будинок, що має 10 квартир.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE street (
 street_name VARCHAR(30) NOT NULL
);

ALTER TABLE street 
ADD CONSTRAINT street_name_pk PRIMARY KEY street;

CREATE TABLE house (
 house_name VARCHAR(30) NOT NULL
);

ALTER TABLE house 
ADD CONSTRAINT house_name_pk PRIMARY KEY house;

CREATE TABLE house_on_street (
 house_name_fk VARCHAR(30) NOT NULL
 street_name_fk VARCHAR(30) NOT NULL
 number_of_house NUMBER(2) NOT NULL
);

ALTER TABLE house_on_street 
ADD CONSTRAINT house_on_street_pk PRIMARY KEY ( house_name_pk, street_name_pk);

ALTER TABLE house_on_street 
ADD CONSTRAINT house_fk FOREIGN KEY house_name_fk REFERENCES house;

ALTER TABLE house_on_street 
ADD CONSTRAINT street_fk FOREIGN KEY street_name_fk REFERENCES street;














  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/

--Код відповідь:
GRANT SELECT ANY TABLE TO hrydko;
GRANT INSERT  ANY TABLE TO hrydko;
GRANT CREATE  ANY TABLE TO hrydko;






/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар та яке ім'я покупця цього замовлення?
Виконати завдання в алгебрі Кодда.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
project number(max(product)),name_pokyptsa;













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних електронних адрес покупців - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(DISTINCT(CUST_EMAIL)) AS count_email
FROM customers;














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT LOWER(NAME_POSTATHAL)




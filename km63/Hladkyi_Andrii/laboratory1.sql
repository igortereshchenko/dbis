-- LABORATORY WORK 1
-- BY Hladkyi_Andrii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлювати дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Hladkiy
IDENTIFIED BY password
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER Hlakiy QUOTA 100M ON USERS;

GRANT INSERT ANY TABLES TO Hladkiy;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На вулиці стоїть будинок, що має 10 квартир.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE flat 
(
    number_of_flat number(2) NOT NULL
)

ALTER TABLE flat ADD CONSTRAINT number_flat_key PRIMARY KEY (number_of_flat);

CREATE TABLE human 
(
    human_in_flat varchar2(20) NOT NULL
)
ALTER TABLE human ADD CONSTRAINT human_flat_key PRIMARY KEY (human_in_flat);

CREATE TABLE human_flat
(
    number_flat_after number(2) NOT NULL,
    human_flat_after varchar2(20) NOt NULL,
    number_of_telephone number(10)
)

ALTER TABLE human_flat ADD CONSTRAINT human_flat_key PRIMARY KEY(number_of_flat,human_in_flat)
ALTER TABLE human_flat ADD CONSTRAINT number_flat_key PRIMARY KEY(number_of_flat) FOREIGHT KEY(number_flat_after)
ALTER TABLE human_flat ADD CONSTRAINT human_flat_key PRIMARY KEY(human_in_flat) FOREIGHT KEY(human_flat_after);















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT INSERT ANY TABLES TO Hladkiy;
GRANT CREATE ANY TABLES TO Hladkiy;






/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар та яке ім'я покупця цього замовлення?
Виконати завдання в алгебрі Кодда.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
NUMBER(ORDER_NUM)
MAX(PROD_PRICE)














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


-- LABORATORY WORK 1
-- BY Kolobaieva_Kateryna
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER kolobaieva IDENTIFIED BY To kolobaieva
DEFAULT TABLESPACE 'USERS'
TIMEPORARY TABLESPACE 'TEMP'

ALTER USER kolobaieva QUOTA 100M ON 'USERS'

GRAND 'CONNECT' To kolobaieva

GRAND UPDATE ANY TABLES To kolobaieva





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLES film
( 
   type_of_film char(30) NOT NULL
);
ALTER TYPE film ADD CONSTRAIN type_of_film_pk PRIMARY KEY (type_of_film);

CREATE TABLES watch
(
   watch_type char(30)  NOT NULL
);
ALTER TYPE watch ADD CONSTRAIN type_of_watch_pk PRIMARY KEY (type_of_watch);

CREATE TABLES human 
(
   type_of_film char(30) NOT NULL
   watch_type char(30)  NOT NULL
   human char(30)
);

AlTER TABLE human ADD CONSTRAIN  human_pk PRIMARY KEY (type_of_film,
type_of_watch);

AlTER TABLE human ADD CONSTRAIN typefilm_fk FOREIGN KEY (type_of_film)
REFERENCE film (type_of_film);

AlTER TABLE human ADD CONSTRAIN typewatch_fk FOREIGN KEY (type_of_watch)
REFERENCE watcn (type_of_watch);












  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRAND CREATE ANY TABLES To kolobaieva
GRAND SELECT ANY TABLES To kolobaieva
GRAND ALTER ANY TABLES To kolobaieva




/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT 












/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

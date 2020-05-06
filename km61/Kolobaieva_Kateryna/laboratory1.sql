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


CREATE TABLE profiles
(
	profile_id NUMBER(10) NOT NULL,
	profile_username VARCHAR(10) NOT NULL,
	profile_info VARCHAR(200),
	profile_watched NUMBER(15)
);

ALTER TABLE profiles
    ADD CONSTRAINT profiles_pk PRIMARY KEY (profile_id);

CREATE TABLE movies
(
    movie_id NUMBER(10) NOT NULL,
    movie_name VARCHAR(20) NOT NULL,
    movie_description VARCHAR(2000) NULL,
    movie_rating NUMBER(3) NULL
);

ALTER TABLE movies
    ADD CONSTRAINT movies_pk PRIMARY KEY (movie_id);
    
CREATE TABLE reviews
(
	review_id NUMBER(10) NOT NULL,
    review_text VARCHAR(2000) NOT NULL,
	review_rating NUMBER(2) NOT NULL,
	review_date DATE NOT NULL
);

ALTER TABLE reviews
    ADD CONSTRAINT reviews_pk PRIMARY KEY (review_id);
    
CREATE TABLE watched_movies
(
    profile_id_fk NUMBER(10) NOT NULL,
    movie_id_fk NUMBER(10) NOT NULL,
    review_id_fk NUMBER(10) NOT NULL
);

ALTER TABLE watched_movies
    ADD CONSTRAINT watched_movies_pk PRIMARY KEY (review_id_fk);
    
ALTER TABLE watched_movies
    ADD CONSTRAINT profile_id_fk FOREIGN KEY (profile_id_fk) REFERENCES profiles (profile_id);
    
ALTER TABLE watched_movies
    ADD CONSTRAINT movie_id_fk FOREIGN KEY (movie_id_fk) REFERENCES movies (movie_id);
    
ALTER TABLE watched_movies
    ADD CONSTRAINT review_id_fk FOREIGN KEY (review_id_fk) REFERENCES reviews (review_id);


INSERT INTO profiles VALUES (1, 'kate', 'I am a student', 1);
INSERT INTO profiles VALUES (2, 'katia', 'I like bats', 2);
INSERT INTO profiles VALUES (3, 'quw', 'Hi', 3);
INSERT INTO profiles VALUES (4, 'asdf', '', 3);

ALTER TABLE profiles ADD CONSTRAINT profile_watched_ch CHECK (profile_watched >= 0);
ALTER TABLE movies ADD CONSTRAINT movies_rating_ch CHECK (movie_rating >= 0 AND movie_rating <= 10);

INSERT INTO movies VALUES (1, 'Interstellar', 'Steve', 1);
INSERT INTO movies VALUES (2, 'Interstellar 2', 'Steve', 1);
INSERT INTO movies VALUES (3, 'Interstellar 3', 'Steve', 1);
INSERT INTO movies VALUES (4, 'Interstellar 4', 'Steve', 2);

INSERT INTO reviews VALUES (1, 'Good', 10, TO_DATE('2018-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reviews VALUES (2, 'Bad', 1, TO_DATE('2018-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reviews VALUES (3, 'Awfull', 1, TO_DATE('2018-01-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reviews VALUES (4, 'Terrible', 1, TO_DATE('2018-01-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reviews VALUES (5, 'Terrible', 1, TO_DATE('2018-01-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reviews VALUES (6, 'Terrible', 1, TO_DATE('2018-01-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO watched_movies VALUES (1, 1, 1);
INSERT INTO watched_movies VALUES (1, 2, 2);
INSERT INTO watched_movies VALUES (3, 1, 3);
INSERT INTO watched_movies VALUES (2, 1, 4);
INSERT INTO watched_movies VALUES (2, 3, 5);
INSERT INTO watched_movies VALUES (4, 4, 6);

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO kolobaieva
GRANT SELECT ANY TABLE TO kolobaieva
GRANT ALTER ANY TABLE TO kolobaieva




/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT
COUNT(customers.cust_id) amount_cust_with_min_price
FROM customers, orders, orderitems 
WHERE customers.cust_id = orders.cust_id 
AND orders.order_num = orderitems.order_num
AND item_price = (SELECT min(item_price) FROM orderitems);













/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT VEND_COUNTY 
FROM VENDORS
WHERE LENGTH OF VEND_COUNTRY = MAX IN (
ALTER TABLE VENDORS 
SELECT VEND_COUNTRY );













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT "client_name" from
(SELECT DISTINCT (trim(CUST_NAME)||' '||trim(CUST_COUNTRY) )AS "client_name", CUSTOMERS.CUST_ID
from CUSTOMERS, ORDERITEMS, ORDERS
where(ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
AND ORDERITEMS.QUANTITY >0
and CUSTOMERS.CUST_ID = ORDERS.CUST_ID));

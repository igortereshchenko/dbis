-- LABORATORY WORK 1
-- BY Mehediuk_Kateryna
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
+CREATE USER Katia IDENTIFIED BY Katia;
+DEFAULT TABLESPACE "user";
+TEMPORARY TABLESPACE "temp";
+
+ALTER "CONNECT" TO Katia;
+GRANT UPDATE ANY TABLE TO Katia;



      
      















/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE viewers
(
	viewer_id NUMBER(10) NOT NULL,
	viewer_name VARCHAR(10),
	viewer_surname VARCHAR(10),
	viewer_watched NUMBER(10)
);

ALTER TABLE viewers
    ADD CONSTRAINT viewers_pk PRIMARY KEY (viewer_id);

CREATE TABLE movies
(
    movie_id NUMBER(10) NOT NULL,
    movie_name VARCHAR(20) NOT NULL,
    movie_director VARCHAR(50) NULL,
    movie_rating NUMBER(3) NULL
);

ALTER TABLE movies
    ADD CONSTRAINT movies_pk PRIMARY KEY (movie_id);
    
CREATE TABLE tickets
(
    ticket_number NUMBER(10) NOT NULL,
	ticket_hall VARCHAR(10) NOT NULL,
    ticket_row NUMBER(5) NOT NULL,
	ticket_seat NUMBER(5) NOT NULL
);

ALTER TABLE tickets
    ADD CONSTRAINT tickets_pk PRIMARY KEY (ticket_number);
    
CREATE TABLE cinema_session
(
    viewer_id_fk NUMBER(10) NOT NULL,
    movie_id_fk NUMBER(10) NOT NULL,
    ticket_number_fk NUMBER(10) NOT NULL,
    buy_date DATE
);

ALTER TABLE cinema_session
    ADD CONSTRAINT cinema_session_pk PRIMARY KEY (ticket_number_fk);
    
ALTER TABLE cinema_session
    ADD CONSTRAINT viewer_id_fk FOREIGN KEY (viewer_id_fk) REFERENCES viewers (viewer_id);
    
ALTER TABLE cinema_session
    ADD CONSTRAINT movie_id_fk FOREIGN KEY (movie_id_fk) REFERENCES movies (movie_id);
    
ALTER TABLE cinema_session
    ADD CONSTRAINT ticket_number_fk FOREIGN KEY (ticket_number_fk) REFERENCES tickets (ticket_number);


INSERT INTO viewers VALUES (1, 'Katia', 'K', 2);
INSERT INTO viewers VALUES (2, 'Katia', 'M', 0);
INSERT INTO viewers VALUES (3, 'Vlad', 'G', 40);
INSERT INTO viewers VALUES (4, 'Vlad', 'H', 3);

ALTER TABLE viewers ADD CONSTRAINT viewers_watched_ch CHECK (viewer_watched >= 0);
ALTER TABLE movies ADD CONSTRAINT movies_rating_ch CHECK (movie_rating >= 0 AND movie_rating <= 100);

INSERT INTO movies VALUES (10124, 'Lego movie', 'Tarantino', 20);
INSERT INTO movies VALUES (2342, 'Titanic', 'Tarantino', 100);
INSERT INTO movies VALUES (3526, 'Movie', 'Tarantino', 1);
INSERT INTO movies VALUES (3527, 'Movie 2', 'Tarantino', 2);

INSERT INTO tickets VALUES (234786, 'A', 1, 2);
INSERT INTO tickets VALUES (236314, 'C', 4, 1);
INSERT INTO tickets VALUES (135234, 'D', 1, 1);
INSERT INTO tickets VALUES (123463, 'F', 1, 8);
INSERT INTO tickets VALUES (342346, 'A', 7, 3);
INSERT INTO tickets VALUES (234634, 'A', 3, 2);
INSERT INTO tickets VALUES (234635, 'A+', 4, 2);
INSERT INTO tickets VALUES (234636, 'D', 5, 2);
INSERT INTO tickets VALUES (234637, 'D', 6, 2);
INSERT INTO tickets VALUES (234638, 'D', 7, 2);
INSERT INTO tickets VALUES (234639, 'D', 8, 2);

INSERT INTO cinema_session VALUES (3, 10124, 234786, TO_DATE('2012-06-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (3, 10124, 236314, TO_DATE('2012-06-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (3, 3526, 135234, TO_DATE('2012-06-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (3, 2342, 123463, TO_DATE('2012-06-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (1, 3526, 342346, TO_DATE('2012-06-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (2, 3526, 234634, TO_DATE('2012-06-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO cinema_session VALUES (2, 3527, 234635, TO_DATE('2012-06-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (4, 3527, 234636, TO_DATE('2012-06-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (2, 3526, 234637, TO_DATE('2012-06-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (2, 3527, 234638, TO_DATE('2012-06-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO cinema_session VALUES (2, 3526, 234639, TO_DATE('2012-06-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
-GRAND CREATE ANY TABLES To Katia
-GRAND SELECT ANY TABLES To Katia
-GRAND ALTER ANY TABLES To  Katia
+GRANT CREATE ANY TABLE TO  Katia
+GRANT SELECT ANY TABLE TO  Katia
+GRANT ALTER ANY TABLE TO  Katia






/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
-SELECT 
+SELECT
+COUNT(customers.cust_id) amount_cust_with_min_price
+FROM customers, orders, orderitems 
+WHERE customers.cust_id = orders.cust_id 
+AND orders.order_num = orderitems.order_num
+AND item_price = (SELECT min(item_price) FROM orderitems);
+













/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
-
+SELECT VEND_COUNTY 
+FROM VENDORS
+WHERE LENGTH OF VEND_COUNTRY = MAX IN (
+ALTER TABLE VENDORS 
+SELECT VEND_COUNTRY );













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
+SELECT "client_name" from
+(SELECT DISTINCT (trim(CUST_NAME)||' '||trim(CUST_COUNTRY) )AS "client_name", CUSTOMERS.CUST_ID
+from CUSTOMERS, ORDERITEMS, ORDERS
+where(ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
+AND ORDERITEMS.QUANTITY >0
+and CUSTOMERS.CUST_ID = ORDERS.CUST_ID));

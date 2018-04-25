-- LABORATORY WORK 1
-- BY Mykhaylenko_Yeva
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER mykhaylenko IDENTIFIED BY mykhaylenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER mykhaylenko QUOTA 100M ON USERS;
GRANT "CONNECT" TO mykhaylenko ;

GRANT INSERT ANY TABLE TO mykhaylenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Класна кімната має парти та стільці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE CLASSROOM 
(ROOM_ID NUMBER(3) PRIMARY KEY,
 ROOM_SIZE NUMBER(4),
 NUMBER_CHAIRS NUMBER(2),
 NUMBER_DESKS NUMBER (2))
 
 CREATE TABLE CHAIRS
(CHAIR_ID NUMBER(6) PRIMARY KEY,
 CHAIR_MODEL VARCHAR2(4),
 ROOM_ID NUMBER(3))
 
 CREATE TABLE DESKS
(DESK_ID NUMBER(6) PRIMARY KEY,
 DESK_MODEL VARCHAR2(4),
 ROOM_ID NUMBER(3))
 
 ALTER TABLE CHAIRS
 ADD CONSTRAINT CHAIR_FK FOREIGN KEY (ROOM_ID)
 REFERENCES CLASSROOM (ROOM_ID)
  
 ALTER TABLE DESKS
 ADD CONSTRAINT DESK_FK FOREIGN KEY (ROOM_ID)
 REFERENCES CLASSROOM (ROOM_ID)
 
 CREATE TABLE RECONDITIONING
(RECONDITIONING_DATE DATE PRIMARY KEY,
 ROOM_ID NUMBER(3))
 
 ALTER TABLE RECONDITIONING
 ADD CONSTRAINT RR_FK FOREIGN KEY (ROOM_ID)
 REFERENCES CLASSROOM (ROOM_ID)
 
 
 INSERT INTO CLASSROOM (ROOM_ID,ROOM_SIZE,NUMBER_CHAIRS,NUMBER_DESKS)
 VALUES (101, 42, 30, 15);

 INSERT INTO CLASSROOM (ROOM_ID,ROOM_SIZE,NUMBER_CHAIRS,NUMBER_DESKS)
 VALUES (102, 42, 29, 15);

 INSERT INTO CLASSROOM (ROOM_ID,ROOM_SIZE,NUMBER_CHAIRS,NUMBER_DESKS)
 VALUES (103, 65, 44, 20);

 INSERT INTO CHAIRS (CHAIR_ID,CHAIR_MODEL,ROOM_ID)
 VALUES (000001, 'AE01', 101 );

 INSERT INTO CHAIRS (CHAIR_ID,CHAIR_MODEL,ROOM_ID)
 VALUES (000002, 'AE01', 101 );

 INSERT INTO CHAIRS (CHAIR_ID,CHAIR_MODEL,ROOM_ID)
 VALUES (000003, 'LT81', 103 );
 
 INSERT INTO DESKS (DESK_ID,DESK_MODEL,ROOM_ID)
 VALUES (000001, 'TB54', 101 );
 
 INSERT INTO DESKS (DESK_ID,DESK_MODEL,ROOM_ID)
 VALUES (000002, 'WR16', 102 );
 
 INSERT INTO DESKS (DESK_ID,DESK_MODEL,ROOM_ID)
 VALUES (000003, 'TB45', 102 );
 
 INSERT INTO RECONDITIONING (RECONDITIONING_DATE, ROOM_ID)
 VALUES ('11.10.2001', 101 );
 
 INSERT INTO RECONDITIONING (RECONDITIONING_DATE, ROOM_ID)
 VALUES ('12.02.2014', 102 );
 
 INSERT INTO RECONDITIONING (RECONDITIONING_DATE, ROOM_ID)
 VALUES ('23.03.2018', 103 );
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO mykhaylenko;
GRANT INSERT ANY TABLE TO mykhaylenko;
GRANT ALTER ANY TABLE TO mykhaylenko;
GRANT SELECT ANY TABLE TO mykhaylenko;


/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(ORDERS.cust_id)
FROM Orders, Orderitems
 WHERE (
        ORDERS.order_num = ORDERITEMS.order_num AND
        ORDERITEMS.item_price = (
            SELECT MAX(item_price) 
            FROM ORDERITEMS   )



/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних електронних адрес зберігається в таблиці CUSTOMERS - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(DISTINCT(cust_email)) COUNT_EMAIL
FROM CUSTOMERS;



/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT (CUSTOMERS)
WHERE
       CUSTOMERS.cust_id not IN (
           PROJECT (ORDERS) 
              { DISTINCT(cust_id)}
        ) {TRIM(cust_name) || ' ' || TRIM(cust_email) "client_name"};

-- LABORATORY WORK 1
-- BY Khodakivskyi_Vadym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Khodakivskyy IDENTIFIED BY vadim
DEFAULT TABLESPACE "def"
TEMPORARY TABLESPACE "temp";
ALTER USER khodakivskyy QUOTA unlimited ON USERS;
GRANT "CONNECT" TO Khodakivskyy;
GRANT INSERT ANY TABLE TO Khodakivskyy;










/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Класна кімната має парти та стільці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE ROOM(
  room_number NUMBER(4) NOT NULL,
  room_volume NUMBER(6,2)
);
CREATE TABLE DESK(
  desk_id NUMBER(6) NOT NULL,
  desk_color VARCHAR2(15),
  room_number_fk NUMBER(4) NOT NULL
);
CREATE TABLE CHAIR(
  chair_id NUMBER(6) NOT NULL,
  chair_color VARCHAR2(15),
  room_number_fkfk NUMBER(4) NOT NULL
);

ALTER TABLE ROOM
  ADD CONSTRAINT room_pk PRIMARY KEY (room_number);
ALTER TABLE DESK
  ADD CONSTRAINT desk_pk PRIMARY KEY (desk_id);
ALTER TABLE CHAIR
  ADD CONSTRAINT chair_pk PRIMARY KEY (chair_id);
ALTER TABLE DESK
  ADD CONSTRAINT desk_fk FOREIGN KEY (room_number_fk)
  REFERENCES ROOM (room_number);
ALTER TABLE CHAIR
  ADD CONSTRAINT chair_fk FOREIGN KEY (room_number_fkfk)
  REFERENCES ROOM (room_number);














  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO Khodakivskyy;
GRANT INSERT ANY TABLE TO Khodakivskyy;
GRANT SELECT ANY TABLE TO Khodakivskyy;




/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(cust_name)
FROM CUSTOMERS, ORDERS, ORDERITEMS
where CUSTOMERS.CUST_ID=ORDERS.CUST_ID AND
      ORDERITEMS.ORDER_NUM=ORDERS.ORDER_NUM AND
      ORDERITEMS.ITEM_PRICE = 11.99;









/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних електронних адрес зберігається в таблиці CUSTOMERS - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT COUNT(DISTINCT CUST_EMAIL)
FROM CUSTOMERS;













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT ((CUSTOMERS TIMES ORDERS) WHERE CUSTOMERS.CUST_ID <> ORDERS.CUST_ID) (RENAME (CUST_NAME || CUST_EMAIL) client_email )

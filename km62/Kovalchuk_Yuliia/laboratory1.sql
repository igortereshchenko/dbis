/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Kovalchuk IDENTIFIED BY Kovalchuk ;

DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";

ALTER USER QUOTA 100M ON  USER;
GRANT "CONECT" TO Kovalchuk;

GRANT DELETE ANY TABLE FOR Kovalchuk;
GRANT INSERT ANY TABLE FOR Kovalchuk







/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE phone (
    phone_name            VARCHAR2(20) NOT NULL,
    phone_id               NUMBER(10) NOT NULL,
    phone_marka   VARCHAR(20) NOT NULL,
    phone_price            NUMBER(8) NOT NULL,
    CONSTRAINT phone_pk PRIMARY KEY ( phone_name,
    phone_price,
    phone_id )
 );
 
 INSERT INTO phone  (phone_name, phone_id, phone_marka, phone_price) 
 VALUES ( '23B39','10001','MEIZU','1200'
 );
INSERT INTO phone  (phone_name, phone_id, phone_marka, phone_price) 
 VALUES ( '23B39','10002','SAMSUNG','1200'
 );
 INSERT INTO phone  (phone_name, phone_id, phone_marka, phone_price) 
 VALUES ( '33bbccer2','10003','LENOVO','1200'
 );

 CREATE TABLE human (
    human_name        VARCHAR(15) NOT NULL,
    human_id   NUMBER(20) NOT NULL,
    hunam_age         NUMBER(3) NOT NULL,
    human_sex         VARCHAR(1) NOT NULL,
    CONSTRAINT human_pk PRIMARY KEY ( human_id )
);

INSERT INTO human  (human_name, human_id, hunam_age, human_sex) 
 VALUES ( 'KOLIN','10281','23','M'
 );
 INSERT INTO human  (human_name, human_id, hunam_age, human_sex) 
 VALUES ( 'JHON','10881','19','M'
 );
 INSERT INTO human  (human_name, human_id, hunam_age, human_sex) 
 VALUES ( 'OLHA','143281','43','V'
 );

CREATE TABLE orders (
    human_id_fk   NUMBER(20) NOT NULL,
    phone_name_fk      VARCHAR2(20) NOT NULL,
	order_type  VARCHAR2(20) NOT NULL,
    order_date  DATE NOT NULL
	
);
INSERT INTO orders  (human_id_fk, phone_name_fk, order_type, order_date) 
 VALUES ( '12048892','NOKIA','NOT_GOLD','16-07-2008'
 );
 INSERT INTO orders  (human_id_fk, phone_name_fk, order_type, order_date) 
 VALUES ( '8394839','NOKIA','GOLD','18-03-2018'
 );
 INSERT INTO orders  (human_id_fk, phone_name_fk, order_type, order_date) 
 VALUES ( '3029029','MEIZU','NOT_GOLD','14-05-2012'
 );
----------------------------

 ALTER TABLE phone
    ADD CONSTRAINT phone_nam UNIQUE ( phone_name,
    phone_price,
    phone_id );

ALTER TABLE phone
    ADD CONSTRAINT phone_prices CHECK ( length(phone_price) >= 2 );
    


ALTER TABLE human ADD CONSTRAINT human_nam UNIQUE ( human_id );

ALTER TABLE human
    ADD CONSTRAINT human_name CHECK ( length(human_name) >= 2 );



ALTER TABLE orders
    ADD CONSTRAINT orders_pk PRIMARY KEY ( human_id_fk,
    phone_name_fk,
    order_date );

ALTER TABLE orders
    ADD CONSTRAINT phone_fk FOREIGN KEY ( phone_name_fk )
        REFERENCES phone ( phone_name );

ALTER TABLE orders
    ADD CONSTRAINT human_fk FOREIGN KEY ( human_id_fk )
        REFERENCES human ( human_id );
        
—----------------------------------------------------------------------------

CREATE TABLE shop (
    phone_price_fk     NUMBER(8) NOT NULL,
    phone_id_fk        NUMBER(20) NOT NULL,
    order_date_fk         DATE NOT NULL,
    location    VARCHAR2(20) NOT NULL,
    profit   NUMBER(10) NOT NULL
);

INSERT INTO shop  (phone_price_fk, phone_id_fk, order_date_fk, location, profit) 
 VALUES ( '1200','32222','16-03-2006','Kyiv', '20000'
 );
 INSERT INTO shop  (phone_price_fk, phone_id_fk, order_date_fk, location, profit) 
 VALUES ( '2000','334322','11-04-2017','lviv', '3267000'
 );
 INSERT INTO shop  (phone_price_fk, phone_id_fk, order_date_fk, location, profit) 
 VALUES ( '5000','47483','18-03-2012','Kyiv', '3000000'
 );

ALTER TABLE shop
    ADD CONSTRAINT shop_pk PRIMARY KEY ( phone_price_fk,
    phone_id_fk,
    order_date_fk );

ALTER TABLE shop
    ADD CONSTRAINT phone_price_shop_fk FOREIGN KEY ( phone_price_fk )
        REFERENCES phone ( phone_price );

ALTER TABLE shop
    ADD CONSTRAINT phone_id_shop_fk FOREIGN KEY ( phone_id_fk )
        REFERENCES phone ( phone_id );

ALTER TABLE shop
    ADD CONSTRAINT order_date_shop_fk FOREIGN KEY ( order_date_fk )
        REFERENCES orders ( order_date );
    






  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE INSERT TABLE IN Kovalchuk;


/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

Project max(products.prod_price) TIMES products MINUS orderitems WHERE orderitems.prod_id = Products.prod_id
 











/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:



SELECT Customers WHERE cust_id IN( 
 SELECT orders
 WHERE order_num IN (
  SELECT orderitems WHERE item_price = max(item_price) FROM order_num) FROM cust_id) )
cust_name AS Customer_name
FROM Customers;


/*---------------------------------------------------------------------------
 c. 
 Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
 Виконати завдання в SQL. 
 4 бали
-
----------------------------------------------------------------------------*/
---Код відповідь:


SELECT (TRIM(vend_name) || ' ' || TRIM(vend_country)) as "vendor_name"
FROM VENDORS
MINUS
SELECT Vendors.vend_id, Products.vend_id
FROM Vendors, Products
WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID;




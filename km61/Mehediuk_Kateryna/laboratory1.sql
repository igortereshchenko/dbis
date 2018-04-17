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
CREATE TABLE books
 ( 
-   type_of char(30) NOT NULL,
+   name_of varchar2(30) NOT NULL,
    release_of numeric(4),
    library_adress varchar2(40)
 );
-ALTER TABLE books ADD CONSTRAINT books_pk PRIMARY KEY (type_of);
+ALTER TABLE books ADD CONSTRAINT books_pk PRIMARY KEY (name_of);
+
+ALTER TABLE  books
+    ADD CONSTRAINT  books_sn_check CHECK (REGEXP_LIKE(name_of, '^[A-Za-z0-9`\.\-\s\,]'));
+ALTER TABLE  books
+    ADD CONSTRAINT  books_cn_check CHECK (1950<release_of numeric and release_of numeric<2018);
+ALTER TABLE books 
+    ADD CONSTRAINT books_ba_check CHECK (REGEXP_LIKE(library_adress, '^[A-Za-z0-9`\.\-\s\,]'));
+    
+insert into books(name_of, release_of, library_adress) values ('Franz Kafka','2000','Shevchenkivsky district, 10');
+insert into books(name_of, release_of, library_adress) values ('Hamlet','1996','Голосіївський район , 56');
+insert into books(name_of, release_of, library_adress) values ('The Picture of Dorian Gray','1995','Печерський район, 41');
 
 CREATE TABLE coffe shops
 (
-   type_of char(30) NOT NULL,
+   name_of char(30) NOT NULL,
    release_of numeric(4),
    shops_adress varchar2(40)
    
 );
-ALTER TABLE coffe shops ADD CONSTRAINT coffe shops_pk PRIMARY KEY (type_of);
+ALTER TABLE coffe shops ADD CONSTRAINT coffe shops_pk PRIMARY KEY (name_of);
+
+ALTER TABLE  coffe shops
+    ADD CONSTRAINT  coffe shops_sn_check CHECK (REGEXP_LIKE(name_of, '^[A-Za-z0-9`\.\-\s\,]'));
+ALTER TABLE  coffe shops
+    ADD CONSTRAINT  coffe shops_cn_check CHECK (1950<release_of numeric and release_of numeric<2018);
+ALTER TABLE coffe shops
+    ADD CONSTRAINT coffe shops_ba_check CHECK (REGEXP_LIKE(shops_adress, '^[A-Za-z0-9`\.\-\s\,]'));
+    
+insert into coffe shops(name_of, release_of, shops_adress) values ('Kavova Shafa','2015','Vyborg Street, 19');
+insert into coffe shops(name_of, release_of, shops_adress) values ('WOG Cafe','2010','Velyka Vasilkovskaya, 63,');
+insert into coffe shops(name_of, release_of, shops_adress) values ('LCoffeelaktika','2016','Bolshaya Okrugnaya, 110 ');

 CREATE TABLE music shops
 (
-   type_of char(30) NOT NULL,
+   name_of char(30) NOT NULL,
    release_of numeric(4),
    shops_adress varchar2(40)
    
 );
-ALTER TABLE music shops ADD CONSTRAINT music shops_pk PRIMARY KEY (type_of);
+ALTER TABLE coffe shops ADD CONSTRAINT music shops_pk PRIMARY KEY (name_of);
+
+ALTER TABLE  music shops
+    ADD CONSTRAINT  music shops_sn_check CHECK (REGEXP_LIKE(name_of, '^[A-Za-z0-9`\.\-\s\,]'));
+ALTER TABLE  music shops
+    ADD CONSTRAINT  coffe shops_cn_check CHECK (1950<release_of numeric and release_of numeric<2018);
+ALTER TABLE music shops
+    ADD CONSTRAINT music shops_ba_check CHECK (REGEXP_LIKE(shops_adress, '^[A-Za-z0-9`\.\-\s\,]'));
+    
+insert into music shops(name_of, release_of, shops_adress) values ('Dva Melomany','2010','Mikhail Dragomanov, 31D');
+insert into music shops(name_of, release_of, shops_adress) values ('JAM','2010','street Verbova, 16');
+insert into music shops(name_of, release_of, shops_adress) values ('House of music','2007','Shchekavitska, 46B ');                                                                    

 CREATE TABLE zoo
 (
-   type_of char(30) NOT NULL,
+   name_of char(30) NOT NULL,
    release_of numeric(4),
    zoo_adress varchar2(40)
    
 );
-ALTER TABLE zoo ADD CONSTRAINT music  zoo_pk PRIMARY KEY (type_of);
+ALTER TABLE zoo ADD CONSTRAINT music zoo_pk PRIMARY KEY (name_of);
+
+ALTER TABLE  zoo
+    ADD CONSTRAINT  zoo_sn_check CHECK (REGEXP_LIKE(name_of, '^[A-Za-z0-9`\.\-\s\,]'));
+ALTER TABLE  zoo
+    ADD CONSTRAINT  zoo_cn_check CHECK (1950<release_of numeric and release_of numeric<2018);
+    
+insert into zoo(name_of, release_of, zoo_adress) values ('Enotida country','1995','Academician Zabolotny, 37');
+insert into zoo(name_of, release_of, zoo_adress) values ('Kiev Zoo','1970','Prospekt Peremogy, 32');
                                                                  














  
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

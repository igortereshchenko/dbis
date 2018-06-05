
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може:
змінювати структуру таблиць та видаляти дані.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER chernetskyi IDENTIFIED D BY chernetskyi DEFAULT TABLESPACE "USERS" TEMPORARY TABLESPACE "TEMP";
  ALTER USER chernetskyi QUOTA 100M ON USERS;
  GRANT "CONNECT" TO chernetskyi;
  GRANT
CREATE ANY TABLE TO chernetskyi;
  GRANT ALTER ANY TABLE TO chernetskyi;
  GRANT
  SELECT ANY TABLE TO chernetskyi;
  /* ---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі
створювати окремо від таблиць використовуючи команди ALTER TABLE.
Турист забронював готель.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
  
  CREATE TABLE hotels (
    hotel_id         NUMBER(3) PRIMARY KEY,
    hotel_name       VARCHAR2(4),
    hotel_stars      VARCHAR2(2),
    hotel_price      NUMBER(3)
);

CREATE TABLE customers (
    cust_id          NUMBER(6) PRIMARY KEY,
    cust_name        VARCHAR2(4),
    hotel_id         NUMBER(3)
);


ALTER TABLE customers
    ADD CONSTRAINT hotels_fk FOREIGN KEY ( hotel_id )
        REFERENCES hotels ( room_id );


CREATE TABLE reconditioning (
    reconditioning_date   DATE PRIMARY KEY,
    hotels                NUMBER(3)
);

ALTER TABLE reconditioning
    ADD CONSTRAINT rr_fk FOREIGN KEY ( hotel_id )
        REFERENCES hotels ( hotel_id );
        
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць,
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT.
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити:
---------------------------------------------------------------------------*/
 --Код відповідь

GRANT CREATE ANY TABLE TO chernetskyi;
GRANT INSERT ANY TABLE TO chernetskyi;
GRANT ALTER ANY TABLE TO chernetskyi;
GRANT SELECT ANY TABLE TO chernetskyi;
  /*---------------------------------------------------------------------------
3.a.
Як звуть покупця, що не купив найдорожчий продукт.
Виконати завдання в Алгебрі Кодда.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
/*---------------------------------------------------------------------------
3.b.
Вивести номер замовлення та назву товару у даному замовленні, що має найнижчу ціну у рамках замовлення.
Виконати завдання в SQL.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
  SELECT Orders.ORDER_NUM,
    Products.PROD_NAME,
    MIN(Products.PROD_PRICE)    
  FROM Orders, Products
  
  /*---------------------------------------------------------------------------
  c.
Раскодировать как в предыдущий раз   Hint
Вивести країну та пошту покупця, як єдине поле client_name у нижньому регістрі, для тих покупців, що купляли продукти у постачальника з іменем "James".
Виконати завдання в SQL.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
  
  SELECT 
  TRIM  (cust_country)
    || ', '
    || TRIM  (cust_email) AS "client_name"
  FROM Customers, Vendors
  WHERE VENDORS.VEND_NAME='James';

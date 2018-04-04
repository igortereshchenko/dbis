-- LABORATORY WORK 1
-- BY Kozyriev_Anton

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


-- Create user
CREATE USER kozyrev IDENTIFIED BY kozyrev
default tablespace "USERS"
TEMPORARY TABLESPACE "TEMP";

--Quota

ALTER USER kozyrev Quota 100M on "Users";

--Connect

GRANT "CONNECT" TO kozyrev;

--Grants

GRANT DELETE ANY TABLE TO kozyrev
GRANT INSERT ANY TABLE TO kozyrev;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE Customer
(
    cust_id VARCHAR(30) NOT NULL,
    customer_name VARCHAR(30) NOT NULL
);

ALTER TABLE Customer ADD CONSTRAINT CustomerPK PRIMARY KEY(cust_id);
ALTER TABLE PhoneBrand ADD CONSTRAINT PhoneBrandFK FOREIGN KEY(phone_id) REFERENCES Phone(phone_id);

CREATE TABLE Phone
(
    phone_id VARCHAR(30) NOT NULL, 
    phone_model VARCHAR(30) NULL,
    cust_id VARCHAR(30) NOT NULL
);

ALTER TABLE Phone ADD CONSTRAINT PhonePK PRIMARY KEY(phone_id);
ALTER TABLE Phone ADD CONSTRAINT PhoneFK FOREIGN KEY(cust_id) REFERENCES Customer(cust_id);

CREATE TABLE PhoneBrand
(
    phone_brand VARCHAR(30) NOT NULL,
    phone_id VARCHAR(30) NOT NULL
);

ALTER TABLE PhoneBrand ADD CONSTRAINT PhoneBrandPK PRIMARY KEY(phone_brand);
ALTER TABLE PhoneBrand ADD CONSTRAINT PhoneBrandFK FOREIGN KEY(phone_id) REFERENCES Phone(phone_id)



  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 


---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO kozyrev
GRANT UPDATE ANY TABLE TO kozyrev
GRANT SELECT ANY TABLE TO kozyrev;

/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT max(Products.prod_price) FROM Products
WHERE NOT exists(SELECT * FROM OrderItems WHERE Products.prod_id = OrderItems.prod_id);

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

----------------------------------------------------------------------------*/

--Код відповідь:

SELECT "Customer_name"
FROM
(
SELECT Customers.cust_name as "Customer_name", ORDERITEMS.ITEM_PRICE as "Price"
FROM CUSTOMERS, ORDERS, ORDERITEMS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
AND ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
)
WHERE "Price" = (SELECT MAX(OrderItems.ITEM_PRICE) FROM ORDERITEMS);


/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


SELECT trim(VENDORS.vend_name) || ';  ' || trim(VENDORS.VEND_COUNTRY) as vendor_name
FROM VENDORS WHERE NOT EXISTS(SELECT * FROM PRODUCTS WHERE Products.vend_id = Vendors.vend_id);



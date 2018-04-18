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
    cust_reserved_phone_number VARCHAR(12) NOT NULL,
    cust_name VARCHAR(20) NOT NULL,
    cust_registration_date VARCHAR(20) NOT NULL,
    cust_email VARCHAR(30) NULL,
);

ALTER TABLE Customer ADD CONSTRAINT CustomerPK PRIMARY KEY(cust_reserved_phone_number, cust_name);

CREATE TABLE Phone
(
    phone_model VARCHAR(30) NOT NULL,
    phone_serial VARCHAR(20) NOT NULL, 
    phone_brand VARCHAR(30) NOT NULL,
    cust_reserved_phone_number VARCHAR(12) NOT NULL,
    brand_name VARCHAR(30) NOT NULL,
    phone_price NUMBER NOT NULL,
    vend_id VARCHAR(30) NOT NULL
);

ALTER TABLE Phone ADD CONSTRAINT PhonePK PRIMARY KEY(phone_model, phone_serial);
ALTER TABLE Phone ADD CONSTRAINT Phone_NumberFK FOREIGN KEY(cust_reserved_phone_number) REFERENCES Customer(cust_reserved_phone_number);
ALTER TABLE Phone ADD CONSTRAINT Phone_BrandFK FOREIGN KEY(brand_name) REFERENCES PhoneBrand(brand_name);
ALTER TABLE Phone ADD CONSTRAINT Phone_VendorFK FOREIGN KEY(vend_id) REFERENCES Vendor(vend_id);

CREATE TABLE PhoneBrand
(
    brand_company VARCHAR(30) NOT NULL,
    brand_name VARCHAR(30) NOT NULL,
    brand_rating NUMBER NULL,
    brand_state BOOLEAN NOT NULL,
);

ALTER TABLE PhoneBrand ADD CONSTRAINT PhoneBrandPK PRIMARY KEY(brand_company, brand_name);

CREATE TABLE Vendor
(
    vend_id VARCHAR(30) NOT NULL,
    vend_name VARCHAR(30) NOT NULL,
    brand_rating NUMBER NULL,
    brand_state BOOLEAN NOT NULL,
);

ALTER TABLE Vendor ADD CONSTRAINT VendorPK PRIMARY KEY(vend_id);



  
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

A = Products RENAME prod_id PRID
B = OrderItems RENAME prod_id ORID
C = OrderItems TIMES Products
D = C WHERE PRID = ORID
E = Products WHERE D = NULL
F = Products RENAME prod_price PRPRICE
G = E PROJECT PRPRICE
H = MAX(G)

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



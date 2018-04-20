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
    cust_reserved_phone_number VARCHAR(12) NOT NULL, -- ex. +xx(xxx)xxx-xx-xx
    cust_name VARCHAR(20) NOT NULL, -- ex. Ivan Petrov
    cust_registration_date VARCHAR(20) NOT NULL, -- ex. xx.xx.xxxx
    cust_email VARCHAR(30) NULL -- ex. example_number99@sample.com
);

ALTER TABLE Customer ADD CONSTRAINT CustomerPK PRIMARY KEY (cust_reserved_phone_number);

ALTER TABLE Customer ADD CONSTRAINT Check_Customers_Number CHECK (REGEXP_LIKE(cust_reserved_phone_number, '^\+38\(0\d{2}\)\d{3}\-\d{2}\-\d{2}$'));
ALTER TABLE Customer ADD CONSTRAINT Check_Customers_Name CHECK (REGEXP_LIKE(cust_name, '^\w+\s\w+$'));
ALTER TABLE Customer ADD CONSTRAINT Check_Customers_Registration_Date CHECK (REGEXP_LIKE(cust_registration_date, '^([0-9]{2}\.){2}([0-9]{4})$'));
ALTER TABLE Customer ADD CONSTRAINT Check_Customers_Email CHECK (REGEXP_LIKE(cust_email, '^((\w|\d)|\_)+\@(\w|\d)+\.(\w|\d)+$'));


CREATE TABLE Phone
(
    phone_serial VARCHAR(20) NOT NULL, 
    brand_serial VARCHAR(30) NOT NULL,
    reserved_phone_number VARCHAR(12) NOT NULL,
    phone_model VARCHAR(30) NOT NULL,
    phone_price NUMBER NOT NULL,
    vend_id VARCHAR(30) NOT NULL
);

ALTER TABLE Phone ADD CONSTRAINT PhonePK PRIMARY KEY(phone_serial);

ALTER TABLE Phone ADD CONSTRAINT Phone_NumberFK FOREIGN KEY(reserved_phone_number) REFERENCES Customer(cust_reserved_phone_number);
ALTER TABLE Phone ADD CONSTRAINT Phone_BrandFK FOREIGN KEY (brand_serial) REFERENCES PhoneBrand(brand_serial);
ALTER TABLE Phone ADD CONSTRAINT Phone_VendorFK FOREIGN KEY(vend_id) REFERENCES Vendor(vend_id);

ALTER TABLE Phone ADD CONSTRAINT Check_Phone_Serial CHECK (REGEXP_LIKE(phone_serial, '^(\w|\d)+$'));
ALTER TABLE Phone ADD CONSTRAINT Check_Phone_Brand CHECK (REGEXP_LIKE(brand_serial, '^(\w|\d)+$'));
ALTER TABLE Phone ADD CONSTRAINT Check_Phone_Number CHECK (REGEXP_LIKE(reserved_phone_number, '^\+38\(0\d{2}\)\d{3}\-\d{2}\-\d{2}$'));
ALTER TABLE Phone ADD CONSTRAINT Check_Phone_Model CHECK (REGEXP_LIKE(phone_model, '^(\w|\s|\d)+$'));
ALTER TABLE Phone ADD CONSTRAINT Check_Phone_Price CHECK (phone_price >= 0);
ALTER TABLE Phone ADD CONSTRAINT Check_Phone_Vend_ID CHECK (REGEXP_LIKE(vend_id, '^(\w|\d)+$'));

CREATE TABLE PhoneBrand
(
    brand_serial VARCHAR(30) NOT NULL,
    brand_name VARCHAR(30) NOT NULL,
    brand_company VARCHAR(30) NOT NULL,
    brand_rating NUMBER NULL
);

ALTER TABLE PhoneBrand ADD CONSTRAINT PhoneBrandPK PRIMARY KEY(brand_serial);

ALTER TABLE PhoneBrand ADD CONSTRAINT Check_Brand_Serial CHECK (REGEXP_LIKE(brand_serial, '^(\w|\d)+$'));
ALTER TABLE PhoneBrand ADD CONSTRAINT Check_Brand_Name CHECK (REGEXP_LIKE(brand_name, '^(\w|\s)+$'));
ALTER TABLE PhoneBrand ADD CONSTRAINT Check_Brand_Company CHECK (REGEXP_LIKE(brand_company, '^(\w|\s|\d)+$'));
ALTER TABLE PhoneBrand ADD CONSTRAINT Check_Brand_Rating CHECK (brand_rating >= 0 AND brand_rating <= 10);

CREATE TABLE Vendor
(
    vend_id VARCHAR(30) NOT NULL,
    vend_name VARCHAR(30) NOT NULL,
    vend_rating NUMBER NULL,
    vend_address VARCHAR(30) NULL
);

ALTER TABLE Vendor ADD CONSTRAINT VendorPK PRIMARY KEY(vend_id);

ALTER TABLE Vendor ADD CONSTRAINT Check_Vend_ID CHECK (REGEXP_LIKE(vend_id, '^(\w|\d)+$'));
ALTER TABLE Vendor ADD CONSTRAINT Check_Vend_Name CHECK (REGEXP_LIKE(vend_name, '^(\w|\s|\d)+$'));
ALTER TABLE Vendor ADD CONSTRAINT Check_Vend_Rating CHECK (vend_rating >= 0 AND vend_rating <= 10);
ALTER TABLE Vendor ADD CONSTRAINT Check_Vend_Address CHECK (REGEXP_LIKE(vend_address, '^(\w|\s|\d)+$'));
  
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



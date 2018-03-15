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

GRANT DROP ANY TABLE TO kozyrev
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
  customer_name VARCHAR(30) NOT NULL
);

ALTER TABLE Customer ADD CONSTRAINT customer_name PRIMARY KEY;

CREATE TABLE Phone
(
  phone_model VARCHAR(30) NOT NULL
);

ALTER TABLE Phone ADD CONSTRAINT phone_model PRIMARY KEY;

CREATE TABLE Phone_brand
(
  customer_name VARCHAR(30) NOT NULL,
  phone_model VARCHAR(30) NOT NULL,
  phone_brand VARCHAR(30) NOT NULL
);

ALTER TABLE Phone ADD CONSTRAINT phone_model PRIMARY KEY;
ALTER TABLE Phone ADD CONSTRAINT customer_name_fk FOREIGN KEY (Customer) references customer_name;
ALTER TABLE Phone ADD CONSTRAINT phone_model_fk FOREIGN KEY (Phone) references phone_model;



  
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




SELECT CUST_NAME AS "Customer_name"
FROM 
(
  SELECT CUST_NAME
  FROM Customers, OrderItems, Orders
  WHERE Orderitems.ITEM_PRICE = MAX(ITEM_PRICE)
  AND Customers.CUST_ID = Oreders.CUST_ID
  AND Oreders.ORDER_NUM = Oreders.ORDER_NUM
);




/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUST_NAME AS "Customer_name"
FROM 
(
  SELECT CUST_NAME
  FROM Customers, OrderItems, Orders
  WHERE Orderitems.ITEM_PRICE = MAX(ITEM_PRICE)
  AND Customers.CUST_ID = Oreders.CUST_ID
  AND Oreders.ORDER_NUM = Oreders.ORDER_NUM
);


/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:






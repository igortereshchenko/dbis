
change
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
виконувати вибірку даних та створювати і змінювати таблиці. 4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

-- USER SQL
CREATE USER tereshchenko IDENTIFIED BY tereshchenko 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER tereshchenko QUOTA 100M ON USERS;

-- ROLES
GRANT "CONNECT" TO tereshchenko ;

-- SYSTEM PRIVILEGES
GRANT CREATE ANY TABLE TO tereshchenko ;
GRANT ALTER ANY TABLE TO tereshchenko ;
GRANT SELECT ANY TABLE TO tereshchenko ;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Піца може складатися з різних наповнювачів. 4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE PIZZA(
  pizza_name VARCHAR2(30) NOT NULL
);
ALTER TABLE  PIZZA
  ADD CONSTRAINT pizza_pk PRIMARY KEY (pizza_name);
-------------------------------------------------------

CREATE TABLE INGREDIENT(
  ingredient_name VARCHAR2(30) NOT NULL
);
ALTER TABLE  INGREDIENT
  ADD CONSTRAINT ingredient_pk PRIMARY KEY (ingredient_name);  

-------------------------------------------------------
CREATE TABLE PIZZA_INGREDIENT(
  pizza_name_fk VARCHAR2(30) NOT NULL,
  ingredient_name_fk VARCHAR2(30) NOT NULL,
  ingredient_weight NUMBER(8,2) NOT NULL
);

ALTER TABLE  PIZZA_INGREDIENT
  ADD CONSTRAINT pizza_ingredient_pk PRIMARY KEY (pizza_name_fk,ingredient_name_fk);  
  
ALTER TABLE  PIZZA_INGREDIENT
  ADD CONSTRAINT pizza_fk FOREIGN KEY (pizza_name_fk) REFERENCES PIZZA (pizza_name);
  
ALTER TABLE  PIZZA_INGREDIENT
  ADD CONSTRAINT ingredient_fk FOREIGN KEY (ingredient_name_fk) REFERENCES INGREDIENT (ingredient_name);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 
---------------------------------------------------------------------------*/
--Код відповідь:
GRANT INSERT ANY TABLE TO tereshchenko ;


/*---------------------------------------------------------------------------
3.a. Вивести дані про покупця, що проживає в Америці: його ім’я, назвавши стовпчик як client_name,
а його ZIP-код - назвавши цей стовпчик client_code напроти кожного покупця вивести номер його замовлення. 
Join використовувати заборонено. Виконати завдання в SQL. 4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT                        -- select customers with orders
  CUST_NAME as "client_name", -- save register using " "
  CUST_ZIP as "client_code",
  ORDER_NUM
FROM CUSTOMERS, ORDERS
  WHERE
    CUST_COUNTRY = 'USA'
    and
    CUSTOMERS.CUST_ID=ORDERS.CUST_ID
    
UNION                         -- union customers without order

SELECT
  CUST_NAME as "client_name", -- save register using " "
  CUST_ZIP as "client_code",
  null as ORDER_NUM           -- rename column to make UNION
FROM CUSTOMERS
  WHERE CUST_ID NOT IN (
                        SELECT CUST_ID   --CUST_ID of customers with orders
                          FROM ORDERS
                      )
    and
    CUST_COUNTRY = 'USA';


/*---------------------------------------------------------------------------
3.b. Вивести дані покупця: його ім’я, назвавши client_name заголовок стовпчика та 
повну його адресу як одне поле, взявши zip код у дужки –  назва стовпчика client_address. 
Виконати завдання в SQL. 4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT 
  TRIM(CUST_NAME) as "client_name", -- save register using " "
  TRIM(CUST_ADDRESS) 
  ||' '
  || TRIM(CUST_CITY) 
  || TRIM(CUST_STATE) 
  || ' (' 
  || TRIM(CUST_ZIP) 
  || ') ' 
  || TRIM(CUST_COUNTRY) as "client_address"
FROM CUSTOMERS;

/*---------------------------------------------------------------------------
c. Вивести назву товару* на ім’я замовника, який його не замовляв. 
Виконати завдання в SQL. 4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

SELECT                      -- final projection, we don't need CUST_ID
  TRIM(PROD_NAME),
  TRIM(CUST_NAME)
FROM (
        SELECT DISTINCT             -- select all combination of customer and product
          CUSTOMERS.CUST_ID,
          CUSTOMERS.CUST_NAME,
          PRODUCTS.PROD_NAME
        FROM CUSTOMERS, PRODUCTS 
        
        MINUS               -- minus combination customer with his product
        
        SELECT DISTINCT     -- use DISTINCT because customer may order the same product few times in different orders
           CUSTOMERS.CUST_ID,-- select CUST_ID (primary key) because we can lose customer by distinct, the same names but different cust_id
           CUSTOMERS.CUST_NAME,
           PRODUCTS.PROD_NAME
        FROM CUSTOMERS, ORDERS, ORDERITEMS, PRODUCTS
          WHERE
            CUSTOMERS.CUST_ID = ORDERS.CUST_ID
            and
            ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
            and
            ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
      );

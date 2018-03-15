-- LABORATORY WORK 1
-- BY Berenchuk_Olha

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Berenchuk
IDENTIFIED BY koko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER Berenchuk QUOTA 100M ON USERS;
GRANT DROP ANY TABLE TO Berenchuk;
GRANT INSERT ANY TABLE TO Berenchuk;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE mobile
(
  name_mob varchar2(20) NOT NULL
);

ALTER TABLE mobile
ADD CONSTRAINT name_key
PRIMARY KEY (name_mob);

CREATE TABLE price
(
  coust_mob NUMBER(4,2) NOT NULL
);

ALTER TABLE price
ADD CONSTRAINT coust_key
PRIMARY KEY (coust_mob);

CREATE TABLE mobile_price
(
  name_mob_after varchar2(20) NOT NULL,
  coust_mob_after NUMBER(4,2) NOT NULL,
  colour varchar2(20)
);

ALTER TABLE mobile_price
ADD CONSTRAINT mobile_price_key
PRIMARY KEY (name_mob_after, coust_mob_after);

ALTER TABLE mobile_price
ADD CONSTRAINT name_key 
FOREIGN KEY (name_mob_after)
REFERENCES mobile(name_mob);

ALTER TABLE mobile_price
ADD CONSTRAINT coust_key
FOREIGN KEY (coust_mob_after)
REFERENCES price(coust_mob);

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT SELECT ANY TABLE TO Berenchuk;
GRANT ALTER ANY TABLE TO Berenchuk;
GRANT CREATE ANY TABLE TO Berenchuk;




/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT PROD_PRICE {PRODUCT}
WHERE MAX(PRODE_PRICE) AND PRODE_PRICE = NULL;



/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUST_NAME AS "Customer_name" FROM CUSTOMERS
WHERE CUST_NAME = MAX(PROD_PRICE);













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT (CUST_NAME || CUST_COUNTRY) as "vendor_name" from CUSTOMERS, PRODUCTS
where = NULL;

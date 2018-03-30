-- LABORATORY WORK 1
-- BY Moroziuk_Yevhenii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER student IDENTIFIED BY student 
DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";

ALTER USER student QUOTA 100M ON USERS;

GRANT DROP ANY TABLE TO student;
GRANT INSERT ANY TABLE TO student;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE PERSON(
person_name char(20) NOT NULL
);
CREATE TABLE TELEPHONE(
tel_mark char(20) NOT NULL
);
CREATE TABLE PERSONS_TELEPHONE(
person_name_fk char(20) NOT NULL,
tel_mark_fk char(20) NOT NULL
);
ALTER TABLE PERSON
  ADD CONSTRAINT person_name_pk PRIMARY KEY(person_name);
  
ALTER TABLE TELEPHONE
  ADD CONSTRAINT tel_mark_pk PRIMARY KEY(tel_mark);

ALTER TABLE PERSONS_TELEPHONE
  ADD CONSTRAINT per_tel_pk PRIMARY KEY(person_name_fk, tel_mark_fk);

ALTER TABLE PERSONS_TELEPHONE
  ADD CONSTRAINT person_fk FOREIGN KEY(person_name_fk) REFERENCE PERSON(person_name);

ALTER TABLE PERSONS_TELEPHONE
  ADD CONSTRAINT tel_mark_fk FOREIGN KEY(tel_mark_fk) REFERENCE PERSON(tel_mark);

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO student;
GRANT INSERT ANY TABLE TO student;
GRANT SELECT ANY TABLE TO student;




/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:












/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT CUST_NAME as "Customer_name"
FROM CUSTOMERS, ORDERS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
AND ORDERS.ORDER_NUM IN (
  SELECT ORDERITEMS.ORDER_NUM
  FROM ORDERITEMS
  WHERE ORDERITEMS.ITEM_PRICE = (
    SELECT MAX(ORDERITEMS.ITEM_PRICE)
    FROM ORDERITEMS)
    







/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT TRIM(VEND_NAME)||' '||TRIM(VEND_COUNTRY) as "vendor_name"
FROM VENDORS, PRODUCTS

MINUS

(SELECT TRIM(VEND_NAME)||' '||TRIM(VEND_COUNTRY) as "vendor_name"
FROM VENDORS, PRODUCTS
WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID);





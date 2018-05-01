-- LABORATORY WORK 1
-- BY Beziazychna_Kateryna
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати дані у таблиці та робити запити.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER bez
IDENTIFIED BY kater
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

GRANT "CONNECT" TO bez;

ALTER USER bez QUOTA 100M ON "USERS";

GRANT ALTER ANY TABLE TO bez;
GRANT SELECT ANY TABLE TO bez;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент йде на пару. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE STUDENT(
  student varchar2(30) NOT NULL 
);
ALTER TABLE STUDENT
ADD CONSTRAINT student_pk PRIMARY KEY(student);

CREATE TABLE LESSONS(
  lessons varchar2(20) NOT NULL
);
ALTER TABLE LESSONS
ADD CONSTRAINT lessons_pk PRIMARY KEY(lessons);

CREATE TABLE STUDENTLESSONS(
  student_name varchar2 NOT NULL,
  lessons_name varchar2 NOT NULL,
  lessons_time number(6,2) NOT NULL
);
ALTER TABLE STUDENTLESSONS
ADD CONSTRAINT studentlessons_pk PRIMARY KEY(student_name,lessons_name);

ALTER TABLE STUDENTLESSONS
ADD CONSTRAINT student_fk FOREIGN KEY(student_name) REFERENCES STUDENT(student);

ALTER TABLE STUDENTLESSONS
ADD CONSTRAINT lessons_fk FOREIGN KEY(lessons_name) REFERENCES LESSONS(lessons);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO bez;
GRANT INSERT ANY TABLE TO bez;
GRANT SELECT ANY TABLE TO bez;

/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший продукт.
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_NAME
FROM CUSTOMERS
WHERE ITEM_PRICE = MIN(ORDERITEMS.ITEM_PRICE);

/*---------------------------------------------------------------------------
3.b. 
Вивести номер замовлення та назву товару у даному замовленні, за умови, що товар продає постачальник з іменем "John".
Виконати завдання в Алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
PROJECT (ORDERSITEMS){ORDER_NUM,PROD_ID}
WHERE VENDORS.VEND_ID = "John";

/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name у нижньому регістрі, для тих покупців, що не купляли продукти постачальника "Mike". 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT (LOWER(CUST_COUNTRY || CUST_EMAIL)) AS "client_name"
FROM CUSTOMERS
WHERE PRODUCTS.PROD_ID != ORDERITEMS.PROD_ID AND VENDORS.VEND_NAME != "Mike";


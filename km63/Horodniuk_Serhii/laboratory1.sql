-- LABORATORY WORK 1
-- BY Horodniuk_Serhii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER gorodnyuk
IDENTIFIED BY serg
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

GRANT "CONNECT" ON gorodnyuk;

ALTER USER QUOTA 100M TO gorodnyuk;

GRANT ALTER ANY TABLE TO gorodnyuk;
GRANT DROP ANY TABLE TO gorodnyuk;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Користувач Facebook читає новини.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE user_face 
(
    name_user varchar2(30) NOT NULL;
);

ALTER TABLE user_face
    ADD CONSTRAIN user_pk PRIMARY KEY (name_user);

CREATE TABLE news_face
(
    name_news varchar2(30) NOT NULL;
);

ALTER TABLE news_face
    ADD CONSTRAIN news_pk PRIMARY KEY (name_news);
    
CREATE TABLE user_news
(
    name_user_after varchar2(30) NOT NULL;
    name_news_after varchar2(30) NOT NULL;
    views_news number(20,0) NOT NULL;
);

ALTER TABLE user_news
    ADD CONSTRAIN user_news_pk PRIMARY KEY (name_user_after, name_news_after);
    
ALTER TABLE user_news
    ADD CONSTRAIN name_user_fk FOREIGN KEY (name_user_after) REFERENCES user_face (name_user);
    
ALTER TABLE user_news
    ADD CONSTRAIN name_news_fk FOREIGN KEY (name_news_after) REFERENCES news_face (name_news);


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO gorodnyuk;
GRANT INSERT ANY TABLE TO gorodnyuk;
GRANT SELECT ANY TABLE TO gorodnyuk;


/*---------------------------------------------------------------------------
3.a. 
Які назви товарів, що не продавались покупцям?
Виконати завдання в алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT ORDERS.ORDER_NUM (CUSTOMERS * ORDERS)
WHERE ORDERS.ORDER_NUM NOT NULL;

/*---------------------------------------------------------------------------
3.b. 
Яка найдовша назва купленого товару?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT MAX(COUNT(prod_name)
FROM CUSTOMERS, ORDERITEMS, ORDERS, PRODUCTS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
AND
ORDERS.CUST_ID = ORDERITEMS.PROD_ID
AND
ORDERITEMS.PROD_ID = VENDORS.VEND_ID;


/*---------------------------------------------------------------------------
c. 
Вивести ім'я та пошту покупця, як єдине поле client_name, для тих покупців, що мають не порожні замовлення.
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT (CUSTOMERS.CUST_NAME || CUSTOMERS.CUST_EMAIL) AS "client_name"
FROM CUSTOMERS, ORDERS
WHERE ORDERS.ORDER_NUM NOT NULL;

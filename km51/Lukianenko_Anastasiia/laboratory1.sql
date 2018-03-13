/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER alukyanenko IDENTIFIED BY alukyanenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER alukyanenko QUOTA 100M on "USERS";
GRANT "CONNECT" TO alukyanenko;
GRANT INSERT ANY TABLE TO alukyanenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина танцює під музику.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE HUMAN(
HUMAN_NAME VARCHAR(30) NOT NULL
);
ALTER TABLE HUMAN
    ADD CONSTRAINT HUMAN_PK PRIMARY KEY (HUMAN_NAME);
    
CREATE TABLE MUSIC(
MUSIC_NAME VARCHAR(30) NOT NULL
);
ALTER TABLE MUSIC
    ADD CONSTRAINT MUSIC_PK PRIMARY KEY (MUSIC_NAME);

CREATE TABLE PLAYLIST(
MUSIC_NAME_FK VARCHAR(30) NOT NULL,
HUMAN_NAME_FK VARCHAR(30) NOT NULL
);
ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_PK PRIMARY KEY (MUSIC_NAME_FK, HUMAN_NAME_FK);

ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_FK FOREIGN KEY MUSIC_NAME_FK REFERENCES MUSIC(MUSIC_NAME);











  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO alukyanenko;





/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдорожчого товару?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT DISCTINCT(ORDERITEMS, PRODUCTS)
WHERE ORDERITEMS.ITEM_PRICE = MAX(ITEM_PRICE)
    AND ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
{PRODUCTS.PROD_NAME}





/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найкоротшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT DISTINCT 
    MIN(LENGTH(CUST_NAME)) AS "long_name"
FROM CUSTOMERS;












/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT DISTINCT
    TRIM(CUST_NAME) || ' ' ||
    TRIM(CUST_EMAIL) AS "client_name"
FROM CUSTOMERS, ORDERS
WHERE ORDERS.CUST_ID != CUSTOMERS.CUST_ID;

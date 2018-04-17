-- LABORATORY WORK 1
-- BY Kurshakov_Mykhailo
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Kurshakov IDENTIFIED BY 123456
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER Kurshakov QUOTA 100M ON USERS;

GRANT "CONNECT" TO Kurshakov;

GRANT INSERT ANY TABLE TO Kurshakov;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина танцює під музику.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE music 
(
  type_of_music char(30) NOT NULL
);
ALTER TYPE music ADD CONSTRAIN type_of_music_pk PRIMARY KEY(type_of_music);

CREATE TABLE dance 
(
  dance_type char(30) NOT NULL
);
ALTER TYPE dance ADD CONSTRAIN dance_type_pk PRIMARY KEY(dance_type);

CREATE TABLE human 
(
  type_of_music_fk char(30) NOT NULL,
  dance_type_fk char(30) NOT NULL,
  human char(30)
);

ALTER TABLE human ADD CONSTRAIN human_pk PRIMARY KEY(type_of_music_fk,dance_type_fk);

ALTER TABLE human ADD CONSTRAIN typemusic_fk FOREIGN KEY(type_of_music_fk) 
REFERENCE music(type_of_music);

ALTER TABLE human ADD CONSTRAIN dancetype_fk FOREIGN KEY(dance_type_fk) 
REFERENCE dance(dance_type);


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO Kurshakov;
GRANT SELECT ANY TABLE TO Kurshakov;
GRANT UPDATE ANY TABLE TO Kurshakov;


/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдорожчого товару?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT (ORDERITEMS TIMES PRODUCTS 
    WHERE ORDERITEMS.ITEM_PRICE = (PROJECT (ORDERITEMS) {MAX(ITEM_PRICE)}) 
        AND PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID){PROD_NAME}; 

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найкоротшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_CONTACT as "long_name" 
FROM CUSTOMERS
    WHERE LENGTH(TRIM(CUST_CONTACT)) = (SELECT MIN(LENGTH(TRIM(CUST_CONTACT))) FROM CUSTOMERS);






/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT CUSTOMERS.CUST_CONTACT||CUSTOMERS.CUST_EMAIL AS "client_name"
FROM CUSTOMERS
WHERE 
    (SELECT CUST_ID FROM CUSTOMERS
    MINUS
    SELECT DISTINCT CUST_ID FROM ORDERS) = CUSTOMERS.CUST_ID;

;


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

CREATE TABLE USERS(
EMAIL VARCHAR(30) NOT NULL,
USER_NAME VARCHAR(30) NULL,
USER_LASTNAME VARCHAR(30) NULL,
SEX VARCHAR(30) NULL
);

ALTER TABLE USERS
    ADD CONSTRAINT USER_PK PRIMARY KEY (EMAIL);

CREATE TABLE MUSIC(
MUSIC_NAME VARCHAR(30) NOT NULL,
GENRE VARCHAR(30) NULL,
AUTHOR VARCHAR(30) NOT NULL,
DANCE_LEVEL NUMBER(1,0) NULL
);

ALTER TABLE MUSIC
    ADD CONSTRAINT MUSIC_PK PRIMARY KEY (MUSIC_NAME, AUTHOR);

CREATE TABLE PLAYLIST(
EMAIL_FK VARCHAR(30) NOT NULL,
MUSIC_NAME_FK VARCHAR(30) NOT NULL,
AUTHOR_FK VARCHAR(30) NOT NULL,
PLAYLIST_NAME VARCHAR(30) NULL
);

ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_PK PRIMARY KEY (EMAIL_FK, MUSIC_NAME_FK, AUTHOR_FK);

CREATE TABLE USER_CONTACTS(
EMAIL_FK VARCHAR(30) NOT NULL,
CONTACT_EMAIL VARCHAR(30) NOT NULL,
CONTACT_NAME VARCHAR(30) NULL,
DATE_ADDED DATE NULL
);

ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT USER_CONTACTS_PK PRIMARY KEY (EMAIL_FK, CONTACT_EMAIL);

ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_FK FOREIGN KEY (MUSIC_NAME_FK, AUTHOR_FK) REFERENCES MUSIC(MUSIC_NAME, AUTHOR);
ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_USER_FK FOREIGN KEY (EMAIL_FK) REFERENCES USERS(EMAIL);

ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT USER_CONTACTS_FK FOREIGN KEY (EMAIL_FK) REFERENCES USERS(EMAIL);

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO alukyanenko;
GRANT INSERT ANY TABLE TO alukyanenko;
GRANT SELECT ANY TABLE TO alukyanenko;

/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдорожчого товару?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT(orderitems TIMES products)
WHERE
    orderitems.item_price = (
        PROJECT(orderitems)
        {MAX(item_price)}
    )
    AND   orderitems.prod_id = products.prod_id
{products.prod_name}

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найкоротшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT DISTINCT
    cust_name AS "long_name"
FROM
    customers
WHERE
    length(TRIM(customers.cust_name) ) IN (
        SELECT
            MIN(length(TRIM(customers.cust_name) ) )
        FROM
            customers
    );

/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
    TRIM(cust_name)
    || ' '
    || TRIM(cust_email) AS "client_name"
FROM
    customers
WHERE
    customers.cust_id NOT IN (
        SELECT
            cust_id
        FROM
            orders
    );

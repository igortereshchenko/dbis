-----------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER korin IDENTIFIED  BY korin
DEFAULT TABLESPACE "USER";
TEMPORARY TABLESPACE "TREMP";

ALTER TABLE korin QUOTA 100M ON USER;

GRANT 'CONNECT' TO korin;

GRANT ALTER ANY TABLE TO korin;
GRANT DELETE ANY TABLE TO korin;



/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Користувач Facebook читає новини.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE users (
user_id NUMBER(8) NOT NULL,
user_name VARCHAR(8) NOT NULL,
user_birthdate date NOT NULL,
phone NUMBER(8) NOT NULL,
user_password VARCHAR(10) NOT NULL
);
ALTER TABLE users ADD CONSTRAINT users_id_pk PRIMARY KEY (users_id, phone);
ALTER TABLE users ADD CONSTRAINT date_of_birth_check CHECK (user_birthdate < '1997-01-01');
ALTER TABLE users ADD CONSTRAINT password_check CHECK(user_password REGEXP_LIKE('^[0-9]{10}'));
INSERT INTO users(user_id, user_name, user_birthdate, phone, user_password)
VALUES('10000001', 'Village Toys', '1990-01-02', '+380989236842', 'theg6666');
INSERT INTO users(user_id, user_name, user_birthdate, phone, user_password)
VALUES('10000002', 'Village tery', '1980-01-02', '+380989232842', 'theg8666');   
INSERT INTO users(user_id, user_name, user_birthdate, phone, user_password)
VALUES('10000003', 'Village hary', '1970-01-02', '+380989936842', 'theg9666');   
CREATE TABLE news (
news_id NUMBER(8) NOT NULL,
news_heder VARCHAR(8) NOT NULL CHECK (price > 0),
news_body VARCHAR(255) NOT NULL,
publish date NOT NULL
);
ALTER TABLE news ADD CONSTRAINT news_id_pk PRIMARY KEY (news_id);
INSERT INTO news(news_id, news_heder, publish, news_body)
VALUES('20000001', 'temperature', '1990-01-02', 'huig gugs tyut guit 7s8');
INSERT INTO news(news_id, news_heder, publish, news_body)
VALUES('20000002', 'temperature flu', '1991-01-05', 'huig  tyut guit 7s8');
INSERT INTO news(news_id, news_heder, publish, news_body)
VALUES('20000003', 'temperature oh', '1992-11-02', 'huig gugs tyut  7s8');
CREATE TABLE users_news(
user_id_fk NUMBER(8) NOT NULL,
news_id_fk NUMBER(8) NOT NULL,
news_heder VARCHAR(8) NOT NULL,
news_body VARCHAR(255) NOT NULL,
publish_date date NOT NULL,
user_name VARCHAR(8) NOT NULL,
user_birthdate date NOT NULL,
phone NUMBER(8) NOT NULL,
user_password VARCHAR(10) NOT NULL
);

ALTER TABLE users_news ADD CONSTRAINT user_id_news_id_pk PRIMARY KEY (user_id_fk, news_id_fk);
ALTER TABLE users_news ADD CONSTRAINT user_id_fk FOREIGN KEY (user_id_fk) REFERENCE (users_id);
ALTER TABLE users_news ADD CONSTRAINT news_id_fk FOREIGN KEY (news_id_fk) REFERENCE (news_id);

INSERT INTO users_news(user_id, user_name, user_birthdate, phone, user_password, news_id, news_heder, publish, news_body)
VALUES('10000001', 'Village Toys', '1990-01-02', '+380989236842', 'theg6666', '20000001', 'temperature', '1990-01-02', 'huig gugs tyut guit 7s8'); 
INSERT INTO users_news(user_id, user_name, user_birthdate, phone, user_password, news_id, news_heder, publish, news_body)
VALUES('10000002', 'Village tery', '1980-01-02', '+380989932842', 'theg8666', '20000002', 'temperature flu', '1991-01-05', 'huig  tyut guit 7s8');
INSERT INTO users_news(user_id, user_name, user_birthdate, phone, user_password, news_id, news_heder, publish, news_body)
VALUES('10000003', 'Village hary', '1970-01-02', '+380989936842', 'theg9666', '20000003', 'temperature oh', '1992-11-02', 'huig gugs tyut  7s8'); 
CREATE TABLE like_news(
like_date_pk date NOT NULL,
news_id_fk NUMBER(8) NOT NULL,
news_heder VARCHAR(8) NOT NULL CHECK (price > 0),
news_body VARCHAR(255) NOT NULL,
publish date NOT NULL
);

ALTER TABLE like_news ADD CONSTRAINT like_date_news_id_pk PRIMARY KEY (like_date_pk, news_id_fk);
ALTER TABLE like_news ADD CONSTRAINT news_id_fk FOREIGN KEY (news_id_fk) REFERENCE (news_id);

INSERT INTO news(like_date, news_id, news_heder, publish, news_body)
VALUES('1990-01-02', '20000001', 'temperature', '1990-01-02', 'huig gugs tyut guit 7s8');
INSERT INTO news(like_date, news_id, news_heder, publish, news_body)
VALUES('1990-01-02', '20000002', 'temperature flu', '1991-01-05', 'huig  tyut guit 7s8');
INSERT INTO news(like_date, news_id, news_heder, publish, news_body)
VALUES('1990-01-02', '20000003', 'temperature oh', '1992-11-02', 'huig gugs tyut  7s8');


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO korin;
GRANT INSERT ANY TABLE TO korin;
GRANT SELECT ANY TABLE TO korin;


/*---------------------------------------------------------------------------
3.a. 
Які назви товарів, що не продавались покупцям?
Виконати завдання в алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
PROJECT(Products WHERE prod_id NOT IN
(PROJECT(OrderItems))
{OrderItems.prod_id })
{prod_name}
/*---------------------------------------------------------------------------
3.b. 
Яка найдовша назва купленого товару?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT PROD_NAME
FROM PRODUCTS
WHERE 
    LENGTH(RTRIM(PROD_NAME)) = (SELECT
    MAX(LENGTH(RTRIM(PROD_NAME)))
    FROM PRODUCTS, ORDERITEMS 
    WHERE PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
    );    

/*---------------------------------------------------------------------------
c. 
Вивести ім'я та пошту покупця, як єдине поле client_name, для тих покупців, що мають не порожні замовлення.
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT TRIM(CUST_NAME) || ' ' || TRIM(CUST_EMAIL) AS client_name
FROM CUSTOMERS
WHERE CUST_ID IN (SELECT CUST_ID
                        FROM ORDERS);

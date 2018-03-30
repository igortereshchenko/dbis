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
user_password VARCHAR(10) NON NULL
);
ALTER TABLE users ADD CONSTRAINT users_id_pk PRIMARY KEY (users_id);
ALTER TABLE users ADD CONSTRAINT date_of_birth_check CHECK (user_birthdate < '1997-01-01');
ALTER TABLE users ADD CONSTRAINT password_check CHECK(user_password REGEXP_LIKE('^[0-9]{10}');
                                                      
CREATE TABLE news (
news_id NUMBER(8) NOT NULL,
news_heder VARCHAR(8) NOT NULL CHECK (price > 0),
news_body VARCHAR(255) NOT NULL,
publish_date date NOT NULL
);
ALTER TABLE news ADD CONSTRAINT news_id_pk PRIMARY KEY (news_id);

                                                      
CREATE TABLE users_news(
user_id_fk NUMBER(8) NOT NULL,
news_id_fk NUMBER(8) NOT NULL,
news_heder VARCHAR(8) NOT NULL CHECK (price > 0),
news_body VARCHAR(255) NOT NULL,
publish_date date NOT NULL
);
ALTER TABLE users_news ADD CONSTRAINT user_id_news_id_pk PRIMARY KEY (user_id_fk, news_id_fk);
ALTER TABLE users_news ADD CONSTRAINT user_id_fk FOREIGN KEY (user_id_fk) REFERENCE (users_id);
ALTER TABLE users_news ADD CONSTRAINT news_id_fk FOREIGN KEY (user_id_fk) REFERENCE (news_id);

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

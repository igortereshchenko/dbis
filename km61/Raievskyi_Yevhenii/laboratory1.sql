/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE USER raevskiy IDENTIFIED BY 1344
DEFAULT TABLESPACE "USER"
TEMPORARY TABLESPACE "TEMP";
GRANT 'CONNECT' TO raevskiy;
GRANT CREATE ANY TABLE TO raevskiy;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


DROP TABLE students cascade constraints PURGE;
DROP TABLE operators cascade constraints PURGE;
DROP TABLE numbers cascade constraints PURGE;
DROP TABLE students_numbers cascade constraints PURGE;

CREATE TABLE students
(
    stud_id NUMBER(15) NOT NULL,
    stud_name VARCHAR(50) NOT NULL,
    stud_surname VARCHAR(50) NOT NULL,
    stud_gender VARCHAR(1) NULL
);

ALTER TABLE students
    ADD CONSTRAINT stud_pk PRIMARY KEY (stud_id);

CREATE TABLE operators
(
    operator_id NUMBER(10) NOT NULL,
    operator_name VARCHAR(50) NOT NULL,
    operator_website VARCHAR(50) NULL,
    operator_address VARCHAR(50) NULL
);

ALTER TABLE operators
    ADD CONSTRAINT operator_pk PRIMARY KEY (operator_id);
    
CREATE TABLE numbers
(
    phone_number NUMBER(15, 0) NOT NULL,
    phone_country VARCHAR(50) NOT NULL,
    phone_payment_type VARCHAR(50) NULL
);

ALTER TABLE numbers
    ADD CONSTRAINT numbers_pk PRIMARY KEY (phone_number);
    
CREATE TABLE students_numbers
(
    stud_id_fk NUMBER(15) NOT NULL,
    phone_number_fk NUMBER(15, 0) NOT NULL,
    operator_id_fk NUMBER(10) NOT NULL
);

ALTER TABLE students_numbers
    ADD CONSTRAINT students_numbers_pk PRIMARY KEY (stud_id_fk, phone_number_fk, operator_id_fk);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT stud_id_fk FOREIGN KEY (stud_id_fk) REFERENCES students (stud_id);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT phone_number_fk FOREIGN KEY (phone_number_fk) REFERENCES numbers (phone_number);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT operator_id_fk FOREIGN KEY (operator_id_fk) REFERENCES operators (operator_id);
    
INSERT INTO students VALUES (666, 'Eugen', 'R', 'M');
INSERT INTO students VALUES (85612, 'Anna', 'C', 'F');
INSERT INTO students VALUES (50, 'Ortem', 'M', 'M');

ALTER TABLE students ADD CONSTRAINT students_gender_ch CHECK (gender = 'M' OR gender = 'F' OR gender = NULL);
ALTER TABLE students ADD CONSTRAINT students_gender_ch CHECK (gender = 'M' OR gender = 'F' OR gender = NULL);

INSERT INTO operators VALUES (1, 'Valw', 'http://valw.com', 'WIawiduhawiudh st.');
INSERT INTO operators VALUES (2, 'Qkfg', NULL, NULL);
INSERT INTO operators VALUES (3, 'Olkaw', NULL, NULL);

INSERT INTO numbers VALUES (380504289133, 'USA', NULL);

INSERT INTO students_numbers VALUES (666, 380504289133, 1);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


GRANT SELECT ANY TABLE to raevskiy;
GRANT INSERT ANY TABLE to raevskiy;


/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


PROJECT (DISTINCT(CUST_NAME, PROD_PRICE)
TIMES
(CUSTOMERS, ORDERS, ORDERITEMS, PRODUCTS)
WHERE (CUSTOMERS.CUST_ID = ORDERS.CUST_ID &
ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM &
ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID &
PRODUCTS.PROD_PRICE =
(PROJECT MIN(PROD_PRICE)
TIMES
PRODUCTS
))


/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT DISTINCT
    '(' || TRIM(cust_name) || ')' AS client_name
FROM
    customers
WHERE
    cust_email IS NULL
INTERSECT
(
SELECT
    '(' || TRIM(cust_name) || ')' AS client_name
FROM
    customers
MINUS
SELECT
    '(' || TRIM(cust_name) || ')' AS client_name
FROM
    customers,
    orders
WHERE
    customers.cust_id = orders.cust_id
);
    

/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
    UPPER(vendors.vend_name) as "vendor_name"
FROM
    vendors
MINUS
SELECT
    UPPER(vendors.vend_name) as "vendor_name"
FROM
    vendors, products
WHERE
    vendors.vend_id = products.vend_id;

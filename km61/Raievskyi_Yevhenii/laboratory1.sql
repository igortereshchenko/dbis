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


CREATE TABLE students
(
    stud_name VARCHAR(50)
);

ALTER TABLE students
    ADD CONSTRAINT stud_pk PRIMARY KEY (stud_name);

CREATE TABLE numbers
(
    phone_number NUMBER(15, 0),
    phone_country VARCHAR(50)
);

ALTER TABLE numbers
    ADD CONSTRAINT numbers_pk PRIMARY KEY (phone_number);
    
CREATE TABLE students_numbers
(
    stud_name_fk VARCHAR(50),
    phone_number_fk NUMBER(15, 0)
);

ALTER TABLE students_numbers
    ADD CONSTRAINT students_numbers_pk PRIMARY KEY (stud_name_fk, phone_number_fk);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT stud_name_fk FOREIGN KEY (stud_name_fk) REFERENCES students (stud_name);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT phone_number_fk FOREIGN KEY (phone_number_fk) REFERENCES numbers (phone_number);
  
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


PROJECT 


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
UNION
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


/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER student
IDENTIFIED by Artem
Default Tablespace "Users"
Temporary Tablespace "TEMP";
Alter User student QUOTA 100M on Users;
/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABlE student(
  student_name varchar(10) not null
 );
 
 CREATE TABLE telephon_number (
   number varchar (10) not null
 );
 AlTER TABLE student
 add constraint student_pk PRIMARY KEY(student_name);
 
 ALTER telephon_number
 add constraint telephon_number_pk PRIMARY KEY(number);
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant create any table to student;
grant insert any table to student;
grant select any table to student;
/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT CUSTOMERS TIMES ORDERS TIMES ORDERITEMS {CUSTOMERS.CUST_NAME} 
    WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID AND 
                    ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM AND
                        ORDERITEMS.ITEM_PRICE IN (PROJECT ORDERITEMS {MIN(ITEM_PRICE)});

/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
SELECT '('||TRIM(CUST_NAME)||')' AS "client_name"
FROM (
    SELECT CUST_NAME, CUST_ADDRESS
    FROM CUSTOMERS
    WHERE CUST_ID NOT IN (
        SELECT CUST_ID
        FROM ORDERS
    )
)
WHERE CUST_ADDRESS IS NULL;
/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
SELECT UPPER(VEND_NAME) AS "vendor_name"
FROM VENDORS
WHERE VEND_ID NOT IN(
    SELECT VEND_ID
    FROM PRODUCTS
);

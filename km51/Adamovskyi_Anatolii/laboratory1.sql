-- LABORATORY WORK 1
-- BY Adamovskyi_Anatolii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER adamovskiy IDENTIFIED BY password
    DEFAULT TABLESPACE "USERS"
    TEMPORARY TABLESPACE "TEMP"
    QUOTA 100 M ON users;

GRANT "CONNECT" TO adamovskiy;

GRANT
    SELECT ANY TABLE
TO adamovskiy;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table computer(
    comp_name varchar2(30),
);
alter table computer
  add constraint comp_pk primary key (comp_name);

drop table computer;

create table aparat(
  prosesor varchar2(30),
  block_power varchar2(30)
);
alter table aparat
  add constraint apar_pk primary key (block_power);

create table prog(
  prog_name varchar2(30)
);
alter table prog
  add constraint prog_id primary key (prog_name);

alter table computer
  add constraint comp_apparat_fk foreign key (apar_pk) references aparat;
alter table prog
  add constraint comp_prog_fk foreign key (prog_pk) references prog;


  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
GRANT
    CREATE ANY TABLE
TO adamovskiy;

GRANT
    INSERT ANY TABLE
TO adamovskiy;

GRANT
    SELECT ANY TABLE
TO adamovskiy;

/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

-- Відповідь reviewer-а

PROJECT(
    orderitems TIMES products
    WHERE orderitems.prod_id = products.prod_id
    AND products.prod_price = max(
        PROJECT products {prod_price}
    )
){order_num}

-- Відповідь reviewer-а переписана в SQL

SELECT
    order_num
FROM
    orderitems,
    products
WHERE
    orderitems.prod_id = products.prod_id
    and products.prod_price = max(
        SELECT 
            prod_price
        FROM
            products
    );

-- Завдання було виконано неправильно

-- Правильна відповідь

SELECT
    orders.order_num
FROM
    orders,
    orderitems
WHERE
    orders.order_num = orderitems.order_num
    AND   orderitems.item_price IN (
        SELECT
            MAX(item_price)
        FROM
            orderitems
    );

/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

-- Відповідь reviewer-а

PROJECT 
    customers{cust_name} 
RENAME cust_name AS count_name

-- Якщо проігнорувати неправильний синтаксис то можна переписати це в ось такий SQL запит

SELECT
    cust_name count_name
FROM
    customers;

-- Завдання було виконано неправильно

-- Правильна відповідь

SELECT
    COUNT(DISTINCT customers.cust_name) count_name
FROM
    customers,
    orders
WHERE
    orders.cust_id = customers.cust_id;

/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/

-- reviewer на надав його метод розв'язку даної задач в SQL

-- Правильна відповідь 

SELECT DISTINCT
    lower(TRIM(vendors.vend_name) ) vendor_name
FROM
    vendors,
    products
WHERE
    vendors.vend_id = products.vend_id
MINUS
SELECT DISTINCT
    lower(TRIM(vendors.vend_name) ) vendor_name
FROM
    vendors,
    products,
    orderitems
WHERE
    vendors.vend_id = products.vend_id
    AND   products.prod_id = orderitems.prod_id;

(
    PROJECT(
        vendors TIMES products
        WHERE
            vendors.vend_id = products.vend_id
    ){lower(TRIM(vendors.vend_name))} 
    RENAME TRIM(vendors.vend_name)) as vendor_name)

MINUS

(
    PROJECT(
        vendors TIMES products TIMES orderitems
        WHERE
            vendors.vend_id = products.vend_id
            AND  products.prod_id = orderitems.prod_id
    ){lower(TRIM(vendors.vend_name))} 
    RENAME TRIM(vendors.vend_name)) as vendor_name);

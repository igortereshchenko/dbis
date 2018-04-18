/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

--rewier's version
create user herasko IDENTIFIED by herasko;
grant create any table to herasko;

GRANT "CONNECT" TO herasko ;

DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER herasko QUOTA 200M ON USERS;

-- author's version
CREATE USER herasko IDENTIFIED BY herasko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER herasko QUOTA 200M ON USERS;

GRANT "CONNECT" TO herasko;
GRANT CREATE ANY TABLE TO herasko;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


create table human(name VARCHAR2(30) NOT NULL);

alter table human add CONSTRAINT human_pk primary key (name);

create table sound(name VARCHAR2(30) NOT NULL);

alter table sound add CONSTRAINT sound_pk primary key (name);

alter table sound add (human_name varchar2(30) NOT NULL);

alter table sound add CONSTRAINT human_name_pk FOREIGN key (human_name) REFERENCES sound(name);



  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

grant insert any table to herasko;
grant select any table to herasko;



/*---------------------------------------------------------------------------
3.a. 
Скільки проданого найдорожчого товару?
Виконати завдання в SQL.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
FROM SUM(QUANTITY), ORDERITEMS
WHERE PROD_ID = (SELECT 
                  FROM  PROD_ID,PRODUCTS 
                  WHERE PROD_PRICE = (SELECT
                                      FROM MAX(PROD_PRICE), PRODUCTS);

SELECT
    SUM(quantity)
FROM
    orderitems
WHERE
    prod_id IN (
                SELECT
                    prod_id
                FROM
                    orderitems
                WHERE
                    item_price = (
                                    SELECT
                                        MAX(item_price)
                                    FROM
                                        orderitems
                    )
    );



/*---------------------------------------------------------------------------
3.b. 
Який PROD_ID товару, з найкоротшою назвою?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
FROM PROD_ID, PRODUCTS
WHERE LENGTH(REPLACE(PROD_NAME, ' ', '') )  = (SELECT 
                  FROM  MIN(LENGTH(REPLACE(PROD_NAME, ' ', '') )),PRODUCTS );
                                              
SELECT
    prod_id
FROM
    products
WHERE
    length(TRIM(prod_name) ) = (
        SELECT
            MIN(length(TRIM(prod_name) ) )
        FROM
            products
    );       



/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
  PROJECT (VENDORS
        WHERE VEND_ID IN (PROJECT(VENDORS){VEND_ID}) 
    ){ RENAME(UPPER(VEND_NAME), "vendor_name")}  

MINUS 
PROJECT(PRODUCTS){VEND_ID};                
                 
                 
 PROJECT (VENDORS
        WHERE VENDORS.VEND_ID NOT IN (PROJECT(PRODUCTS){ distinct PRODUCTS.VEND_ID}) 
    ){ DISTINCT RENAME(UPPER(TRIM(VENDORS.VEND_NAME)), "vendor_name")}                 


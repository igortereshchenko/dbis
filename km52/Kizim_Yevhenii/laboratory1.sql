-- LABORATORY WORK 1
-- BY Kizim_Yevhenii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER KIZIM 
    IDENTIFIED BY lab_pass
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 100M ON USERS;

GRANT "CONNECT" TO KIZIM;
GRANT DELETE ANY TABLE TO KIZIM; --???--








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Університет має факультети, що складаються з кафедр.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE Faculty (
    faculty_name CHAR(50) NOT NULL);
    
ALTER TABLE Faculty
    ADD CONSTRAINT faculty_pk PRIMARY KEY (faculty_name);

CREATE TABLE Department (
    department_name CHAR(50) NOT NULL);
    
ALTER TABLE Department
    ADD CONSTRAINT department_pk PRIMARY KEY (department_name);   
    
CREATE TABLE Faculty_Department (
    faculty_name_fk CHAR (50) NOT NULL,
    department_name_fk CHAR (50) NOT NULL,
    groups_quantity NUMBER (2)
);

ALTER TABLE Faculty_Department 
    ADD CONSTRAINT faculty_department_pk PRIMARY KEY (faculty_name_fk, department_name_fk);

ALTER TABLE Faculty_Department
    ADD CONSTRAINT constrain_faculty_name_fk FOREIGN KEY (faculty_name_fk) REFERENCES Faculty (faculty_name);

ALTER TABLE Faculty_Department
    ADD CONSTRAINT constrain_department_name_fk FOREIGN KEY (department_name_fk) REFERENCES Department (department_name);















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO KIZIM;
GRANT INSERT ANY TABLE TO KIZIM;
GRANT SELECT ANY TABLE TO KIZIM;









/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

    
--Код відповідь:

SELECT DISTINCT ORDER_NUM
FROM ORDERITEMS
WHERE ITEM_PRICE IN (
    SELECT MIN(ITEM_PRICE)
    FROM ORDERITEMS);












/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних країн зберігається в таблиці CUSTOMERS - назвавши це поле country.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT COUNT("country") AS "country"
FROM
(SELECT DISTINCT CUSTOMERS.CUST_COUNTRY AS "country"
FROM CUSTOMERS);







/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

RENAME(
    PROJECT ((((VENDORS JOIN PRODUCTS)
        ON VENDORS.VEND_ID = PRODUCTS.VEND_ID)
    JOIN ORDERITEMS)
        ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID) {LOWER(VENDORS.VEND_NAME)}
) {LOWER(VENDORS.VEND_NAME) / "vendor_name"}

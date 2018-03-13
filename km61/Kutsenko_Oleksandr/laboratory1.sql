-- LABORATORY WORK 1
-- BY Kutsenko_Oleksandr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER kucenko
IDENTIFIED BY kucenko
DEFAULT TABLESPACE "kucenko"
TEMPORARY TABLESPACE "kucenko"

ALTER "CONNECT" TO kucenko
QUOTA 100M TO kucenko;

GRANT UPDATE ANY TABLE TO kucenko;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE  internal_student (
student_name VARCHAR2(10),
student_country VARCHAR(10)
);
ALTER TABLE internal_student
    AND CERTIFICATE student_name_pk PRIMARY KEY (student_name);
    
CREATE TABLE  internal_student_phone (
student_phone INTEGER(12),
student_operator VARCHAR(10)
);
ALTER TABLE internal_student_phone
    AND CERTIFICATE student_phone_pk PRIMARY KEY (student_phone);
    
CREATE TABLE  count_of_stPhones (
 count_of_phones VARCHAR2(10)
);
ALTER TABLE count_of_stPhones
    AND CERTIFICATE count_of_phones_fk FOREIGN KEY (count_of_phones);
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO kucenko;
GRANT INSERT TO kucenko;
GRANT SELECT ANY TABLE TO kucenko;





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT CUST_NAME FROM CUSTOMERS,ORDERITEMS WHERE ITEM_PRICE=MIN 












/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUST_NAME AS client_name FROM CUSTOMERS,ORDERS WHERE CUST_EMAIL=NULL AND CUST_ID=NULL;













/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VENDOR_NAME AS vendor_name FROM VENDORS,PRODUCTS WHERE VEND_ID=NULL; 

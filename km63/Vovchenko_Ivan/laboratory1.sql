-- LABORATORY WORK 1
-- BY Vovchenko_Ivan
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлення даних у таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER vovchenko IDENTIFIED BY vovchenko
DEFAULT TABLESPACE "Users"
TEMPORARY TABLESPACE "TEMP";

ALTER USER vovchenko QUOTA 100m ON USERS;

GRANT "CONNECT" TO vovchenko;

GRANT SELECT ANY TABLE TO vovchenko;
GRANT UPDATE ANY TABLE TO vovchenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент вивчає мови програмування.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE STUDENT (
  student_name VARCHAR2(30) NOT NULL);
ALTER TABLE STUDENT
  ADD CONSTRAINT student_name_pk PRIMARY KEY (student_name);

CREATE TABLE SUBJ (
  subj_name VARCHAR2(30) NOT NULL); 
ALTER TABLE SUBJ
  ADD CONSTRAINT subj_name_pk PRIMARY KEY (subj_name);

CREATE TABLE SUBJ_PROG (
  student_name_fk VARCHAR2(30) NOT NULL,
  subj_name_fk VARCHAR2(30) NOT NULL,);
  
ALTER TABLE STUDENT_SUBJ
  ADD CONSTRAINT student_subj_pk PRIMARY KEY (student_name_fk, subj_name_fk);

ALTER TABLE STUDENT_SUBJ
  ADD CONSTRAINT student_fk FOREIGN KEY (student_name_fk) REFERENCE STUDENT(student_name_pk);
  
ALTER TABLE STUDENT_SUBJ
  ADD CONSTRAINT subj_fk FOREIGN KEY (subj_name_fk) REFERENCE STUDENT(subj_name_pk);













  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO vovchenko;
GRANT ALTER ANY TABLE TO vovchenko;





/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав  не найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що мають поштову адресу та не живуть в USA, у верхньому регістрі - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_NAME
FROM CUSTOMERS
WHERE CUST_NAME IS NOT NULL AND CUST_COUNTRY NOT LIKE = 'USA';














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар з найбільшою ціною.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VEND_NAME AS vendor_name
FROM VENDORS
WHERE PRODUCTS.PROD_PRICE = MAX(PRODUCTS.PROD_PRICE);

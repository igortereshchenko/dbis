-- LABORATORY WORK 1
-- BY Chala_Hanna
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER CHALA IDENTIFIED BY 123
DEFAULT TABLESPACE = "USERS"
TEMPORARY TABLESPACE = "TEMP"
ALTER USER CHALA QUOTA '100M' TO USER
GRANT "CONNECT" TO CHALA;
GRANT ALTER ANY TABLE TO CHALA;










/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має залікову, що містить записи про дисципліни.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE STUDENT (st_name VARCHAR(30) NOT NULL);
CREATE TABLE ZALIK(lesson VARCHAR(10) NOT NULL,
mark NUMBER(8,2) NULL);
ALTER TABLE STUDENT
ADD CONSTRAINT name_pk PRIMARY KEY (st_name);
ALTER TABLE ZALIK 
ADD CONSTRAINT lesson_pk PRIMARY KEY (lesson);
CREATE TABLE ZALIK_STUDENT
(st_name_fk VARCHAR(30) NOT NULL,
lesson_fk VARCHAR(10) NOT NULL,
mark NUMBER(8,2) NULL);
ALTER TABLE ZALIK_STUDENT
ADD CONSTRAINT st_name_pk PRIMARY KEY (st_name_fk);
ALTER TABLE ZALIK_STUDENT 
ADD CONSTRAINT z_lesson_pk PRIMARY KEY (lesson_fk);
ALTER TABLE ZALIK_STUDENT
ADD CONSTRAINT studname_fk FOREIGN KEY (st_name_fk) REFERENCE STUDENT (st_name);
ALTER TABLE ZALIK_STUDENT 
ADD CONSTRAINT zlesson_fk FOREIGN KEY (lesson_fk) REFERENCE ZALIK (lesson);
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
/*---------------------------------------------------------------------------
3.a. 
Скільки проданого найдешевшого товару?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Який PROD_ID товару, з найдовшою назвою?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:













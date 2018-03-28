/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлення даних у таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:




CREATE USER pototska
IDENTIFIED BY pototska
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER pototska QUOTA 100M ON USERS;

GRANT "CONNECT" TO pototska;

GRANT SELECT ANY TABLE TO pototska;
GRANT UPDATE ANY TABLE  TO pototska;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент вивчає мови програмування.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE STUDENT5 (student_name VARCHAR2(25) NOT NULL);
ALTER TABLE STUDENT 
ADD CONSTRAINT student5_pk PRIMARY KEY (student_name);


CREATE TABLE LANGUAGE5 (language_name VARCHAR(25) NOT NULL);
ALTER TABLE LANGUAGE 
ADD CONSTRAINT language5_pk PRIMARY KEY (language_name);

CREATE TABLE STUDENT_LANGUAGE (
student_name_fk VARCHAR(25) NOT NULL,
language_name_fk VARCHAR(25) NOT NULL,
language_author VARCHAR(25) NOT NULL);

ALTER TABLE STUDENT_LANGUAGE 
ADD CONSTRAINT student_language_pk PRIMARY KEY (student_name_fk,language_name_fk);

ALTER TABLE STUDENT_LANGUAGE 
ADD CONSTRAINT student5_fk FOREIGN KEY (student_name_fk) REFERENCES STUDENT5 (student_name);

ALTER TABLE STUDENT_LANGUAGE 
ADD CONSTRAINT language5_fk FOREIGN KEY (language_name_fk) REFERENCES LANGUAGE5 (language_name);





  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:



GRANT CREATE ANY TABLE TO pototska;
GRANT INSERT ANY TABLE TO pototska;




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















/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар з найбільшою ціною.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


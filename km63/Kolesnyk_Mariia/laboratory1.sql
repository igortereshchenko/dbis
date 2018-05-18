/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та створювати таблиці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER kolesnyk IDENTIFIED BY kolesnyk
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER kolesnyk QUOTA 100M ON USERS;

GRANT "CONNECT" TO kolesnyk;

GRANT CREATE ANY TABLE TO kolesnyk;
GRANT ALTER ANY TABLE TO kolesnyk;









/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент пише нотатки у блокноті.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE STUDENT3 (student_name VARCHAR2(30) NOT NULL);
ALTER TABLE STUDENT3
    ADD CONSTRAINT student_name_pk PRIMARY KEY (student_name);
    
CREATE TABLE NOTEBOOK (note_name VARCHAR2(30) NOT NULL);
ALTER TABLE NOTEBOOK
    ADD CONSTRAINT note_name_pk PRIMARY KEY (note_name);
    
CREATE TABLE STUDENT_NOTE (student_name_fk VARCHAR2(30) NOT NULL, 
                            note_name_fk VARCHAR2(30) NOT NULL,
                            note_subject VARCHAR2(30) NOT NULL);
                            
ALTER TABLE STUDENT_NOTE
    ADD CONSTRAINT student_note_pk PRIMARY KEY (student_name_fk, note_name_fk);

ALTER TABLE STUDENT_NOTE
    ADD CONSTRAINT student_fk FOREIGN KEY (student_name_fk) REFERENCES STUDENT3 (student_name_pk);
    
ALTER TABLE STUDENT_NOTE
    ADD CONSTRAINT note_fk FOREIGN KEY (note_name_fk) REFERENCES NOTEBOOK (note_name_pk);
                            
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO kolesnyk;
GRANT ALTER ANY TABLE TO kolesnyk;
GRANT INSERT ANY TABLE TO kolesnyk;






/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив не найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
 













/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть покупці має не найкоротшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_COUNRY 
FROM CUSTOMERS
WHERE LENGHT(CUST_COUNTRY) <> (SELECT  MIN(LENGHT(CUST_COUNTRY) FROM CUSTOMERS);










/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення у яке входить найдорожчий товар. 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


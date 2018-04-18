-- LABORATORY WORK 1
-- BY Lutsyk_Maksym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user Lutsyk identified by password;

default tablespace "users";
temporary tablespace 'temp';

alter uses quota 100m on user;

grant 'connect' to Lutsyk;
grant create any table to Lutsyk;
grant delete any table to Lutsyk;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент здає роботу викладачу.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

Create table WORK
WORK_NAME VARCHAR (20) NOT NULL;
ALTER TABLE WORK
ADD CONSTRAINT work_num PRIMARY KEY(WORK_NAME); 

Create table TEACHER
TEACHER_NAME VARCHAR (20) NOT NULL;
ALTER TABLE TEACHER
ADD CONSTRAINT teacher_num PRIMARY KEY(TEACHER_NAME); 

Create table WORKtoTEACHER
WORK_NAME VARCHAR (20) NOT NULL;
TEACHER_NAME VARCHAR (20) NOT NULL;
Worktoteach VARCHAR (20) NOT NULL;

ALTER TABLE WORKtoTEACHER
ADD CONSTRAINT WORKtoTEACHER_Pk PRIMARY KEY(work_num,teacher_num); 

Alter table WORKtoTEACHER
ADD CONSTRAINT WORKtoTEACHER_fk FOREIGN KEY(work_fk) REFERENCES (WORK_NAME);
Alter table WORKtoTEACHER
ADD CONSTRAINT WORKtoTEACHER_fk FOREIGN KEY(teacher_fk) REFERENCES (TEACHER_NAME);











  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant create any table to Lutsyk; 
grant insert any table to Lutsyk; 
grant select any table to Lutsyk; 





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:



REFERENCES (MIN_PRISE , PRODUCT (MIN(MIN_PRICE) AND NAMEOFCUST










/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:    (додано 18.04.2018)
SELECT     
	CUST_NAME as "client_name"
FROM CUSTOMERS
	WHERE CUST_ID  IN (
                        SELECT CUST_ID  
			FROM ORDERS
            		)
     		and CUST_EMAIL IS NULL;

/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:   (додано 18.04.2018)
                                 
                                 SELECT upper(CUST_NAME) as "customer_name"
FROM CUSTOMERS
WHERE CUSTOMERS.CUST_ID NOT IN (
                         SELECT CUST_ID   
                         FROM ORDERS);


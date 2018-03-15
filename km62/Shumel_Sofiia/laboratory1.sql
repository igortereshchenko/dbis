-- LABORATORY WORK 1
-- BY Shumel_Sofiia
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER STUDENT IDENTIFIED BY pass
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
QUOTA 50M FROM "USERS"

GRANT CREATE ANY TABLE FOR STUDENT_NAME
GRANT DROP FOR STUDENT_NAME









/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент здає роботу викладачу.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE student
(
  name_student char(30) NOT NULL,
  id_student char(10) NOT NULL,
  course_student char(1) IS NULL,
  id_labs char(10) NOT NULL,
  id_teacher int NOT NULL
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY (id_student);
ALTER TABLE student ADD CONSTRAINT labs_fk FOREIGN KEY id_labs(labs);
ALTER TABLE student ADD CONSTRAINT teacher_fk FOREIGN KEY id_teacher(teacher);

CREATE TABLE labs
(
  name_labs char(30) NOT NULL,
  id_student int NOT NULL,
  id_labs char(10) NOT NULL 
); 
ALTER TABLE labs ADD CONSTRAINT labs_pk PRIMARY KEY (id_labs);
 
CREATE TABLE teacher
(
  name_TEACHER char(30) NOT NULL,
  id_teacher int NOT NULL
); 
ALTER TABLE teacher ADD CONSTRAINT teacher_pk PRIMARY KEY (id_teacher);













  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT SELECT ANE TABLE TO STUDENT;







/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_NAME
FROM CUSTOMERS
WHERE 
(CUST_ADDRESS is null) AND ( orde);














/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:



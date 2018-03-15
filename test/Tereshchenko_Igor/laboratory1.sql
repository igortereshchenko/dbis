/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
модифікувати таблиці та вставляти дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Sedinin
IDENTIFIED BY Pass
USED TABLESPACE "USER"
TEMPORARY TABLESPACE "TEMP"

GRANT "CONNECTION" TO Sedinin

GRANT ALTER ALL TABLES TO Sedinin
GRANT INSERT ALL TABLES TO Sedinin;
/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент купляє квиток на потяг.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE Student (
  student_name char(30) NOT NULL )
ALTER TABLE Student 
  ADD CONSTRAINT student_name_pk PRIMARY KEY (student_name);
  
CREATE TABLE Ticket (
  ticket_id number(8) NOT NULL )
ALTER TABLE Ticket 
  ADD CONSTRAINT ticket_id_pk PRIMARY KEY (student_id);
  
CREATE TABLE Passanger ( 
  passanger_name_fk char(30) NOT NULL
  ticket_id_fk number(8) NOT NULL
  train_id number(8) NOT NULL )
  
ALTER TABLE Passanger
  ADD CONSTRAINT train_id PRIMARY KEY (train_id);
ALTER TABLE Passanger   
  ADD CONSTRAINT ticket_id FOREIGN KEY (ticket_id_fk) REFERENCES Ticket(ticket_id); 
ALTER TABLE Passanger   
  ADD CONSTRAINT passanger_name FOREIGN KEY (passanger_name_fk) REFERENCES Student(student_name);  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
ALTER USER Sedinin
  GRANT CREATE ALL TABLES TO Sedinin 
/*---------------------------------------------------------------------------
3.a. 
Якого товару найменше продано?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT PROD_ID
FROM ORDERITEMS
WHERE ( Min(QUANTITY))
/*---------------------------------------------------------------------------
3.b. 
Скільки одиниць товару продано покупцям, що живуть в Америці?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT QUANTITY 
FROM ORDERITEMS
WHERE ( CUST_COUNTRY.CUSTOMERS == "USA")
/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не продали жодного зі своїх продуктів.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


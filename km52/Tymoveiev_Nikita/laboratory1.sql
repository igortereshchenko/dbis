-- LABORATORY WORK 1
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Timofeev
IDENTIFIED BY nikita
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER Timofeev QUOTA 100M ON USERS;

GRANT "CONNECT" TO Timofeev; 

GRANT UPDATE TO Timofeev;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має власний комп’ютер та кімнату в гуртожитку
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE Comp_Student(
  st_comp char(30) not null
  st_name char(50) not null
 );

CREATE TABLE dorminatory (
  st_name char(30)
  st_room number(5) not null
 );

CREATE TABLE Student(
  st_name char(30) not null
  st_id number(10) not null
  st_room number(5)
  st_comp char(30)
  );

ALTER TABLE Student
  ADD CONSTRAINT st_id_pk PRIMARY KEY (st_id);

ALTER TABLE Comp_Student
 ADD CONSTRAINT comp_pk PRIMARY KEY (st_comp);

ALTER TABLE Comp_Student
 ADD CONSTRAINT pk_st_name PRIMARY KEY (st_name);

ALTER TABLE Student
 ADD CONSTRAINT FK_st_room FOREIGN KEY(st_room) REFERENCES dorminatory (st_room);

ALTER TABLE Student
 ADD CONSTRAINT FK_st_comp FOREIGN KEY(st_comp) REFERENCES Comp_Student (st_comp);

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE TO Timofeev;
GRANT INSERT TO Timofeev;
GRANT SELECT TO Timofeev

/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдешевшого товару?
Виконати завдання в Алгебрі Кодда. 
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
SELECT MAX(length(prod_id))
FROM Products;
















/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT (cust_name, cust_state)  as slient_name
FROM Customers
WHERE 

-- BY Tymoveiev_Nikita

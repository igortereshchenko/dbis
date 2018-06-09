-- LABORATORY WORK 1
-- BY Dreiev_Ihor
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER dreyev IDENTIFIED BY dreyevihor;

GRANT UPDATE ANY TABLE TO dreyev;






/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має власний комп’ютер та кімнату в гуртожитку
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE Student(
student_id INTEGER,
name VARCHAR2(20),
room_id_fk INTEGER
);

CREATE TABLE Computer(
mac_adr VARCHAR(20),
name_fk VARCHAR2(20)
);

CREATE TABLE Room(
room_id INTEGER,
number INTEGER,
hostel VARCHAR2(20)
);

ALTER TABLE Room
ADD CONSTRAINT room_pk PRIMARY KEY (room_id);

ALTER TABLE Computer
ADD CONSTRAINT computer_pk PRIMARY KEY (mac_adr);

ALTER TABLE Student
ADD CONSTRAINT student_pk PRIMARY KEY (student_id);

ALTER TABLE Computer
ADD CONSTRAINT student_fk
   FOREIGN KEY (student_id_fk)
   REFERENCES Student(student_id);


ALTER TABLE Student
ADD CONSTRAINT room_fk
   FOREIGN KEY (room_id_fk)
   REFERENCES Room(room_id);








  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT SELECT ANY TABLE, INSERT ANY TABLE, SELECT ANY TABLE TO dreyev;





/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдешевшого товару?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповід 


project(Products ITEM_NAME where ITEM_PRICE = project(OrderItems MIN(ITEM_PRICE))) 









/*---------------------------------------------------------------------------
3.b. 
Який PROD_ID товару, з найдовшою назвою?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

project(Products PROD_ID where LEN(ITEM_NAME) = project(Products MAX(LEN(ITEM_NAME))))













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


select (trim(CUST_NAME) || trim(CUST_COUNTRY)) client_name 
where CUST_ID in (select CUST_ID from Orders);

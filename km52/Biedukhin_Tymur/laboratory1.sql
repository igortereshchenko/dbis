-- LABORATORY WORK 1
-- BY Biedukhin_Tymur
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER bedukhin IDENTIFIED BY bedukhinpass;
GRANT UPDATE ANY TABLE TO bedukhin;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має власний комп’ютер та кімнату в гуртожитку
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE students 
(
  student_id varchar2(50) NOT NULL,
  student_name varchar2(50)
);

CREATE TABLE computers
(
  computer_serial_number varchar2(50) NOT NULL
);

CREATE TABLE rooms
(
  room_number number(3) NOT NULL,
  hostel_number NOT NULL
);

ALTER TABLE students 
  ADD CONSTRAINT students_pk PRIMARY KEY (student_id);

ALTER TABLE computers 
  ADD CONSTRAINT computers_pk PRIMARY KEY (computer_serial_number);
  
ALTER TABLE rooms 
  ADD CONSTRAINT rooms_pk PRIMARY KEY (room_number);  
 
ALTER TABLE students 
   ADD CONSTRAINT students_computer_fk FOREIGN KEY (computer_serial_number) REFERENCES computers;

ALTER TABLE students 
   ADD CONSTRAINT students_room_fk FOREIGN KEY (computer_pk) REFERENCES computers;
   
   



  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO bedukhin;
GRANT INSERT ANY TABLE TO bedukhin;
GRANT SELECT ANY TABLE TO bedukhin;



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















/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:




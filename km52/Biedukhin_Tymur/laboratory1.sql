-- LABORATORY WORK 1
-- BY Biedukhin_Tymur
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER bedukhin IDENTIFIED BY bedukhinpass
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
QUOTA 100M ON USERS;

GRANT "CONNECT" TO bedukhin;

GRANT UPDATE ANY TABLE TO bedukhin;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має власний комп’ютер та кімнату в гуртожитку
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO bedukhin;
GRANT ALTER ANY TABLE TO bedukhin;

CREATE TABLE students 
(
  student_id varchar2(50) NOT NULL,
  student_name varchar2(50),
  student_phone varchar(50),
  room_number_fk 
);

CREATE TABLE computers
(
  computer_serial_number varchar2(50) NOT NULL,
  computer_model varchar(50),
  computer_is_working bool,
  student_id_fk
);

CREATE TABLE rooms
(
  room_number number(3) NOT NULL,
  hostel_number_fk, 
  room_floor number(2),
  room_id number(1) NOT NULL
);

CREATE TABLE hostels 
{
hostel_number number(3) NOT NULL,
hostel_street varchar(50),
hostel_university_name varchar(50)
hostel_id number(10) NOT NULL
}

ALTER TABLE students 
  ADD CONSTRAINT students_pk PRIMARY KEY (student_id);

ALTER TABLE computers 
  ADD CONSTRAINT computers_pk PRIMARY KEY (computer_serial_number);
  
ALTER TABLE rooms 
  ADD CONSTRAINT rooms_pk PRIMARY KEY (room_id);  
  
ALTER TABLE hostels 
  ADD CONSTRAINT hostels_pk PRIMARY KEY (hostel_id);  
 
ALTER TABLE students 
   ADD CONSTRAINT students_rooms_fk FOREIGN KEY (room_number_fk) REFERENCES rooms(room_number);

ALTER TABLE rooms
   ADD CONSTRAINT rooms_hostels_fk FOREIGN KEY (hostel_number_fk) REFERENCES hostels(hostel_number);
   
ALTER TABLE computers
   ADD CONSTRAINT computers_students_fk FOREIGN KEY (student_id_fk) REFERENCES students(student_id);
   
   



  
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




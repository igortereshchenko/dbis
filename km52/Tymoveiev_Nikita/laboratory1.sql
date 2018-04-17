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
/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     17.04.2018 22:14:39                          */
/*==============================================================*/


alter table Computer
   drop constraint "FK_students computer";

alter table Student
   drop constraint FK_students_in_room;

alter table dorminatory_rooms
   drop constraint FK_dorminatory_has_room;

alter table dorminatory_rooms
   drop constraint FK_room_in_dorminatory;

drop index student_computer_FK;

drop table Computer cascade constraints;

drop table Dorminatory cascade constraints;

drop index students_computer_FK;

drop table Student cascade constraints;

drop index dorminatory_has_room_FK;

drop index room_in_dorminatory_FK;

drop table dorminatory_rooms cascade constraints;

drop table room cascade constraints;

/*==============================================================*/
/* Table: Computer                                              */
/*==============================================================*/
create table Computer 
(
   comp_MAC             VARCHAR2(15),
   comp_model           VARCHAR2(20),
   comp_firm            VARCHAR2(10),
   comp_code            VARCHAR2(25)         not null,
   stud_card            VARCHAR2(15),
   constraint PK_COMPUTER primary key (comp_code)
);

alter table Computer
 add constraint comp_MAC_check check(regexp_like(comp_MAC, '^(([A-Z0-9]{2}-){4}([A-Z0-9]{2})'));

alter table Computer
 add constraint comp_model_check check(regexp_like(comp_model, '^[A-Z]{2}[0-9]{4}[A-Z 0-9]{1-9}$'));

alter table Computer
 add constraint comp_firm_check check(regexp_like(comp_firm, '^[A-Z][a-z]{1,9}$'));

alter table Computer
 add constraint comp_code_check check(regexp_like(comp_code, '^[0-9]{1-9}$'));

/*==============================================================*/
/* Index: student_computer_FK                                   */
/*==============================================================*/
create index student_computer_FK on Computer (
   stud_card ASC
);

/*==============================================================*/
/* Table: Dorminatory                                           */
/*==============================================================*/
create table Dorminatory 
(
   dorm_number          NUMBER(5)            not null,
   university           VARCHAR2(50)         not null,
   constraint PK_DORMINATORY primary key (dorm_number, university)
);

alter table Dorminatory
 add constraint dorm_number_check check(regexp_like(dorm_number, '^[0-9]{2}'));

alter table Dorminatory
 add constraint university_check check(regexp_like(university, '^[A-Z]{5}'));

/*==============================================================*/
/* Table: Student                                               */
/*==============================================================*/
create table Student 
(
   stud_card            VARCHAR2(15)         not null,
   room_number          NUMBER(5),
   dorm_number          NUMBER(5),
   university           VARCHAR2(50),
   stud_name            VARCHAR2(15),
   stud_surname         VARCHAR2(15),
   stud_year_of_receipt DATE                 not null,
   stud_email           VARCHAR2(35),
   constraint PK_STUDENT primary key (stud_card)
);

alter table Student
 add constraint stud_card_check check(regexp_like(stud_card, '^[A-Z][0-9]{2,10}'));

alter table Student
 add constraint stud_name_check check(regexp_like(stud_name, '^[A-Z][a-z]{1,10}'));

alter table Student
 add constraint stud_surname_check check(regexp_like(stud_surname, '^[A-Z][a-z]{1,10}'));

alter table Student
 add constraint stud_year_of_receipt_check check(regexp_like(stud_year_of_receipt, '^(([1-2]{1}[0,9]{1}[0-1,5-9]{1}[0-9]{1})'));

/*==============================================================*/
/* Index: students_computer_FK                                  */
/*==============================================================*/
create index students_computer_FK on Student (
   room_number ASC,
   dorm_number ASC,
   university ASC
);

/*==============================================================*/
/* Table: dorminatory_rooms                                     */
/*==============================================================*/
create table dorminatory_rooms 
(
   room_number          NUMBER(5)            not null,
   dorm_number          NUMBER(5)            not null,
   university           VARCHAR2(50)         not null,
   constraint PK_DORMINATORY_ROOMS primary key (room_number, dorm_number, university)
);

alter table room
 add constraint room_number_check check(regexp_like(room_number, '^([0-9]{3}'));


/*==============================================================*/
/* Index: room_in_dorminatory_FK                                */
/*==============================================================*/
create index room_in_dorminatory_FK on dorminatory_rooms (
   dorm_number ASC,
   university ASC
);

/*==============================================================*/
/* Index: dorminatory_has_room_FK                               */
/*==============================================================*/
create index dorminatory_has_room_FK on dorminatory_rooms (
   room_number ASC
);

/*==============================================================*/
/* Table: room                                                  */
/*==============================================================*/
create table room 
(
   room_number          NUMBER(5)            not null,
   constraint PK_ROOM primary key (room_number)
);



alter table Computer
   add constraint "FK_students computer" foreign key (stud_card)
      references Student (stud_card)
      on delete cascade;

alter table Student
   add constraint FK_students_in_room foreign key (room_number, dorm_number, university)
      references dorminatory_rooms (room_number, dorm_number, university)
      on delete cascade;

alter table dorminatory_rooms
   add constraint FK_dorminatory_has_room foreign key (dorm_number, university)
      references Dorminatory (dorm_number, university)
      on delete cascade;

alter table dorminatory_rooms
   add constraint FK_room_in_dorminatory foreign key (room_number)
      references room (room_number)
      on delete cascade;


INSERT INTO Computer(comp_MAC , comp_model, comp_firm, comp_code,)
 VALUES('AA-43-15-B4-B6', 'Vivobook', 'Asus', 'AA-845643-JO4834');

INSERT INTO Computer(comp_MAC , comp_model, comp_firm, comp_code,)
 VALUES('AA-43-75-B4-00', 'Cool', 'Lenovo', '00-845B43-HK4834');

INSERT INTO Computer(comp_MAC , comp_model, comp_firm, comp_code,)
 VALUES('KE-00-CH-07-R0', 'Pro', 'Macbook', 'III-123K-OC1023');

INSERT INTO Dorminatory (dorm_number, university)
 VALUES('14', 'KPI');

INSERT INTO Dorminatory (dorm_number, university)
 VALUES('7', 'KNU');

INSERT INTO Dorminatory (dorm_number, university)
 VALUES('11', 'NAU');

INSERT INTO Student(stud_card , room_number, dorm_number, university,stud_name , stud_surname, stud_year_of_receipt, stud_email)
 VALUES('KV10742244', '511', '14', 'KPI', 'Nikita', 'Timofeev', '2015', 'hik951@gmail.com');

INSERT INTO Student(stud_card , room_number, dorm_number, university,stud_name , stud_surname, stud_year_of_receipt, stud_email)
 VALUES('KV10324244', '511', '14', 'KPI', 'Ruslan', 'Neshta', '2014', 'ruslan@gmail.com');

INSERT INTO Student(stud_card , room_number, dorm_number, university,stud_name , stud_surname, stud_year_of_receipt, stud_email)
 VALUES('KV1111111', '511', '14', 'KPI', 'Vlad', 'Shmeshta', '2015', 'dogger@gmail.com');

INSERT INTO dorminatory_rooms (room_number, dorm_number, university)
 VALUES('511', '14', 'KPI');

INSERT INTO dorminatory_rooms (room_number, dorm_number, university)
 VALUES('320', '14', 'KPI');

INSERT INTO dorminatory_rooms (room_number, dorm_number, university)
 VALUES('218', '11', 'KNU');


INSERT INTO room (room_number)
 VALUES('218');

INSERT INTO room (room_number)
 VALUES('511');

INSERT INTO room (room_number)
 VALUES('320');



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
GRANT CREATE ANY TABLE TO Timofeev;
GRANT INSERT ANY TABLE TO Timofeev;
GRANT SELECT ANY TABLE TO Timofeev;

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

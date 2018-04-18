-- LABORATORY WORK 1
-- BY Pochta_Ivan
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
модифікувати таблиці та вставляти дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER pochta IDENTIFIED BY johnp
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
Alter user pochta QUota 100M on "USERS"; --додано в якості власного code review
GRANT "CONNECT" TO pochta;
GRANT ALTER ANY TABLE TO pochta;
GRANT INSERT ANY TABLE TO pochta;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент купляє квиток на потяг.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE STUDENTS(
  student_id varchar(7) not null
);
INSERT INTO STUDENTS(STUDENT_ID) VALUES ('KM6220');
INSERT INTO STUDENTS(STUDENT_ID) VALUES ('KM6218');
INSERT INTO STUDENTS(STUDENT_ID) VALUES ('KM6219');
INSERT INTO STUDENTS(STUDENT_ID) VALUES ('KM6210');
CREATE TABLE TICKETS(
  ticket_id varchar(15) not null
);
INSERT INTO TICKETS VALUES('880055535300000');
INSERT INTO TICKETS VALUES('880055535300001');
INSERT INTO TICKETS VALUES('880055535300002');
INSERT INTO TICKETS VALUES('880055535300003');

CREATE TABLE TRAINS(
  train_id varchar(5) not null
);

INSERT INTO TRAINS VALUES('00000');
INSERT INTO TRAINS VALUES('00001');
INSERT INTO TRAINS VALUES('00002');
INSERT INTO TRAINS VALUES('00003');

CREATE TABLE STATIONS(
  station_id varchar(5) not null,
  station_name varchar(50) not null
);
INSERT INTO STATIONS(station_id, station_name) VALUES('00000', 'Ladyzhyn');
INSERT INTO STATIONS(station_id, station_name) VALUES('00001', 'Smila');
INSERT INTO STATIONS(station_id, station_name) VALUES('00002', 'Turiysk');
INSERT INTO STATIONS(station_id, station_name) VALUES('00003', 'Vinogradiv');

CREATE TABLE TRAIN_HAS_TICKET(
    ticket_fk varchar(15) not null,
    train_fk varchar(5) not null
);
INSERT INTO TRAIN_HAS_TICKET(ticket_fk, train_fk) VALUES('880055535300000', '00000');
INSERT INTO TRAIN_HAS_TICKET(ticket_fk, train_fk) VALUES('880055535300001', '00000');
INSERT INTO TRAIN_HAS_TICKET(ticket_fk, train_fk) VALUES('880055535300002', '00000');
INSERT INTO TRAIN_HAS_TICKET(ticket_fk, train_fk) VALUES('880055535300003', '00001');
CREATE TABLE TRAIN_HAS_STATION(
  train_fk varchar(5) not null,
  station_fk varchar(5) not null
);
INSERT INTO TRAIN_HAS_STATION(train_fk, station_fk) VALUES('00000', '00001');
INSERT INTO TRAIN_HAS_STATION(train_fk, station_fk) VALUES('00000', '00002');
INSERT INTO TRAIN_HAS_STATION(train_fk, station_fk) VALUES('00000', '00003');
INSERT INTO TRAIN_HAS_STATION(train_fk, station_fk) VALUES('00000', '00000');
CREATE TABLE STUDENT_BUY_TICKET(
  student_fk varchar(6) not null,
  ticket_fk varchar(15) not null 
);
INSERT INTO STUDENT_BUY_TICKET(ticket_fk, student_fk) VALUES('880055535300000', 'KM6220');
INSERT INTO STUDENT_BUY_TICKET(ticket_fk, student_fk) VALUES('880055535300001', 'KM6219');
INSERT INTO STUDENT_BUY_TICKET(ticket_fk, student_fk) VALUES('880055535300002', 'KM6218');
INSERT INTO STUDENT_BUY_TICKET(ticket_fk, student_fk) VALUES('880055535300003', 'KM6210');
ALTER TABLE STUDENTS add constraint students_pk primary key (student_id);
ALTER TABLE TICKETS add constraint tickets_pk primary key (ticket_id);
ALTER TABLE TRAINS add constraint trains_pk primary key (train_id);
ALTER TABLE STATIONS add constraint stations_pk primary key (station_id);
ALTER TABLE TRAIN_HAS_STATION add constraint train_has_station_pk primary key (train_fk, station_fk);
ALTER TABLE TRAIN_HAS_STATION add constraint train_has_station_fk_train FOREIGN KEY (train_fk) references TRAINS(train_id);
ALTER TABLE TRAIN_HAS_STATION add constraint train_has_station_fk_station FOREIGN KEY (station_fk) references STATIONS(station_id); 
ALTER TABLE STUDENT_BUY_TICKET add constraint student_buy_ticket_pk primary key ( ticket_fk );
ALTER TABLE STUDENT_BUY_TICKET add constraint student_buy_ticket_fk_student FOREIGN KEY ( student_fk ) references STUDENTS(student_id);
ALTER TABLE STUDENT_BUY_TICKET add constraint student_buy_ticket_fk_ticket FOREIGN KEY ( ticket_fk ) references TICKETS(ticket_id);
ALTER TABLE TRAIN_HAS_TICKET add constraint train_has_ticket_pk PRIMARY KEY ( ticket_fk ) ;
ALTER TABLE TRAIN_HAS_TICKET add constraint train_has_ticket_fk_train FOREIGN KEY (train_fk) references TRAINS(train_id);
ALTER TABLE TRAIN_HAS_TICKET add constraint train_has_ticket_fk_ticket FOREIGN KEY (ticket_fk) references TICKETS(ticket_id);
alter table tickets
  add constraint check_ticket_id 
  check (REGEXP_LIKE(ticket_id, '^[0-9]{15}'));

alter table trains
  add constraint check_train_id 
  check (REGEXP_LIKE(train_id, '^[0-9]{5}'));
alter table students
  add constraint check_student_id 
  check (REGEXP_LIKE(student_id, '^[A-Z]{2}[0-9]{4}'));
alter table students drop constraint check_student_id;
alter table stations
  add constraint check_station_id 
  check (REGEXP_LIKE(station_id ,'^[0-9]{5}'));
alter table stations
  add constraint check_station_name
  check (REGEXP_LIKE(station_name ,'^[A-Z][a-z]{1,49}'));
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


GRANT SELECT ANY TABLE to POCHTA;
GRANT ALTER ANY TABLE to pochta;
GRANT Create ANY TABLE to POCHTA;
GRANT INSERT ANY TABLE to pochta;









/*---------------------------------------------------------------------------
3.a. 
Якого товару найменше продано?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
--it's impossible without GROUP_BY
--It's my code for this task with group by:
SELECT prod_name 
FROM Products
where Products.prod_id in (
    SELECT prod_id 
    FROM(
        SELECT SUM(OrderItems.quantity) as quantity, Products.prod_id as prod_id
        FROM Products, Orders, OrderItems
        WHERE Products.prod_id = OrderItems.prod_id
        AND Orders.order_num = OrderItems.order_num
        GROUP BY Products.prod_id
        ORDER BY quantity
    )
    WHERE ROWNUM=1
);













/*---------------------------------------------------------------------------
3.b. 
Скільки одиниць товару продано покупцям, що живуть в Америці?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT SUM(quantity) FROM ( 
  Select OrderItems.quantity 
  FROM OrderItems, Orders, Customers 
  WHERE( OrderItems.order_num = Orders.order_num)
  AND ( Orders.cust_id = Customers.cust_id) 
  AND ( Customers.cust_country = 'USA') 
);
















/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не продали жодного зі своїх продуктів.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--SQL
SELECT vend_name 
FROM (
  SELECT vend_name, Vendors.vend_id
  FROM Vendors
  
  MINUS
  
  SELECT DISTINCT vend_name, Vendors.vend_id
  FROM Vendors, OrderItems, Orders, Products
  WHERE OrderItems.order_num = Orders.order_num
  AND OrderItems.prod_id = Products.prod_id
  AND Products.vend_id = Vendors.vend_id
);

--CODDA:
PROJECT (
  PROJECT(Vendors){vend_name, vend_id}
  MINUS 
  Project( ((Vendors TIMES OrderItems) TIMES (Orders TIMES Products)) 
  WHERE (OrderItems.order_num = Orders.order_num
  AND OrderItems.prod_id = Products.prod_id
  AND Products.vend_id = Vendors.vend_id) ){vend_name, Vendors.vend_id}
){vend_name };


-- LABORATORY WORK 1
-- BY Kulish_Oleh

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER OLEH_KULISH(
  DEFAULT TABLESPACE "USERS",
  TEMP TABLESPACE "TEMP"
); 

ALTER USER OLEH_KULISH QUONT 100M ON USERS;

GRANT "CONECT" TO OLEH_KULISH;

GRANT ALTER ANY /*Якесь слово*/ TO OLEH_KULISH;






/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Громадянин України має власне житло та автомобіль.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create table oleh.residents_Ukraine(
    resident varchar2(50));
    
alter table oleh.residents_ukraine
    add constraint resedent_pk primary key (resident);
    
insert into oleh.residents_Ukraine VALUES('Michael Joseph Jackson');
insert into oleh.residents_Ukraine VALUES('lun hoo');
insert into oleh.residents_Ukraine VALUES('Kim Gordon');

----------------------------------------------------------------------------

create table oleh.homes(
    adres varchar2(500));
    
alter table oleh.homes
    add constraint adres_pk primary key (adres);

insert into oleh.homes VALUES('Ukraine Kiev Kovalsky Prospect 6');
insert into oleh.homes VALUES('Ukraine Kiev Yangileva Prospect 23');
insert into oleh.homes VALUES('Ukraine Kiev Hrushevsky Prospect 15');
----------------------------------------------------------------------------

create table oleh.cars(
    car varchar2(50));
    
alter table oleh.cars
    add constraint car_pk primary key (car);

insert into oleh.cars VALUES('Nisan');
insert into oleh.cars VALUES('Akura');
insert into oleh.cars VALUES('Tesla');
 ---------------------------------------------------------------------------   
    
create table oleh.residents_Ukraine_your_homes(
    resident_h_fk varchar2(50),
    home_resident_fk varchar2(30)
);

alter table oleh.residents_Ukraine_your_homes
    add constraint resident1_fk FOREIGN key (resident_h_fk) references oleh.residents_ukraine(resident);
    
alter table oleh.residents_Ukraine_your_homes
    add constraint home_fk FOREIGN key (home_resident_fk) references oleh.homes(adres);
    
insert into oleh.residents_Ukraine_your_homes VALUES('Michael Joseph Jackson', 'Ukraine Kiev Yangileva Prospect 23');
insert into oleh.residents_Ukraine_your_homes VALUES('lun hoo', 'Ukraine Kiev Hrushevsky Prospect 15');
insert into oleh.residents_Ukraine_your_homes VALUES('Kim Gordon', 'Ukraine Kiev Hrushevsky Prospect 15');
----------------------------------------------------------------------------

create table oleh.residents_Ukraine_your_cars(
    resident_c_fk varchar2(50),
    car_resident_fk varchar2(500)
);

alter table oleh.residents_Ukraine_your_cars
    add constraint resident2_fk FOREIGN key (resident_c_fk) references oleh.residents_ukraine(resident);
    
alter table oleh.residents_Ukraine_your_cars
    add constraint car_fk FOREIGN key (car_resident_fk) references oleh.cars(car);

insert into oleh.residents_Ukraine_your_cars VALUES('Kim Gordon', 'Akura');
insert into oleh.residents_Ukraine_your_cars VALUES('Michael Joseph Jackson', 'Nisan');
insert into oleh.residents_Ukraine_your_cars VALUES('lun hoo', 'Tesla');

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY /*Якесь слово*/ TO OLEH_KULISH;
GRANT ADD ANY /*Якесь слово*/ TO OLEH_KULISH;
GRANT ALTER ANY /*Якесь слово*/ TO OLEH_KULISH;




/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT provider FROM providers where min(price)













/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що мають поштову адресу та живуть в USA, у верхньому регістрі - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


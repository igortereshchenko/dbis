-- LABORATORY WORK 1
-- BY Larionova_Yuliia
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user larionova identified by pass
default tablespace "USERS"
temporary tablespace "TEMP";    

ALTER USER larionova QUOTA 100M ON USERS;

GRANT "CONNECT" TO larionova ;

GRANT INSERT ANY TABLE TO larionova ;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Класна кімната має парти та стільці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table chairs(
    serial_number varchar2(40) not null,
    classroom_number numeric(10),
    building_adress varchar2(40)
);

alter table chairs
    ADD CONSTRAINT chairs_pk PRIMARY KEY (serial_number);

alter table chairs 
    ADD CONSTRAINT chairs_ba_check CHECK (REGEXP_LIKE(building_adress, '^[A-Za-z0-9`\.\-\s\,]'));
alter table chairs 
    ADD CONSTRAINT chairs_sn_check CHECK (REGEXP_LIKE(serial_number, '^[A-Za-z0-9`\.\-\s\,#]'));
alter table chairs
    ADD CONSTRAINT chairs_cn_check CHECK (0<classroom_number and classroom_number<1000);



insert into chairs(serial_number, classroom_number, building_adress) values ('#356740','15','Ave Victory, 37');
insert into chairs(serial_number, classroom_number, building_adress) values ('AN32578','362','Politekhnichna Street, 33');
insert into chairs(serial_number, classroom_number, building_adress) values ('#789327','125','Politekhnichna Street, 41');
insert into chairs(serial_number, classroom_number, building_adress) values ('PO89028','305','Politekhnichna Street, 39');
insert into chairs(serial_number, classroom_number, building_adress) values ('RM87654','1','Politekhnichna Street, 14a');

create table desks(
    serial_number varchar2(40) not null,
    classroom_number numeric(10),
    building_adress varchar2(40) 
);

alter table desks
    ADD CONSTRAINT desks_pk PRIMARY KEY (serial_number);
    
alter table desks 
    ADD CONSTRAINT desks_ba_check CHECK (REGEXP_LIKE(building_adress, '^[A-Za-z0-9`\.\-\s\,]'));
alter table desks 
    ADD CONSTRAINT desks_classroom_number_check CHECK (0<classroom_number and classroom_number<1000);
alter table desks 
    ADD CONSTRAINT desks_serial_number_check CHECK (REGEXP_LIKE(serial_number, '^[A-Za-z0-9`\.\-\s\,#]'));



insert into desks(serial_number, classroom_number, building_adress) values ('#793740','15','Ave Victory, 37');
insert into desks(serial_number, classroom_number, building_adress) values ('KL08387','362','Politekhnichna Street, 33');
insert into desks(serial_number, classroom_number, building_adress) values ('#739802','125','Politekhnichna Street, 41');
insert into desks(serial_number, classroom_number, building_adress) values ('OP02937','305','Politekhnichna Street, 39');
insert into desks(serial_number, classroom_number, building_adress) values ('AU97365','1','Politekhnichna Street, 14a');
    
create table buildings(
    building_adress varchar2(40) not null,
    number_of_floors numeric(10)
);

alter table buildings
    ADD CONSTRAINT buildings_pk PRIMARY KEY (building_adress);
    

alter table buildings ADD CONSTRAINT buildings_building_adress_check CHECK (REGEXP_LIKE(building_adress, '^[A-Za-z0-9`\.\-\s\,]'));
alter table buildings ADD CONSTRAINT number_of_floors_check CHECK (0<number_of_floors and number_of_floors<100);


insert into buildings(building_adress, number_of_floors) values ('Ave Victory, 37','2');
insert into buildings(building_adress, number_of_floors) values ('Politekhnichna Street, 33','3');
insert into buildings(building_adress, number_of_floors) values ('Politekhnichna street, 41','5');
insert into buildings(building_adress, number_of_floors) values ('Politekhnichna street, 39','5');
insert into buildings(building_adress, number_of_floors) values ('Politekhnichna street, 14a','5');

create table classrooms(
    classroom_number numeric(10) not null,
    building_adress varchar2(40) not null
);

alter table  classrooms
  ADD CONSTRAINT classrooms_pk PRIMARY KEY (classroom_number, building_adress);  
  
alter table  classrooms
  ADD CONSTRAINT chairs_fk FOREIGN KEY (chairs_fk) REFERENCES chairs (classroom_number, building_adress);
  
alter table  classrooms
  ADD CONSTRAINT deks_fk FOREIGN KEY (desks_fk) REFERENCES desks (classroom_number, building_adress);

alter table classrooms 
    ADD CONSTRAINT classrooms_building_adress_check CHECK (REGEXP_LIKE(building_adress, '^[A-Za-z0-9`\.\-\s\,]'));
alter table classrooms 
    ADD CONSTRAINT classrooms_cn_check CHECK (REGEXP_LIKE(classroom_number, '^[0-999]'));


insert into classrooms(classroom_number, building_adress) values ('15', 'Ave Victory, 37');
insert into classrooms(classroom_number, building_adress) values ('362','Politekhnichna Street, 33');
insert into classrooms(classroom_number, building_adress) values ('125','Politekhnichna Street, 41');
insert into classrooms(classroom_number, building_adress) values ('305','Politekhnichna Street, 39');
insert into classrooms(classroom_number, building_adress) values ('1','Politekhnichna Street, 14a');




/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO larionova ;
GRANT ALTER ANY TABLE TO larionova ;
GRANT SELECT ANY TABLE TO larionova ;







/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
select count(customers.cust_id) amount_cust_with_max_price
from customers, orders, orderitems 
where customers.cust_id = orders.cust_id 
and orders.order_num = orderitems.order_num
and item_price = (select max(item_price) from orderitems);













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних електронних адрес зберігається в таблиці CUSTOMERS - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
select distinct count(cust_email) count_email
from customers;








/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
Project cust_name + cust_adress
(customers times orders
where customers.cust_id <> orders.cust_id)


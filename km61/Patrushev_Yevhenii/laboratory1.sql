-- LABORATORY WORK 1
-- BY Patrushev_Yevhenii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user patrushev 
IDENTIFIED by password_1 
DEFAULT TABLESPACE "Users"
tEMPORARY TABLESPACE "Temp";  

ALTER user patrushev quota 100m ON Users;

grant "connect" TO patrushev;

grant select any table TO patrushev;



/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Громадянин України має власне житло та автомобіль.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table human (
    ident_code number(6), 
    firstname varchar2(30) not null, 
    surname varchar2(30) not null, 
    birthday date,
    mail varchar2(50)
);

-- house_id искусственный ключ
create table house (
    house_id number(20),
    country varchar2(30) not null, 
    city varchar2(30) not null, 
    street varchar2(30) not null, 
    house_number number(3) not null,
    number_of_floors number(3)
);

-- table "прописка человека"
create table registration_address (
    house_id_fk number(20),
    apartment_number number(3),
    ident_code_fk number(6),
    floor_number number(3),
    registration_start_date date not null,
    registration_end_date date
);

create table personal_auto(
    auto_number number(3), 
    model varchar2(15) not null,
    mark varchar2(10) not null, 
    ident_code_fk number(6),
    registration_start_date date not null,
    registration_end_date date
);

alter table human
add constraint human_key primary key (ident_code);
alter table house
add constraint house_key primary key (house_id);
alter table registration_address
add constraint reg_address_key primary key (house_id_fk, apartment_number, registration_start_date);
alter table personal_auto
add constraint pers_auto_key primary key (auto_number,registration_start_date);

alter table registration_address
add constraint reg_address_human_fk FOREIGN KEY (ident_code_fk) REFERENCES human (ident_code);
alter table registration_address
add constraint reg_address_house_fk FOREIGN KEY (house_id_fk) REFERENCES house (house_id);
alter table personal_auto
add constraint pers_auto_fk FOREIGN KEY (ident_code_fk) REFERENCES human (ident_code);


alter table house
add constraint unique_house unique (country,city,street,house_number);
alter table human
add constraint check_human CHECK (REGEXP_LIKE(mail, '^\w+@\w+\.[a-z]{2,4}$') and REGEXP_LIKE(firstname, '^\w+$') and REGEXP_LIKE(surname, '^\w+$'));
alter table registration_address
add constraint check_registration_address check(registration_start_date < registration_end_date);
alter table personal_auto
add constraint check_personal_auto check(registration_start_date < registration_end_date);

insert all
    into human values (1,'Peter','Vradiy', null,'pet@gmail.com')
    into human values (2,'Den','Semenov', date '1979-01-20', 'vald@gmail.com')
    into human values (3,'Vlad','Kopich', null, 'sam@mail.com')
    into house values (1,'Ukr','Kiev','Obolon',1,25)
    into house values (2,'Ukr','Kiev','Obolon',25,null)
    into house values (3,'USA','New-York','Kolon',3,4)
    into registration_address values (2,37,2,null,date '1999-01-20',null)
    into registration_address values (1,5,1,null,date '2002-01-20',null)
    into registration_address values (1,60,2,20,date '2001-03-01',null)
    into registration_address values (3,55,2,3,date '2000-04-12',date '2001-06-03')
    into registration_address values (2,20,2,10,date '2002-05-12',null)
    into personal_auto values (4562,'ep54','BMW',2,date '1999-01-09',null)
    into personal_auto values (1732,'fs23','acura',1,date '1996-03-16',null)
    into personal_auto values (2415,'fs52','acura',1,date '2005-06-03',null)
    into personal_auto values (5462,'kw83','audi',1,date '2003-02-19',null)
    into personal_auto values (4455,'fs52','acura',3,date '2005-06-03',date '2006-07-01')
SELECT * FROM dual;




/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

grant create any table to patrushev;
grant insert any table to patrushev;
grant alter any table to patrushev;

/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

Project (vendors) {vend_name}
where (vend_id in (
    project(orderitems TIMES products){vend_id}
    where(
        orderitems.prod_id = products.prod_id and
        orderitems.item_price in (
            project(orderitems){min(item_price)}
        )
    )
))


/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що мають поштову адресу та живуть в USA, у верхньому регістрі - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:



select upper(cust_name) as client_name
from CUSTOMERS
where 
CUST_EMAIL is not null
and 
cust_country = 'USA';




/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


select lower(vend_name) as vendor_name
from vendors
where vend_id in (
    select 
    vend_id
    from products
    minus 
    select
    vend_id
    from orderitems, products
    where orderitems.prod_id = products.prod_id
);

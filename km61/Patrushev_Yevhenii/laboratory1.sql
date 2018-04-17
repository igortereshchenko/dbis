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
    name varchar2(30) not null, 
    surname varchar2(30) not null, 
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
    floor_number number(3)
);

create table personal_auto(
    auto_number varchar(10), 
    mark varchar2(10) not null, 
    model varchar2(15) not null, 
    ident_code_fk number(6)
);

alter table human
add constraint human_key primary key (ident_code);
alter table house
add constraint house_key primary key (house_id);
alter table registration_address
add constraint reg_address_key primary key (house_id_fk, apartment_number);
alter table personal_auto
add constraint pers_auto_key primary key (auto_number);

alter table registration_address
add constraint reg_address_human_fk FOREIGN KEY (ident_code_fk) REFERENCES human (ident_code);
alter table registration_address
add constraint reg_address_house_fk FOREIGN KEY (house_id_fk) REFERENCES house (house_id);
alter table personal_auto
add constraint pers_auto_fk FOREIGN KEY (ident_code_fk) REFERENCES human (ident_code);


alter table house
add constraint unique_house unique (country,city,street,house_number);
alter table human
add constraint check_human CHECK (REGEXP_LIKE(mail, '^\w+@\w+\.[a-z]{2,4}$') and REGEXP_LIKE(name, '^\w+$') and REGEXP_LIKE(surname, '^\w+$'));

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

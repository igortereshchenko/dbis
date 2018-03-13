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


CREATE table person (
    name_person char(10)
);

CREATE table house (
    adress char(10)
);

CREATE table person_auto (
    number_auto char(10)
);


create table person_house_auto(
    name_person_fk char(10),
    adress_fk char(10),
    number_auto_fk char(10)
);

ALTER TABLE person
    add CONSTRAINT person_pk primary key (name_person);
ALTER TABLE house
    add CONSTRAINT adress_pk primary key (adress);
ALTER TABLE person_auto
    add CONSTRAINT number_pk primary key (number_auto);
ALTER TABLE person_house_auto
    add CONSTRAINT person_house_auto_pk primary key (adress_fk, number_auto_fk);

ALTER TABLE person_house_auto
    add CONSTRAINT person_fk FOREIGN KEY (name_person_fk) REFERENCES person (name_person);
ALTER TABLE person_house_auto
    add CONSTRAINT adress_fk FOREIGN KEY (adress_fk) REFERENCES house (adress);
ALTER TABLE person_house_auto
    add CONSTRAINT auto_fk FOREIGN KEY (number_auto_fk) REFERENCES person_auto (number_auto);
    
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
CUST_EMAIL != null
and 
cust_country = "USA";




/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


select lower(vend_name) as vendor_name
from (
    select 
    vend_name,
    vend_id
    from vendors
    minus 
    select
    vend_id
    from ordersitems, product
    where orderitems.prod_id = product.prod_id
);

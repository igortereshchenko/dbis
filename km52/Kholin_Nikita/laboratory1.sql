-- LABORATORY WORK 1
-- BY Kholin_Nikita
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create user kholin identified by kholin_password
default tablespace "users"
temporary tablespace "temp";
alter user kholin quota 100M on users;
grant "connect" to kholin;
grant drop any table to kholin;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина має лікарняну картку, що містить записи про історію хвороби.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table people
(
  person_id varchar2(10) not null,
  name varchar2(30) not null,
  birthdate varchar(10) not null,
  phone_number number(10) not null
);

create table cards
(
  card_id varchar2(10) not null,
  person_id varchar2(10) not null,
  person_name varchar2(15) not null,
  adress varchar2(30) not null
);

create table card_records
(
  card_record_id varchar2(10) not null,
  card_id varchar2(10) not null,
  person_id varchar2(10) not null,
  adress varchar2(30) not null
);

ALTER TABLE people ADD CONSTRAINT PK_People PRIMARY KEY (person_id);
ALTER TABLE cards ADD CONSTRAINT PK_Cards PRIMARY KEY (card_id);
ALTER TABLE card_records ADD CONSTRAINT PK_Card_Records PRIMARY KEY (card_record_id);

ALTER TABLE cards
ADD CONSTRAINT FK_Cards_People FOREIGN KEY (person_id) REFERENCES people (person_id);
ALTER TABLE people
ADD CONSTRAINT FK_Card_Records_Cards FOREIGN KEY (card_id) REFERENCES cards(card_id);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

grant select any table to kholin;
grant create any table to kholin;
grant insert any table to kholin;

/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

select vend_name from vendors
where (
  select count(*) from products
  where products.vend_id = vendors.vend_id 
  and prod_price = (select max(prod_price) from products)
  and (
    select count(*) from orderitems
    where orderitems.prod_id = products.prod_id
  ) > 0
) > 0;

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найдовшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select trim(cust_name) as long_name
from customers
where length(trim(cust_name)) = (
  select max(length(trim(cust_name))) from customers
);

/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

select lower(vend_name) from vendors
where (
  select count(*) from products
  where products.vend_id = vendors.vend_id
  and (
    select count(*) from orderitems
    where orderitems.prod_id = products.prod_id
  ) > 0
) > 0;

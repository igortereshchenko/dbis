-- LABORATORY WORK 1
-- BY Bilenko_Vladyslav
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER bilenko IDENTIFIED BY bilenko;
DEFAULT TABLESPACE "user";
TEMPORARY TABLESPACE "temp";

ALTER "CONNECT" TO bilenko;
GRANT UPDATE ANY TABLE TO bilenko;







/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create table film(
name_film VARCHAR2(30) NOT NULL,
time_film NUMBER(3),
release_year NUMBER(4) NOT NULL,
PRIMARY KEY (name_film, release_year)
);

INSERT INTO film (name_film, time_film, release_year)
VALUES ('Harry Potter', 120, 2014);
INSERT INTO film (name_film, time_film, release_year)
VALUES ('X-Men', 135, 2011);
INSERT INTO film (name_film, time_film, release_year)
VALUES ('Robocop', 86, 2001);

create table people(
name_person VARCHAR2(30) NOT NULL,
surname_person VARCHAR2(50) NOT NULL,
sex_person VARCHAR2(5) NOT NULL,
PRIMARY KEY (name_person, surname_person)
);

INSERT INTO people (name_person, surname_person, sex_person)
VALUES ('Oleg', 'Patov', 'man');
INSERT INTO people (name_person, surname_person, sex_person)
VALUES ('Natalie', 'Shatova', 'woman');
INSERT INTO people (name_person, surname_person, sex_person)
VALUES ('Dima', 'Svest', 'man');

create table people_watch_film(
hole_color VARCHAR(10) NOT NULL,
name_person VARCHAR2(30) NOT NULL,
surname_person VARCHAR2(50) NOT NULL,
name_film VARCHAR2(30) NOT NULL,
release_year NUMBER(4) NOT NULL,
PRIMARY KEY (hole_color, name_person, surname_person, name_film, release_year),
FOREIGN KEY (name_person, surname_person) REFERENCES people(name_person, surname_person),
FOREIGN KEY (name_film, release_year) REFERENCES film(name_film, release_year)
);

INSERT INTO people_watch_film (hole_color, name_person, surname_person, name_film, release_year)
VALUES ('Red', 'Oleg', 'Patov', 'X-Men', 2011);
INSERT INTO people_watch_film (hole_color, name_person, surname_person, name_film, release_year)
VALUES ('Green', 'Natalie', 'Shatova', 'Harry Potter', 2014);
INSERT INTO people_watch_film (hole_color, name_person, surname_person, name_film, release_year)
VALUES ('Green', 'Dima', 'Svest', 'Harry Potter', 2014);

create table book(
name_book VARCHAR(30) NOT NULL,
author_name VARCHAR(30) NOT NULL,
year_write NUMBER(4),
PRIMARY KEY (name_book, author_name)
);

INSERT INTO book (name_book, author_name, year_write)
VALUES ('Harry Potter', 'Rolling', 2007);
INSERT INTO book (name_book, author_name, year_write)
VALUES ('Universe', 'Hocking', 1989);
INSERT INTO book (name_book, author_name, year_write)
VALUES ('SQL', 'Fort', 2006);

create table film_by_book(
rating_film NUMBER(2) NOT NULL,
name_film VARCHAR2(30) NOT NULL,
release_year NUMBER(4) NOT NULL,
name_book VARCHAR(30) NOT NULL,
author_name VARCHAR(30) NOT NULL,
PRIMARY KEY (rating_film, name_film, release_year),
FOREIGN KEY (name_film, release_year) REFERENCES film (name_film, release_year),
FOREIGN KEY (name_book, author_name) REFERENCES book (name_book, author_name)
);

INSERT INTO film_by_book (rating_film, name_film, release_year, name_book, author_name)
VALUES (8, 'Harry Potter', 2014, 'Harry Potter', 'Rolling');







  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO bilenko;
GRANT INSERT TO bilenko;
GRANT SELECT ANY TABLE TO bilenko;





/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
Select count(cust_id)
from orders
where order_num in (
select order_num
from orderitems
where item_price in(
select min(item_price)
from orderitems));














/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select vend_country
from vendors
where length(trim(vend_country)) in (
select max(length(trim(vend_country)))
from vendors);








/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT CUSTOMERS, ORDERITEMS, ORDERS
WHERE (ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM and CUSTOMERS.CUST_ID = ORDERS.CUST_ID)
{DISTINCT RENAME trim(CUST_NAME)||' '||trim(CUST_COUNTRY) as "client_name"};

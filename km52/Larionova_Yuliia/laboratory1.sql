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
    chair_name varchar2(40) not null
);

alter table chairs
    ADD CONSTRAINT chairs_pk PRIMARY KEY (chair_name);


create table desks(
    desk_name varchar2(40) not null
);

alter table desks
    ADD CONSTRAINT desks_pk PRIMARY KEY (desk_name);

create table classroom(
    chairs_fk varchar2(40),
    desks_fk varchar2(40),
    desks_amount number(3),
    chairs_amount number(3)
);

ALTER TABLE  classroom
  ADD CONSTRAINT classroom_pk PRIMARY KEY (chairs_fk,desks_fk);  
  
ALTER TABLE  classroom
  ADD CONSTRAINT chairs_fk FOREIGN KEY (chairs_fk) REFERENCES chairs (chair_name);
  
ALTER TABLE  classroom
  ADD CONSTRAINT deks_fk FOREIGN KEY (desks_fk) REFERENCES desks (desk_name);


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO larionova ;
GRANT ALTER ANY TABLE TO larionova ;
GRANT SELECT ANY TABLE TO larionova ;
GRANT UPDATE ANY TABLE TO larionova;






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


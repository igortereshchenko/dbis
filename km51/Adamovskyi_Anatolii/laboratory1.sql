-- LABORATORY WORK 1
-- BY Adamovskyi_Anatolii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user adamovskiy identified by password;
grant select any table to adamovskiy;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table computer(
    comp_name varchar2(30),
);
alter table computer
  add constraint comp_pk primary key (comp_name);

drop table computer;

create table aparat(
  prosesor varchar2(30),
  block_power varchar2(30)
);
alter table aparat
  add constraint apar_pk primary key (block_power);

create table prog(
  prog_name varchar2(30)
);
alter table prog
  add constraint prog_id primary key (prog_name);

alter table computer
  add constraint comp_apparat_fk foreign key (apar_pk) references aparat;
alter table prog
  add constraint comp_prog_fk foreign key (prog_pk) references prog;


  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
grant select any table to adamovskiy;
grant insert any table to adamovskiy;






/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

select
  order_num 
from 
  orderitems,products
where
  orderitems.prod_id = products.prod_id and
  products.prod_price in (select max(prod_price) from products);



/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

select 
  unique cust_name as "count_name" 
from customers;














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


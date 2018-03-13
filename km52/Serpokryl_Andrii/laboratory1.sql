-- LABORATORY WORK 1
-- BY Serpokryl_Andrii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create user Serpokryl identified by serpokryl;
grant DELETE   to Serpokryl;




/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Університет має факультети, що складаються з кафедр.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table university(
  name varchar2(30),
  id varchar2(30)
);
 alter table university 
  add constraint university_pk primary key (name, id);
  
create table faculty(
  name varchar2(30)
);

alter table faculty
  add constraint  faculty_pk primary key (name);

create table cafedra(
  cafedra_name varchar(30),
  cafedra_number varchar2(30)
);

alter table cafedra
  add constraint cafedra_pk primary key (cafedra_name,cafedra_number);


alter table faculty 
  add constraint fk_faculty foreign key (name) references university (name);






  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


grant create any table to Serpokryl;
grant select any table to Serpokryl;




/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


select order_num 
from  Orders, ORDERITEMS
where prod_price in ( select min(prod_pice)
                        from Products
) and orderitems.order_num = orders.order_num;











/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних країн зберігається в таблиці CUSTOMERS - назвавши це поле country.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


select count(Distinct cust_country) as "country"
from Customers;












/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

project (Vendors times ORDERS)
rename(vend_name "vendor_name")
where vendors.vend_id = products.vend_id and



-- LABORATORY WORK 1
-- BY Miliev_Maksym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user milev
IDENTIFIED 123,
default tablespase "users",
temporary tablespace "temp",
qouta 100mb on "temp",
grant connect,
grant alter any table,
grant delete any table;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Користувач Facebook читає новини.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table fb_users
    (
        user_id number(6) not null,
        user_name varchar2(20)
        );

create table fb_news
    (
            new_id number(6) not null,
            new_topic varchar2(30)
        );
        
    alter table fb_users
        add constraint user_pk primary key (user_id);
        
    alter table fb_news
        add constraint news_pk primary key (new_id);
        
CREATE TABLE fb_news_users
    (
        new_id number(6) not null,
        user_id number(6) not null,
        
    );
    alter table fb_news_users
        add constraint fb_n_u_pk primary key (new_id, user_id),
        add constraint new_id_fk foreign key (new_id) referens fb_news,
        add constraint user_id_fk foreign key (user_id) referens fb_users;
        













  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
alter user milev
    grant create any table,
    grant insert any table,
    grant select any table;







/*---------------------------------------------------------------------------
3.a. 
Які назви товарів, що не продавались покупцям?
Виконати завдання в алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


select prod_name
from products
where 











/*---------------------------------------------------------------------------
3.b. 
Яка найдовша назва купленого товару?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести ім'я та пошту покупця, як єдине поле client_name, для тих покупців, що мають не порожні замовлення.
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

select cust_name, cust_email as "client_name"
from customers, orders
where ( select 




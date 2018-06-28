-- LABORATORY WORK 1
-- BY Miliev_Maksym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user milev
IDENTIFIED BY 123
default tablespase "users"
temporary tablespace "temp"
qouta 100mb on "temp";

Grant Connect TO milev;
grant alter any table to milev;
grant delete any table to milev;








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
            new_topic varchar2(30) not null,
            fact_name_fk varchar2(50) not null
        );
        
    alter table fb_users
        add constraint user_pk primary key (user_id);
        
    alter table fb_news
        add constraint news_pk primary key (new_id);
        
CREATE TABLE fb_news_users
    (
        new_id_fk number(6) not null,
        user_id_fk number(6) not null,
        
    );
    
    alter table fb_news_users
  add constraint fb_n_u_pk primary key (new_id_fk, user_id_fk);
alter table fb_news_users
  add constraint new_id_fk foreign key (new_id_fk) references  fb_news (new_id);
alter table fb_news_users
  add constraint user_id_fk foreign key (user_id_fk) references  fb_users (user_id);
        
        
        create table facts
            (
                fact_name varchar2(50),
                fact_date date
            )
        
        alter table facts
        add constraint fn_pk primary key (fact_name);
        
        alter table fb_news
        add CONSTRAINT fn_fk foreign key (fact_name_fk) references facts (fact_name);
        
        
        
        insert into fb_users (user_id, user_name)
        values ('000001','petya');
        insert into fb_users (user_id, user_name)
        values ('000002','sasha');
        insert into fb_users (user_id, user_name)
        values ('000003','anton');
        
        insert into fb_news (new_id, new_topic, fact_name_fk)
        values ('000001','viboru', 'vibory prezidenta ukrainu');
        insert into fb_news (new_id, new_topic, fact_name_fk)
        values ('000002','katastrofa', 'vzriv likerovodochnogo zavoda');
        insert into fb_news (new_id, new_topic, fact_name_fk)
        values ('000003','kosmos', 'polet mejgalakticheskou rakety');
        
        
        insert into fb_news_users (new_id_fk, user_id_fk)
        values ('000001','000001');
        insert into fb_news_users (new_id_fk, user_id_fk)
        values ('000002','000002');
        insert into fb_news_users (new_id_fk, user_id_fk)
        values ('000003','000003');
        
        insert into facts (fact_name, fact_date)
        values ('vibory prezidenta ukrainu','2018-03-01');
       insert into facts (fact_name, fact_date)
       values ('vzriv likerovodochnogo zavoda','1961-04-12');
       insert into facts (fact_name, fact_date)
       values ('polet mejgalakticheskou rakety','2017-01-15');













  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant create any table to milev;
grant insert any table to milev;
grant select any table to milev;






/*---------------------------------------------------------------------------
3.a. 
Які назви товарів, що не продавались покупцям?
Виконати завдання в алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


(PROJECT (PRODUCTS TIMES ORDERITEMS) {prod_name}) WHERE PRODUCTS.prod_id != ORDERITEMS.prod_id











/*---------------------------------------------------------------------------
3.b. 
Яка найдовша назва купленого товару?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select prod_name
  FROM PRODUCTS, ORDERITEMS
  WHERE PRODUCTS.prod_id = ORDERITEMS.prod_id and
 (SELECT length(TRIM(prod_name)) FROM PRODUCTS) = (SELECT max(length(TRIM(prod_name))) FROM PRODUCTS);














/*---------------------------------------------------------------------------
c. 
Вивести ім'я та пошту покупця, як єдине поле client_name, для тих покупців, що мають не порожні замовлення.
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT 
cust_name || ' ' ||cust_email as client_name
FROM CUSTOMERS, ORDERS
WHERE CUSTOMERS.cust_id=ORDERS.cust_id;




-- LABORATORY WORK 1
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--create user Samovilov identified by 12345
--default tablespace "users"
--temporary tablespace "temp";
--alter user Samovilov quota 100mb on "users" 
--grant create any table to Samovilov
--grant alter any table to Samovilov ;
--grant delete any table to Samovilov ;

alter user "Samovilov" quota 100mb on users ;
--alter user "Samovilov" default role "connect" ;
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
        user_name varchar2(20) not null
        );

CREATE TABLE facts
    (
        fact_name varchar2(20) not null,
        fact_date date not null,     
    );

alter table facts
add constraint fn_pk primary key (fact_name);


create table fb_news
    (
            fact_name_fk varchar2(20) not null 
            news_id number(6) not null,
            news_topic varchar2(30) not null
        );
        
    alter table fb_users
        add constraint user_pk primary key (user_id) ;
        
    alter table fb_news
        add constraint news_pk primary key (new_id);
        
    alter table fb_news
        add constraint fn_fk foreign key ( fact_name_fk) references  facts (fact_name);   
        
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



insert into fb_users (user_id, user_name) values ('356740','Va$Y@');
insert into fb_users (user_id, user_name) values ('356921','Petr');
insert into fb_users (user_id, user_name) values ('576040',' )i( O R A ');
insert into facts (fact_name, fact_date) values ('Vibori2018','2018-03-01');
insert into facts (fact_name, fact_date) values ('Polet_v_kosmos','1961-04-12');
insert into facts (fact_name, fact_date) values ('Otchislenie','2017-01-15');
insert into fb_news ( fact_name_fk, news_id, news_topic) values ('Vibori2018','000001', 'topic1');
insert into fb_news ( fact_name_fk, news_id, news_topic) values ('Otchislenie','000002','topic2' );
insert into fb_news ( fact_name_fk, news_id, news_topic) values ('Polet_v_kosmos','000003','topic3' );




  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant create any table to Samovilov;
grant insert any table to Samovilov;
grant select any table to Samovilov






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















/*---------------------------------------------------------------------------
c. 
Вивести ім'я та пошту покупця, як єдине поле client_name, для тих покупців, що мають не порожні замовлення.
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
-- BY Samovilov_Serhii

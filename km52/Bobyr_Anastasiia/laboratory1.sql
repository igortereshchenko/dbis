-- LABORATORY WORK 1
-- BY Bobyr_Anastasiia

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

Create user Bobyr IDENTIFIED by Bobyr
Default tablespace "USERS"
TEMPORARY tablespace "TEMP"
Quota unlimited on Users;

grant CONNECT to Bobyr;

grant drop any table to Bobyr;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина має лікарняну картку, що містить записи про історію хвороби.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:



grant create any table to Bobyr;
grant alter any table to Bobyr;


create table human (
human_name varchar2(30) not null,
human_id number(8) not null
);

alter table human add constraint human_id_pk primary key (human_id);

create table card (
card_id number(8) not null
);

alter table card add constraint card_id_pk primary key (card_id);

create table human_card (
card_id_fk number(8) not null,
human_id_fk number(8) not null,
card_comment varchar2(30)
);

alter table human_card add constraint human_card_pk primary key (card_id_fk, human_id_fk);


create table records (
record_id number(8) not null,
disease_name varchar2(20) not null,
rec_card_id_fk number(8) not null,
comment_disease varchar2(20)
);

alter table records add constraint records_id_pk primary key (record_id);

alter table records add constraint rec_card_fk foreign key (rec_card_id_fk) references card (card_id);
alter table human_card add constraint human_fk foreign key (human_id_fk) references human (human_id);
alter table human_card add constraint card_fk foreign key (card_id_fk) references card (card_id);








  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


grant create any table to Bobyr;
grant alter any table to Bobyr;
grant select any table to Bobyr;




/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:



project
(project

(vendors times products orderitems 
where vendors.VEND_ID = products.VEND_ID and PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID)
 
vend_name, max(ITEM_PRICE) 
)
vend_name








/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найдовшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
select lower(vend_name) as "vendor_name"
    from VENDORS, PRODUCTS, ORDERITEMS
    where vendors.VEND_ID = products.VEND_ID and PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID ;
    
   

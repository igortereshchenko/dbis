-- LABORATORY WORK 1
-- BY Buts_Oleksandr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлювати дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user butts IDENTIFIED by 1235
    default tablespace users
    temporary tablespace temp;
grant create session to butts;
grant create any table to butts;
grant select any table to butts;
grant update any table to butts;









/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На вулиці стоїть будинок, що має 10 квартир.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create table house(idh number(2),SQ_house varchar(50),count_of_floor number(3),
count_of_flats number(3));
alter table house
    add constraint idh_k primary key(idh);
alter table house
    add constraint idh_fk foreign key(SQ_house) references square(SQname);  
insert into house values(1,Mancheten);
insert into house values(2,Mancheten);
insert into house values(3,Brooklyn);    
create table flat(idf number(2),idhh number(2),count_of_rooms number(2),count_of_flats number(3));
alter table flat
    add constraint idf_k primary key(idf);
alter table flat
    add constraint idf_fk foreign key(idhh) references house(idh);
insert into flat values(1,3);
insert into flat values(2,2);
insert into flat values(3,1);
create table humans(name varchar(30),age number(4),humanhouse number(2));
alter table humans
add constraint hpk primary key(name);
alter table humans
add constraint nfilter check(name like "^[A-Z][a-z]{0,}$");
alter table humans
add constraint afilter check(age like "^[1,2][0-9]{3}$");
alter table humans
add constraint h_fk foreign key(humanhouse) references house(idh);
insert into humans values(NICK,1990,2);
insert into humans values(RAY,1986,1);
insert into humans values(John,1990,1);
create table square(SQname varchar(50));
alter table square
add constraint sq_pk primary key(SQname);
alter table square
add constraint SQfilter check(SQname like "^[A-Z][a-z]{0,}$");
insert into square values(Mancheten);
insert into square values(Scotyard);
insert into square values(Brooklyn);















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant insert any table to butts;
grant select any table to butts;






/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар та яке ім'я покупця цього замовлення?
Виконати завдання в алгебрі Кодда.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROGECT (CUSTOMERS C, ORDERS O, ORDERITEMS OI)
WHERE
OI.ORDER_NUM = O.ORDER_NUM
and
O.CUST_ID = C.CUST_ID
and
ITEM_PRICE in (
PROGECT ORDERITEMS
{MAX(ITEM_PRICE)}
)
{O.ORDER_NUM, CUST_NAME}

SELECT O.ORDER_NUM, CUST_NAME
FROM CUSTOMERS C, ORDERS O, ORDERITEMS OI
WHERE
    OI.ORDER_NUM = O.ORDER_NUM
    and
    O.CUST_ID = C.CUST_ID
    and
    ITEM_PRICE in (
                    SELECT MAX(ITEM_PRICE)
                    FROM ORDERITEMS
    );











/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних електронних адрес покупців - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
select count(distinct CUST_EMAIL) as "count_email"
    from CUSTOMERS;
    
 PROGECT  DISTINCT (CUSTOMERS)
{RENAME CUST_EMAIL AS "count_email"}














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT DISTINCT
    lower(VEND_NAME) as "vendor_name"
FROM PRODUCTS P, VENDORS V
WHERE 
    V.VEND_ID = P.VEND_ID
    and 
    P.PROD_ID NOT IN (
                        SELECT  PROD_ID
                        FROM ORDERITEMS
                         )
   ;

a=(PRODUCTS P times VENDORS V) where c
c=V.VEND_ID = P.VEND_ID and P.PROD_ID NOT IN (PROGECT (ORDERITEMS){PROD_ID})
PROGECT (PRODUCTS P times VENDORS V)
b=(a project lower(vend_NAME)) rename as "vendor_name"

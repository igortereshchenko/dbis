/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER student
IDENTIFIED by Artem
Default Tablespace "Users"
Temporary Tablespace "TEMP";
Alter User student QUOTA 100M on Users;
/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE Table student (
    student_id integer not null,
    student_name varchar( 20 ) not null,
    student_surname varchar (20) not null
);

alter table student
add CONSTRAINT student_id primary key ( student_id )
;

CREATE TABLE telephon_number(
 telephon_number number(20,0)
);


alter table telephon_number
add CONSTRAINT number_id primary key (telephon_number)
;

/*alter table telephon_number
modify telephon_number number (20,0);*/


create table inter_operator (
operator_name varchar(30),
/*country varchar(30)*/
);

/*alter table inter_operator drop column operator_name;*/

alter table inter_operator
add CONSTRAINT operator_id PRIMARY key (country);


CREATE TABLE direct (
student_fk integer,
number_fk number(20,0),
operator_fk varchar(30)
);

/*alter table direct
modify number_fk number( 20, 0);*/

alter table direct
add CONSTRAINT direct_id1 PRIMARY key ( number_fk, student_fk ,operator_fk);

alter table direct
add CONSTRAINT number_fk1 FOREIGN key (number_fk)references telephon_number (telephon_number);

alter table direct
add CONSTRAINT student_fk1 FOREIGN key  (student_fk) REFERENCES student (student_id);

alter table direct
add CONSTRAINT operator_fk1 FOREIGN key ( operator_fk ) references inter_operator ( country );

insert into student values ( 1, 'Artem' , 'Morozov' );
insert into student values ( 2, 'Yuhnya' , 'Raevskiy' );
insert into student values ( 3, 'Sasha' , 'Marchenko' );
insert into student values ( 4, 'Artem' , 'Nemorozov' );

insert into TELEPHON_NUMBER values ( 0932678722 );
insert into TELEPHON_NUMBER values ( 0504190523 );
insert into TELEPHON_NUMBER values ( 0453265661 );
insert into TELEPHON_NUMBER values ( 0932418722 );


insert into inter_operator values ( 'ukraine');
insert into inter_operator values (  'usa');
insert into inter_operator values (  'israel');
insert into inter_operator values (  'korea');




insert into direct values ( 1, 0932678722, 'ukraine' );
insert into direct values ( 2, 0504190523, 'usa' );
insert into direct values ( 3, 0453265661, 'korea' );
insert into direct values ( 4, 0932418722, 'israel' );
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant create any table to student;
grant insert any table to student;
grant select any table to student;
/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT CUSTOMERS TIMES ORDERS TIMES ORDERITEMS {CUSTOMERS.CUST_NAME} 
    WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID AND 
                    ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM AND
                        ORDERITEMS.ITEM_PRICE IN (PROJECT ORDERITEMS {MIN(ITEM_PRICE)});

/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
SELECT '('||TRIM(CUST_NAME)||')' AS "client_name"
FROM (
    SELECT CUST_NAME, CUST_ADDRESS
    FROM CUSTOMERS
    WHERE CUST_ID NOT IN (
        SELECT CUST_ID
        FROM ORDERS
    )
)
WHERE CUST_ADDRESS IS NULL;
/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
SELECT UPPER(VEND_NAME) AS "vendor_name"
FROM VENDORS
WHERE VEND_ID NOT IN(
    SELECT VEND_ID
    FROM PRODUCTS
);

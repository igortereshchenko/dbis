-- LABORATORY WORK 1
-- BY Khodakivskyi_Vadym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Khodakivskyy IDENTIFIED BY vadim
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER khodakivskyy QUOTA unlimited ON USERS;
GRANT "CONNECT" TO Khodakivskyy;
GRANT INSERT ANY TABLE TO Khodakivskyy;










/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Класна кімната має парти та стільці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     17.04.2018 23:14:03                          */
/*==============================================================*/


alter table Chair
   drop constraint FK_CHAIR_CLASSROOM_CLASSROO;

alter table Classroom
   drop constraint "FK_CLASSROO_SCHOOL HA_SCHOOL";

alter table "Table"
   drop constraint FK_TABLE_CLASSROOM_CLASSROO;

drop index "classroom has chairs_FK";

drop table Chair cascade constraints;

drop index "School has Classrooms_FK";

drop table Classroom cascade constraints;

drop table School cascade constraints;

drop index "classrooms has Tables_FK";

drop table "Table" cascade constraints;

/*==============================================================*/
/* Table: Chair                                                 */
/*==============================================================*/
create table Chair 
(
   chair_id             INTEGER              not null,
   class_number         INTEGER,
   chair_color          VARCHAR2(20),
   chair_material       VARCHAR2(20),
   chair_height         FLOAT(8)             not null,
   constraint PK_CHAIR primary key (chair_id)
);

/*==============================================================*/
/* Index: "classroom has chairs_FK"                             */
/*==============================================================*/
create index "classroom has chairs_FK" on Chair (
   class_number ASC
);

/*==============================================================*/
/* Table: Classroom                                             */
/*==============================================================*/
create table Classroom 
(
   class_number         INTEGER              not null,
   school_number        INTEGER              not null,
   adress               VARCHAR2(50)         not null,
   class_volume         FLOAT(8),
   class_floor          INTEGER,
   constraint PK_CLASSROOM primary key (class_number)
);

/*==============================================================*/
/* Index: "School has Classrooms_FK"                            */
/*==============================================================*/
create index "School has Classrooms_FK" on Classroom (
   school_number ASC,
   adress ASC
);

/*==============================================================*/
/* Table: School                                                */
/*==============================================================*/
create table School 
(
   school_number        INTEGER              not null,
   adress               VARCHAR2(50)         not null,
   school_phone_number  VARCHAR2(20)         not null,
   school_email         VARCHAR2(40)         not null,
   constraint PK_SCHOOL primary key (school_number, adress)
);

/*==============================================================*/
/* Table: "Table"                                               */
/*==============================================================*/
create table "Table" 
(
   table_id             INTEGER              not null,
   class_number         INTEGER,
   table_color          VARCHAR2(15),
   table_material       VARCHAR2(20),
   table_height         NUMBER(8)            not null,
   table_lenght         NUMBER(8)            not null,
   constraint PK_TABLE primary key (table_id)
);

/*==============================================================*/
/* Index: "classrooms has Tables_FK"                            */
/*==============================================================*/
create index "classrooms has Tables_FK" on "Table" (
   class_number ASC
);

alter table Chair
   add constraint FK_CHAIR_CLASSROOM_CLASSROO foreign key (class_number)
      references Classroom (class_number);

alter table Classroom
   add constraint "FK_CLASSROO_SCHOOL HA_SCHOOL" foreign key (school_number, adress)
      references School (school_number, adress);

alter table "Table"
   add constraint FK_TABLE_CLASSROOM_CLASSROO foreign key (class_number)
      references Classroom (class_number);
INSERT INTO School (school_number,adress,school_phone_number,school_email)
values (172,'Ruginska 30/32','+380445005050','sch172@ukr.net');
INSERT INTO School (school_number,adress,school_phone_number,school_email)
values (163,'Baumana 25','+380444004040','sch163@ukr.net');
INSERT INTO School (school_number,adress,school_phone_number,school_email)
values (145,'Shota Rustaveli 48','+380447777777','sch145@ukr.net');

INSERT INTO CLASSROOM (class_number,school_number,adress,class_volume,class_floor)
values (215,172,'Ruginska 30/32',85.7,2);
INSERT INTO CLASSROOM (class_number,school_number,adress,class_volume,class_floor)
values (308,163,'Baumana 25',70.1,3);
INSERT INTO CLASSROOM (class_number,school_number,adress,class_volume,class_floor)
values (301,172,'Ruginska 30/32',79.24,3);

INSERT INTO "Table" (table_id,table_color, table_material, table_height, table_lenght,class_number)
values (2150123456,'brown','wood', 74.5, 152,215);
INSERT INTO "Table" (table_id,table_color, table_material, table_height, table_lenght,class_number)
values (3010123456,'brown','wood', 74.5, 152,301);
INSERT INTO "Table" (table_id,table_color, table_material, table_height, table_lenght,class_number)
values (3080123456,'brown','wood', 74.5, 152,308);

INSERT INTO Chair (Chair_id,Chair_color, Chair_material, Chair_height, class_number)
values (2150123456,null,null, 74.5, 215);
INSERT INTO Chair (Chair_id,Chair_color, Chair_material, Chair_height, class_number)
values (3010123456,'brown','wood', 80, 301);
INSERT INTO Chair (Chair_id,Chair_color, Chair_material, Chair_height, class_number)
values (3080123456,'black','skin', 80, 308);














  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO Khodakivskyy;
GRANT INSERT ANY TABLE TO Khodakivskyy;
GRANT SELECT ANY TABLE TO Khodakivskyy;




/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT
    COUNT(cust_name)
FROM
    customers,
    orders,
    orderitems
WHERE
    customers.cust_id = orders.cust_id
    AND   orderitems.order_num = orders.order_num
    AND   orderitems.item_price IN (
        SELECT
            MAX(orderitems.item_price)
        FROM
            orderitems
    );









/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних електронних адрес зберігається в таблиці CUSTOMERS - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT COUNT(DISTINCT CUST_EMAIL) AS count_email
FROM CUSTOMERS;













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT (CUSTOMERS  WHERE CUSTOMERS.CUST_ID IN ((PROJECT CUSTOMERS CUSTOMERS.CUST_ID) MINUS (PROJECT ORDERS ORDERS.CUST_ID)) (RENAME (CUST_NAME ||' '|| CUST_EMAIL) client_email )

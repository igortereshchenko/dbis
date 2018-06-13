-- LABORATORY WORK 1
-- BY Buchynska_Kateryna
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлювати дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER buchynska IDENTIFIED BY buchynska
DEFAULT TABLESPACE "USERS" ;


GRANT SELECT ANY TABLE to buchynska;
GRANT UPDATE ANY TABLE to buchynska;
GRANT CREATE TABLE to buchynska;

GRANT 'CONNECT' to buchynska;
ALTER USER buchynska QUOTA 100M ON USERS;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На вулиці стоїть будинок, що має 10 квартир.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:




drop table Street cascade constraints;

/*==============================================================*/
/* Table: Street                                                */
/*==============================================================*/
create table Street 
(
   street_name          VARCHAR2(30)         not null,
   street_area          VARCHAR2(30)         not null,
   street_length_in_km        INTEGER, 
   quantity_of_houses   INTEGER              not null
 ,
   constraint PK_STREET primary key (street_name, street_area)
);

ALTER TABLE Street ADD constraint quantity_house_check CHECK ( quantity_of_houses BETWEEN 10 ANd 999) ;

INSERT INTO Street VALUES ('Lobanovskogo','Solomianskui', '13', '125')  ;
INSERT INTO Street VALUES ('Asatanskogo','Obolon', '78', '423')  ;
INSERT INTO Street VALUES ('Naykova','Solomianskui', '63', '155')  ;

drop table House cascade constraints;

/*==============================================================*/
/* Table: House                                                 */
/*==============================================================*/
create table House 
(
   house_street         VARCHAR2(30)         not null,
   house_number         INTEGER              not null,
   number_of_floors     INTEGER              not null,
   number_of_entrances  INTEGER              not null,
   constraint PK_HOUSE primary key (house_street, house_number)
);
  ALTER TABLE House ADD constraint house_number_check CHECK ( house_number BETWEEN 1 ANd 999) ;
  
  INSERT INTO House VALUES ('Lobanovskogo',123 , 5, 2)  ;
  INSERT INTO House VALUES ('Asatanskogo',17, 5,1)  ;
  INSERT INTO House  VALUES ('Mukylina ',169 , 9, 2)  ;
  
drop table Room cascade constraints;

/*==============================================================*/
/* Table: Room                                                  */
/*==============================================================*/
create table Room 
(
   room_number          INTEGER              not null,
   owner_name           VARCHAR2  (20)               not null,
   number_of_inhabit    INTEGER,
   number_of_sqr_meters INTEGER              not null,
   constraint PK_ROOM primary key (room_number, owner_name)
);
ALTER TABLE Room REGEXP_LIKE (room_number, '^[1-9][0-9]{0,3}');

  INSERT INTO Room  VALUES (169 , 'Iruna Buchynska', 2, 70)  ;
   INSERT INTO Room  VALUES (9 , 'Olga Nukityk', 4, 160)  ;
    INSERT INTO Room  VALUES (23 , 'Vadim Olexandrovskui', 3, 50)  ;
  
drop table Room_in_house cascade constraints;

/*==============================================================*/
/* Table: Room_in_house                                         */
/*==============================================================*/
create table Room_in_house 
(
   street_name          VARCHAR2(30)         not null,
   street_area          VARCHAR2(30)         not null,
   house_street         VARCHAR2(30)         not null,
   house_number         INTEGER              not null,
   constraint PK_ROOM_IN_HOUSE primary key (street_name, street_area, house_street, house_number)
);

alter table Room_in_house
   add constraint FK_HOUSE_HAS_ROOM foreign key (house_street, house_number)
      references House (house_street, house_number);



  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT INSERT ANY TABLE TO buchynska;







/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар та яке ім'я покупця цього замовлення?
Виконати завдання в алгебрі Кодда.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


SELECT OrderItems.order_num ,Customers.cust_name
FROM OrderItems join Orders ON OrderItems.order_num = Orders.order_num
JOIN Customers ON Orders.cust_id= Customers.cust_id 
WHERE item_price = (SELECT Max(item_price) FROM OrderItems) ;












/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних електронних адрес покупців - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT DISTINCT COUNT (cust_email)  AS  "count_email" FROM Customers ;












/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT vend_name
FROM
(
SELECT  Vendors.vend_id, Vendors.vend_name, COUNT(OrderItems.prod_id)
FROM 
Vendors JOIN Products ON Vendors.vend_id=Products.vend_id
JOIN OrderItems ON OrderItems.prod_id=Products.prod_id 
GROUP BY Vendors.vend_id, Vendors.vend_name 
HAVING COUNT(OrderItems.prod_id)=0 );


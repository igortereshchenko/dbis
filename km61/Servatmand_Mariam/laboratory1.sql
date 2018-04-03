
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Servatmand INDENTIFIED BY Servatmand
DEFAULT TABLESPACE "USERS" TEMPORARY TABLESPACE "TEMP";

ALTER USER Servatmand QUOTA 100M ON USERS;
GRANT "CONNECT" TO Servatmand; 
GRANT SELECT ANY TABLE TO Servatmand;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Громадянин України має власне житло та автомобіль.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE table Citizen(
	citizen_name VARCHAR(30),
	phone_number VARCHAR(13),
	person_id NUMBER(12),
	age NUMBER(3)
);

CREATE table house (
 	street VARCHAR(15),
 	floor_number NUMBER(3),
 	resident_number NUMBER(4),
 	building_year NUMBER(4))

CREATE table car(
 	car_id VARCHAR(20),
 	car_model VARCHAR(15),
 	car_type VARCHAR(15),
 	release_year NUMBER(4)
);


create table Citizen_house_car(
 	person_id NUMBER(12),
 	citizen_name VARCHAR(30),
 	street VARCHAR(15),
 	car_id VARCHAR(20)
);

ALTER TABLE Citizen
    add CONSTRAINT citizen_pk primary key (person_id, citizen_name);

ALTER TABLE House
    add CONSTRAINT house_pk primary key (street);

ALTER TABLE Car
    add CONSTRAINT car_pk primary key (car_id);


ALTER TABLE Citizen_house_car
    add CONSTRAINT Citizen_house_car_pk primary key (person_id, citizen_name, street);


ALTER TABLE Citizen_house_car
add CONSTRAINT car_fk   FOREIGN KEY(person_id) REFERENCES car (car_id);
ALTER TABLE Citizen_house_car
add CONSTRAINT  person_fk  FOREIGN KEY(citizen_name) REFERENCES citizen(person_id);
ALTER TABLE Citizen_house_car
add CONSTRAINT street_fk   FOREIGN KEY(street)  REFERENCES house(street);
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT INSERT ANY TABLE TO Servatmand;







/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT VENDORS.vend_name, ORDERITEMS.item_price FROM VENDORS, PRODUCTS, ORDERITEMS WHERE VENDORS.vend_id = PRODUCTS.vend_id and PRODUCTS.prod_id = ORDERITEMS.prod_id and ORDERITEMS.item_price IN (SELECT MIN(ORDERITEMS.item_price) FROM ORDERITEMS );













/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що мають поштову адресу та живуть в USA, у верхньому регістрі - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
RENAME( PROJECT UPPER(CUSTOMERS WHERE CUST_COUNTRY = 'USA' AND CUST_ZIP IS NOT NULL) {CUST_NAME} ) CUST_NAME -> client_name














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
PROJECT LOWER(( PROJECT (VENDORS) {VEND_NAME, VEND_ID}) MINUS PROJECT ((VENDORS TIMES ORDERITEMS) TIMES (ORDERS TIMES PRODUCTS) ){VEND_NAME, VENDORS.VEND_ID} WHERE (ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM AND ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID AND PRODUCTS.VEND_ID = VENDORS.VEND_ID)) (RENAME {VEND_NAME} vendor_name);


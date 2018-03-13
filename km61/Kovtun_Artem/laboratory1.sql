/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER kovtun IDENTIFIED BY kovtun111
DEFAULT TABLESPACE 'USERS'
TEMPORARY TABLESPACE 'TEMP';

ALTER USER kovtun QUOTA 10M;

GRANT SELECT ANY TABLE TO kovtun;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Громадянин України має власне житло та автомобіль.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE humans 
(
    human_id NUMBER(6) NOT NULL,
    human_name VARCHAR2(10) NOT NULL
);

ALTER TABLE humans ADD CONSTRAINT human_id_pk PRIMARY KEY (human_id);

CREATE TABLE appartments 
(
    app_id NUMBER(6) NOT NULL,
    app_quantity_of_rooms NUMBER(2) NOT NULL
);

ALTER TABLE appartments ADD CONSTRAINT app_id_pk PRIMARY KEY (app_id);

CREATE TABLE cars
(
    car_id NUMBER(6) NOT NULL,
    car_tupe VARCHAR(20) NOT NULL
);

ALTER TABLE cars ADD CONSTRAINT car_id_pk PRIMARY KEY (car_id);


CREATE TABLE human_appartment 
(
    human_id_fk NUMBER(6) NOT NULL,
    app_id_fk NUMBER(6) NOT NULL
);

ALTER TABLE human_appartment ADD CONSTRAINT human_appartment_pk PRIMARY KEY (human_id_fk, app_id_fk);

ALTER TABLE human_appartment ADD CONSTRAINT human_fk FOREIGN KEY (human_id_fk) REFERENCES human(human_id);

ALTER TABLE human_appartment ADD CONSTRAINT app_fk FOREIGN KEY (app_id_fk) REFERENCES appartments(app_id);



CREATE TABLE human_car 
(
    human_id_fk NUMBER(6) NOT NULL,
    car_id_fk NUMBER(6) NOT NULL
);

ALTER TABLE human_car ADD CONSTRAINT human_car_pk PRIMARY KEY (human_id_fk, app_id_fk);

ALTER TABLE human_car  ADD CONSTRAINT human_fk FOREIGN KEY (human_id_fk) REFERENCES human(human_id);

ALTER TABLE human_car ADD CONSTRAINT app_fk FOREIGN KEY (car_id_fk) REFERENCES appartments(app_id);


  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO kovtun;
GRANT UPDATE ANY TABLE TO kovtun;
GRANT SELECT ANY TABLE TO kovtun;

/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:



PROJECT VENDORS TIMES PRODUCTS TIMES ORDERITEMS WHERE 
    VENDORS.VEND_ID = PRODUCTS.VEND_ID AND PRODUCTS.PROD_ID IN (PROJECT ORDERSITEMS (MIN()) {VENDOR.VEND_NAME} 


/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що мають поштову адресу та живуть в USA, у верхньому регістрі - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT UPPER(CUST_NAME) AS client_name 
WHERE CUST_ADDRESS IS NOT NULL AND CUST_COUNTRY = 'USA';



/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:



SELECT LOWER(VEND_NAME) FROM PRODUCTS,ORDERITEMS,VENDORS
MINUS 
SELECT LOWER(VEND_NAME) FROM PRODUCTS,ORDERITEMS,VENDORS WHERE 
    VENDORS.VEND_ID = PRODUCT.VEND_ID AND PRODUCT.PROD_ID = ORDERITEMS.PROD_ID;

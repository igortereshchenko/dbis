/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER kovtun IDENTIFIED BY kovtun111
DEFAULT TABLESPACE 'USERS'
TEMPORARY TABLESPACE 'TEMP';

ALTER USER kovtun QUOTA 10M ON USERS;

GRANT "CONNECT" TO kovtun;

GRANT SELECT ANY TABLE TO kovtun;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Громадянин України має власне житло та автомобіль.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


/*  CITIZEN TABLE - CREATION */

CREATE TABLE citizens 
(
    citizen_id NUMBER(6) NOT NULL AUTO_INCREMENT,
    citizen_first_name VARCHAR2(20) NOT NULL,
    citizen_second_name VARCHAR2(20) NOT NULL,
    citizen_birthday DATE NOT NULL
);


/*  CITIZEN TABLE - CONSTRAINTS */

ALTER TABLE citizens ADD CONSTRAINT citizen_id_pk PRIMARY KEY (citizen_id);
ALTER TABLE citizens ADD CONSTRAINT citizen_first_name_check CHECK (REGEXP_LIKE(citizen_first_name, "^[A-Z][a-z]{1,19}$", "I"));
ALTER TABLE citizens ADD CONSTRAINT citizen_second_name_check CHECK (REGEXP_LIKE(citizen_second_name, "^[A-Z][a-z]{1,19}$", "I"));
ALTER TABLE citizens ADD CONSTRAINT citizen_birthday_check CHECK (citizen_birthday > TO_DATE('01-JANUARY-1900'));


/*  CITIZEN TABLE - INSERTION */

INSERT INTO citizens (citizen_first_name, citizen_second_name, citizen_birthday) VALUES ('Daniel','Rodriguez',TO_DATE('19-MARCH-1985'));
INSERT INTO citizens (citizen_first_name, citizen_second_name, citizen_birthday) VALUES ('Mike','Valters',TO_DATE('9-JUNE-2001'));
INSERT INTO citizens (citizen_first_name, citizen_second_name, citizen_birthday) VALUES ('Jay','Peans',TO_DATE('1-OCTOBER-1990'));


/* HOUSE TABLE - CREATION */

CREATE TABLE houses 
(
    house_id NUMBER(6) NOT NULL AUTO_INCREMENT ,
    house_area NUMBER(3,2) NOT NULL,
    house_manufactor VARCHAR(30) NOT NULL,
    house_type VARCHAR(30) NOT NULL
);


/* HOUSE TABLE - CONSTRAINTS */

ALTER TABLE houses ADD CONSTRAINT house_id_pk PRIMARY KEY (app_id);
ALTER TABLE houses ADD CONSTRAINT house_area_check CHECK(house_area > 0 and house_area <= 999.99);
ALTER TABLE houses ADD CONSTRAINT house_manufactor_check CHECK(REGEXP_LIKE(house_manufactor, "^([A-Z][a-z]+)+$", "I"));
ALTER TABLE houses ADD CONSTRAINT house_type_check CHECK(REGEXP_LIKE(house_type, "^([A-Z][a-z]+)+$", "I"));


/*HOUSE TABLE - INSERTION */

INSERT INTO houses (house_area, house_manufactor, house_type) VALUES (96, 'The Best House Builder', 'Villa');
INSERT INTO houses (house_area, house_manufactor, house_type) VALUES (45, 'AwesoneHouse', 'Farmhouse');
INSERT INTO houses (house_area, house_manufactor, house_type) VALUES (87.4, 'For Centuries', 'Federal');


/* CAR TABLE - CREATION */

CREATE TABLE cars
(
    car_id NUMBER(6) NOT NULL AUTO_INCREMENT,
    car_brand VARCHAR(30) NOT NULL,
    car_color VARCHAR(30) NOT NULL,
    car_manufacture_year DATE NOT NULL
);


/* CAR TABLE - CONSTRAINTS */

ALTER TABLE cars ADD CONSTRAINT car_id_pk PRIMARY KEY (car_id);
ALTER TABLE cars ADD CONSTRAINT car_brand_check CHECK(REGEXP_LIKE(car_brand, "^([A-Z][a-z]+)+$", "I"));
ALTER TABLE cars ADD CONSTRAINT car_color_check CHECK(REGEXP_LIKE(car_color, "^[A-Z][a-z]{1,19}$", "I"));
ALTER TABLE cars ADD CONSTRAINT car_manufacture_year_check CHECK (car_manufacture_year > TO_DATE('01-JANUARY-1900'));


/* CAR TABLE - INSERTION */

INSERT INTO cars (car_brand,car_color, car_manufacture_year) VALUES ('Aston Martin','Black',TO_DATE('01-NOVEMBER-1996'));
INSERT INTO cars (car_brand,car_color, car_manufacture_year) VALUES ('Lamborghini','Red',TO_DATE('15-NOVEMBER-2000'));
INSERT INTO cars (car_brand,car_color, car_manufacture_year) VALUES ('Ferrari','Black',TO_DATE('15-MAY-2012'));


/* CITIZEN-HOUSE TABLE - CREATION */

CREATE TABLE citizen_house 
(
    citizen_id_fk NUMBER(6) NOT NULL,
    house_id_fk NUMBER(6) NOT NULL,
    purchase_date DATE NOT NULL
);


/* CITIZEN - HOUSE TABLE - CONSTRAINTS */

ALTER TABLE citizen_house ADD CONSTRAINT citizen_house_pk PRIMARY KEY (citizen_id_fk, house_id_fk,purchase_date);
ALTER TABLE citizen_house ADD CONSTRAINT citizen_fk FOREIGN KEY (citizen_id_fk) REFERENCES citizens(citizen_id);
ALTER TABLE citizen_house ADD CONSTRAINT house_fk FOREIGN KEY (house_id_fk) REFERENCES houses(house_id);
ALTER TABLE citizen_house ADD CONSTRAINT purchase_date_check CHECK (purchase_date > TO_DATE('01-JANUARY-1900'));


/* CITIZEN - HOUSE TABLE - INSERTION */

INSERT INTO citizen_house (citizen_id_fk, house_id_fk, purchase_date) VALUES (1,1,TO_DATE('11-SEPTEMBER-1988'));
INSERT INTO citizen_house (citizen_id_fk, house_id_fk, purchase_date) VALUES (2,3,TO_DATE('03-JUNE-2016'));
INSERT INTO citizen_house (citizen_id_fk, house_id_fk, purchase_date) VALUES (2,2,TO_DATE('15-JULY-2017'));


/* CITIZEN-CAR - CREATION */

CREATE TABLE citizen_car 
(
    citizen_id_fk NUMBER(6) NOT NULL,
    car_id_fk NUMBER(6) NOT NULL
    purchase_date DATE NOT NULL
);


/* CITIZEN-CAR - CONSTRAINTS */

ALTER TABLE citizen_car ADD CONSTRAINT citizen_car_pk PRIMARY KEY (citizen_id_fk, car_id_fk,purchase_date);
ALTER TABLE citizen_car  ADD CONSTRAINT citizen_fk FOREIGN KEY (citizen_id_fk) REFERENCES citizens(citizen_id);
ALTER TABLE citizen_car ADD CONSTRAINT car_fk FOREIGN KEY (car_id_fk) REFERENCES cars(car_id);
ALTER TABLE citizen_house ADD CONSTRAINT purchase_date_check CHECK (purchase_date > TO_DATE('01-JANUARY-1900'));


/* CITIZEN-CAR - INSERTION */
 
INSERT INTO citizen_car (citizen_id_fk, car_id_fk, purchase_date) VALUES (1,1,TO_DATE('30-MAY-1999')); 
INSERT INTO citizen_car (citizen_id_fk, car_id_fk, purchase_date) VALUES (1,3,TO_DATE('19-MAY-2014')); 
INSERT INTO citizen_car (citizen_id_fk, car_id_fk, purchase_date) VALUES (2,1,TO_DATE('01-SEPTEMBER-2015')); 
 
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO kovtun;
GRANT INSERT ANY TABLE TO kovtun;
GRANT SELECT ANY TABLE TO kovtun;

/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


PROJECT VENDORS TIMES PRODUCTS TIMES ORDERITEMS {VENDOR.VEND_NAME} WHERE 
    VENDORS.VEND_ID = PRODUCTS.VEND_ID AND 
        PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID AND 
            ORDERITEMS.ORDER_PRICE IN (PROJECT ORDERSITEMS (MIN(ORDER_PRICE)));


/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що мають поштову адресу та живуть в USA, у верхньому регістрі - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT DISTINCT UPPER(CUST_NAME) AS client_name FROM customers -- ADD 'FROM CUSTOMERS'
WHERE CUST_ADDRESS IS NOT NULL AND CUST_COUNTRY = 'USA';;


/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


SELECT LOWER(VEND_NAME) vendor_name FROM PRODUCTS,VENDORS WHERE
    VENDORS.VEND_ID = PRODUCTS.VEND_ID  -- ADD CONDITION THAT VENDOR SHOULD HAVE A PRODUCT
MINUS 
SELECT LOWER(VEND_NAME) vendor_name FROM PRODUCTS,ORDERITEMS,VENDORS WHERE 
    VENDORS.VEND_ID = PRODUCTS.VEND_ID AND PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID;

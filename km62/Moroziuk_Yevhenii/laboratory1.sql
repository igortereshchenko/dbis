-- LABORATORY WORK 1
-- BY Moroziuk_Yevhenii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER student IDENTIFIED BY student 
DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";

ALTER USER student QUOTA 100M ON USERS;

GRANT DROP ANY TABLE TO student;
GRANT INSERT ANY TABLE TO student;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
-- human
CREATE TABLE Human (
    human_id     NUMBER(5) NOT NULL,
    human_name   VARCHAR(24) NOT NULL,
    birthday        DATE NULL
);
ALTER TABLE Human

ADD CONSTRAINT human_id_pk PRIMARY KEY ( human_id);

ALTER TABLE Human
    ADD CONSTRAINT Check_Human_Id CHECK( length(human_id) = 5 );
ALTER TABLE Human 
    ADD CONSTRAINT Check_Human_Name CHECK (REGEXP_LIKE(human_name, '^\w+\s\w+$')); 
ALTER TABLE Human 
    ADD CONSTRAINT Check_Human_Birth_Date CHECK (REGEXP_LIKE(birthday, '^([0-9]{2}\.){2}([0-9]{4})$')); 

-- mobile
CREATE TABLE mobile (
    imei NUMBER(15) NOT NULL
);

ALTER TABLE mobile
    ADD CONSTRAINT mobile_pk PRIMARY KEY (imei);
ALTER TABLE mobile
    ADD CONSTRAINT Cheak_Mobile_Imei CHECK ( REGEXP_LIKE(imei, '^([0-9]{15})$') );

-- numan bought mobile
CREATE TABLE Humans_mobile(
    human_fk NUMBER(5) NOT NULL,
    imei_fk NUMBER(15) NOT NULL
);

ALTER TABLE  Humans_Mobile
    ADD CONSTRAINT humans_mobile_pk PRIMARY KEY (human_fk, imei_fk);  
ALTER TABLE   Humans_Mobile
    ADD CONSTRAINT human_mobile_fk FOREIGN KEY (human_fk) REFERENCES Human (human_id);
ALTER TABLE   Humans_Mobile
    ADD CONSTRAINT imei_mobile_fk FOREIGN KEY (imei_fk) REFERENCES Mobile (imei);

-- mobile_spec
CREATE TABLE mobile_ch (
    imei_sp_fk   NUMBER(15) NOT NULL,
    mobile_brand      VARCHAR2(16) NOT NULL,
    mobile_camera     NUMBER(2) NOT NULL,
    mobile_price      NUMBER(5) NOT NULL
);

ALTER TABLE mobile_ch
    ADD CONSTRAINT imei_mob_pk PRIMARY KEY (imei_sp_fk);
ALTER TABLE mobile_ch
    ADD CONSTRAINT mobile_spec_fk FOREIGN KEY (imei_sp_fk) REFERENCES Mobile (imei);



-----
INSERT INTO Human (
    human_id,
    human_name,
    birthday
) VALUES (
    10001,
    'Yevhenii',
    TO_DATE('1999-03-10','YYYY-MM-DD')
);

INSERT INTO Human (
    human_id,
    human_name,
    birthday
) VALUES (
    10002,
    'Petro',
    TO_DATE('1989-06-10','YYYY-MM-DD')
);

INSERT INTO Human (
    human_id,
    human_name,
    birthday
) VALUES (
    10003,
    'Lucius',
    TO_DATE('1982-05-01','YYYY-MM-DD')
);

INSERT INTO Human (
    human_id,
    human_name,
    birthday
) VALUES (
    10004,
    'Lucius',
    TO_DATE('1982-01-05','YYYY-MM-DD')
);

INSERT INTO Mobile (
    imei
) VALUES (
    100016789010001
);
INSERT INTO Mobile (
    imei
) VALUES (
    100026789010002
);
INSERT INTO Mobile (
    imei
) VALUES (
    100036789010003
);
---
INSERT INTO Humans_Mobile (
    human_fk,
    imei_fk
) VALUES (
    10001,
    100016789010001
);
INSERT INTO Humans_Mobile (
    human_fk,
    imei_fk
) VALUES (
    10002,
    100026789010002
);
INSERT INTO Humans_Mobile (
    human_fk,
    imei_fk
) VALUES (
    10003,
    100036789010003
);
--

INSERT INTO mobile_ch (
    imei_sp_fk,
    mobile_brand,
    mobile_camera,
    mobile_price
) VALUES (
    100016789010001,
    'Samsung',
    12,
    32000
);
INSERT INTO mobile_ch (
    imei_sp_fk,
    mobile_brand,
    mobile_camera,
    mobile_price
) VALUES (
    100026789010002,
    'Xiaomi',
    12,
    22000
);
INSERT INTO mobile_ch (
    imei_sp_fk,
    mobile_brand,
    mobile_camera,
    mobile_price
) VALUES (
    100036789010003,
    'Apple',
    12,
    36000
);
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO student;
GRANT INSERT ANY TABLE TO student;
GRANT SELECT ANY TABLE TO student;




/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

(((Products WHERE prod_id NOT IN (Orderitems PROJECT prod_id))
 Project prod_id, prod_price) RENAME max(prod_price) -> max_price) Project max_price










/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT CUST_NAME as "Customer_name"
FROM CUSTOMERS, ORDERS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
AND ORDERS.ORDER_NUM IN (
  SELECT ORDERITEMS.ORDER_NUM
  FROM ORDERITEMS
  WHERE ORDERITEMS.ITEM_PRICE = (
    SELECT MAX(ORDERITEMS.ITEM_PRICE)
    FROM ORDERITEMS)
    







/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT TRIM(VEND_NAME)||' '||TRIM(VEND_COUNTRY) as "vendor_name"
FROM VENDORS, PRODUCTS

MINUS

(SELECT TRIM(VEND_NAME)||' '||TRIM(VEND_COUNTRY) as "vendor_name"
FROM VENDORS, PRODUCTS
WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID);





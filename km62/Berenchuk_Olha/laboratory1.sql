— LABORATORY WORK 1
— BY Berenchuk_Olha

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

—-------------------------------------------------------------------------*/
—Код відповідь:
CREATE USER Berenchuk
IDENTIFIED BY koko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

GRANT "CONNECT" TO Berenchuk;

ALTER USER Berenchuk QUOTA 100M ON USERS;
GRANT DROP ANY TABLE TO Berenchuk;
GRANT INSERT ANY TABLE TO Berenchuk;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

—-------------------------------------------------------------------------*/
—Код відповідь:

CREATE TABLE mobile (
    mobile_brand            VARCHAR2(20) NOT NULL,
    mobile_price            NUMBER(8) NOT NULL,
    mobile_id               NUMBER(10) NOT NULL,
    mobile_characteristic   VARCHAR(100) NOT NULL,
    mobile_comment          VARCHAR(200) NOT NULL,
    CONSTRAINT mobile_pk PRIMARY KEY ( mobile_brand,
    mobile_price,
    mobile_id )
);

ALTER TABLE mobile
    ADD CONSTRAINT m_unq UNIQUE ( mobile_brand,
    mobile_price,
    mobile_id );

ALTER TABLE mobile
    ADD CONSTRAINT mobile_price_ch CHECK ( length(mobile_price) >= 3 );
    
—----------------------------------------------------------------------------

CREATE TABLE human (
    human_name        VARCHAR(20) NOT NULL,
    human_id_number   NUMBER(40) NOT NULL,
    hunam_old         NUMBER(3) NOT NULL,
    human_sex         VARCHAR(1) NOT NULL,
    CONSTRAINT human_pk PRIMARY KEY ( human_id_number )
);

ALTER TABLE human ADD CONSTRAINT h_unq UNIQUE ( human_id_number );

ALTER TABLE human
    ADD CONSTRAINT human_name_ch CHECK ( length(human_name) >= 3 );

—----------------------------------------------------------------------------

CREATE TABLE human_what_buy_mobile (
    human_id_number_fk   NUMBER(40) NOT NULL,
    mobile_brand_fk      VARCHAR2(20) NOT NULL,
    date_buy             DATE NOT NULL
);

ALTER TABLE human_what_buy_mobile
    ADD CONSTRAINT human_what_buy_mobile_pk PRIMARY KEY ( human_id_number_fk,
    mobile_brand_fk,
    date_buy );

ALTER TABLE human_what_buy_mobile
    ADD CONSTRAINT mobile_fk FOREIGN KEY ( mobile_brand_fk )
        REFERENCES mobile ( mobile_brand );

ALTER TABLE human_what_buy_mobile
    ADD CONSTRAINT human_fk FOREIGN KEY ( human_id_number_fk )
        REFERENCES human ( human_id_number );
        
—----------------------------------------------------------------------------

CREATE TABLE mobile_shop (
    mobile_price_fk     NUMBER(8) NOT NULL,
    mobile_id_fk        NUMBER(10) NOT NULL,
    date_buy_fk         DATE NOT NULL,
    accessories_name    VARCHAR2(20) NOT NULL,
    accessories_price   NUMBER(6) NOT NULL
);

ALTER TABLE mobile_shop
    ADD CONSTRAINT mobile_shop_pk PRIMARY KEY ( mobile_price_fk,
    mobile_id_fk,
    date_buy_fk );

ALTER TABLE mobile_shop
    ADD CONSTRAINT mob_pr_fk FOREIGN KEY ( mobile_price_fk )
        REFERENCES mobile ( mobile_price );

ALTER TABLE mobile_shop
    ADD CONSTRAINT mob_id_fk FOREIGN KEY ( mobile_id_fk )
        REFERENCES mobile ( mobile_id );

ALTER TABLE mobile_shop
    ADD CONSTRAINT date_human_buy_fk FOREIGN KEY ( date_buy_fk )
        REFERENCES human_what_buy_mobile ( date_buy );
        
—------------------------------------------------------------------------—

INSERT INTO mobile (
    mobile_brand,
    mobile_price,
    mobile_id,
    mobile_characteristic,
    mobile_comment
) VALUES (
    'iPhone 8',
    '27058',
    '78953152',
    'Face ID Recognition',
    'convenient'
);

INSERT INTO mobile (
    mobile_brand,
    mobile_price,
    mobile_id,
    mobile_characteristic,
    mobile_comment
) VALUES (
    'Meizu 5A',
    '6599',
    '41254532',
    'Nothing special',
    'the best'
);
INSERT INTO mobile (
    mobile_brand,
    mobile_price,
    mobile_id,
    mobile_characteristic,
    mobile_comment
) VALUES (
    'Galaxy S9',
    '24999',
    '84512539',
    '12 megapixel with f / 1.8 aperture',
    'good'
);

—------------------------------------------------------------------------—

INSERT INTO human (
    human_name,
    human_id_number,
    hunam_old,
    human_sex
) VALUES (
    'Richard',
    '78456275',
    '71',
    'm'
);

INSERT INTO human (
    human_name,
    human_id_number,
    hunam_old,
    human_sex
) VALUES (
    'Ivan',
    '19781456',
    '19',
    'm'
);

INSERT INTO human (
    human_name,
    human_id_number,
    hunam_old,
    human_sex
) VALUES (
    'Viki',
    '78453691',
    'f',
    '28'
);

—------------------------------------------------------------------------—

INSERT INTO human_what_buy_mobile (
    human_id_number_fk,
    mobile_brand_fk,
    date_buy
) VALUES (
    '78456275',
    'iPhone 8',
    TO_DATE('2017-08-17','YYYY-MM-DD')
);

INSERT INTO human_what_buy_mobile (
    human_id_number_fk,
    mobile_brand_fk,
    date_buy
) VALUES (
    '19781456',
    'Galaxy S9',
    TO_DATE('2020-05-25','YYYY-MM-DD')
);

INSERT INTO human_what_buy_mobile (
    human_id_number_fk,
    mobile_brand_fk,
    date_buy
) VALUES (
    '78453691',
    'Meizu 5A',
    TO_DATE('2014-08-13','YYYY-MM-DD')
);

—------------------------------------------------------------------------—

INSERT INTO mobile_shop (
    mobile_price_fk,
    mobile_id_fk,
    date_buy_fk,
    accessories_name,
    accessories_price
) VALUES (
    '27058',
    '78456275',
    TO_DATE('2017-11-17','YYYY-MM-DD'),
    'case',
    '500'
);

INSERT INTO mobile_shop (
    mobile_price_fk,
    mobile_id_fk,
    date_buy_fk,
    accessories_name,
    accessories_price
) VALUES (
    '6599',
    '19781456',
    TO_DATE('2020-05-05','YYYY-MM-DD'),
    'headphones',
    '255'
);

INSERT INTO mobile_shop (
    mobile_price_fk,
    mobile_id_fk,
    date_buy_fk,
    accessories_name,
    accessories_price
) VALUES (
    '2499',
    '78453691',
    TO_DATE('2014-08-14','YYYY-MM-DD'),
    'case',
    '150'
);

  
/* —------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

—-------------------------------------------------------------------------*/
—Код відповідь:

GRANT SELECT ANY TABLE TO Berenchuk;
GRANT ALTER ANY TABLE TO Berenchuk;
GRANT CREATE ANY TABLE TO Berenchuk;




/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
—-------------------------------------------------------------------------*/

—Код відповідь:

project max(prod_price) AS MAX_PRICE
{
PROJECT PRODUCTS.PROD_ID, PRODUCTS.PROD_PRICE
{ PRODUCTS TIMES ORDERITEMS }

MINUS

PROJECT PRODUCTS.PROD_ID, PRODUCTS.PROD_PRICE
{ ORDERITEMS TIMES PRODUCTS }
WHERE PRODUCTS.PROD_ID = ORDERITEMS.prod_id 
};


/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

—-------------------------------------------------------------------------*/

—Код відповідь:

SELECT
    products,
    customers,
    orders,
    orderitems,
    customers.cust_name AS "customer_name",
    prod_price
WHERE
PROD_PRICE IN (
SELECT ( products ) FROM MAX(prod_price) ) 
  AND products.prod_id = orderitems.prod_id 
  AND orderitems.order_num = orders.order_num
  AND orders.cust_id = customers.cust_id);


/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали
—-------------------------------------------------------------------------*/
—Код відповідь:

SELECT
    ( vendors )
FROM
    vendors.vend_id,
    vendors.vend_name,
    vendors.vend_country minus
SELECT
    vendors,
    products, ( rename vend_name || vend_country ) as "vendor_name"
FROM
    vendors.vend_id,
    vendors.vend_name,
    vendors.vend_country
WHERE vendors.vend_id = products.vend_id;

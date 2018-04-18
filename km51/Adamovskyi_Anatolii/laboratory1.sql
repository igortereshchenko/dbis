-- LABORATORY WORK 1
-- BY Adamovskyi_Anatolii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER adamovskiy IDENTIFIED BY password
    DEFAULT TABLESPACE "USERS"
    TEMPORARY TABLESPACE "TEMP"
    QUOTA 100 M ON users;

GRANT "CONNECT" TO adamovskiy;

GRANT
    SELECT ANY TABLE
TO adamovskiy;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
CREATE TABLE comp_hard_fk (
    computer_mac_address     VARCHAR2(30) NOT NULL,
    hardware_party_number    INTEGER NOT NULL,
    hardware_serial_number   INTEGER NOT NULL
);

ALTER TABLE comp_hard_fk
    ADD CONSTRAINT comp_hard_fk_pk PRIMARY KEY ( computer_mac_address,
                                                 hardware_party_number,
                                                 hardware_serial_number );

CREATE TABLE comp_soft_fk (
    computer_mac_address   VARCHAR2(30) NOT NULL,
    software_soft_name     VARCHAR2(30) NOT NULL,
    software_version       VARCHAR2(30) NOT NULL
);

ALTER TABLE comp_soft_fk
    ADD CONSTRAINT comp_soft_fk_pk PRIMARY KEY ( computer_mac_address,
                                                 software_soft_name,
                                                 software_version );

CREATE TABLE computer (
    mac_address            VARCHAR2(30),
    comp_name              VARCHAR2(30),
    owner_owner_passport   VARCHAR2(30) NOT NULL
);

ALTER TABLE computer ADD CONSTRAINT computer_pk PRIMARY KEY ( mac_address );

CREATE TABLE hardware (
    party_number    INTEGER NOT NULL,
    serial_number   INTEGER NOT NULL,
    aparat_name     VARCHAR2(30)
);

ALTER TABLE hardware ADD CONSTRAINT hardware_pk PRIMARY KEY ( party_number,
                                                              serial_number );

CREATE TABLE owner (
    owner_name       VARCHAR2(30),
    owner_passport   VARCHAR2(30) NOT NULL
);

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_passport );

CREATE TABLE software (
    soft_name     VARCHAR2(30),
    version       VARCHAR2(30),
    description   CLOB
);

ALTER TABLE software ADD CONSTRAINT software_pk PRIMARY KEY ( soft_name,
                                                              version );

ALTER TABLE comp_hard_fk
    ADD CONSTRAINT comp_hard_fk_computer_fk FOREIGN KEY ( computer_mac_address )
        REFERENCES computer ( mac_address );

ALTER TABLE comp_hard_fk
    ADD CONSTRAINT comp_hard_fk_hardware_fk FOREIGN KEY ( hardware_party_number,
                                                          hardware_serial_number )
        REFERENCES hardware ( party_number,
                              serial_number );

ALTER TABLE comp_soft_fk
    ADD CONSTRAINT comp_soft_fk_computer_fk FOREIGN KEY ( computer_mac_address )
        REFERENCES computer ( mac_address );

ALTER TABLE comp_soft_fk
    ADD CONSTRAINT comp_soft_fk_software_fk FOREIGN KEY ( software_soft_name,
                                                          software_version )
        REFERENCES software ( soft_name,
                              version );

ALTER TABLE computer
    ADD CONSTRAINT computer_owner_fk FOREIGN KEY ( owner_owner_passport )
        REFERENCES owner ( owner_passport );

ALTER TABLE computer
    ADD CONSTRAINT mac_address_check CHECK ( REGEXP_LIKE ( mac_address,
    '^[A-Za-z]{2}[-]{1}[A-Za-z]{2}[-]{1}[A-Za-z]{2}[-]{1}[A-Za-z]{2}[-]{1}[A-Za-z]{2}$' ) );

ALTER TABLE computer
    ADD CONSTRAINT comp_name_check CHECK ( REGEXP_LIKE ( comp_name,
    '^[A-Za-z]{30}$' ) );
    
ALTER TABLE owner
    ADD CONSTRAINT owner_passport_check CHECK ( REGEXP_LIKE ( owner_passport,
    '^[A-Z]{2}[0-9]{8}$' ) );

ALTER TABLE owner
    ADD CONSTRAINT owner_name_check CHECK ( REGEXP_LIKE ( owner_name,
    '^[A-Za-z]{30}$' ) );

ALTER TABLE hardware
    ADD CONSTRAINT party_number_check CHECK ( REGEXP_LIKE ( party_number,
    '^[0-9]{9}$' ) );

ALTER TABLE hardware
    ADD CONSTRAINT serial_number_check CHECK ( REGEXP_LIKE ( serial_number,
    '^[0-9]{9}$' ) );

ALTER TABLE hardware
    ADD CONSTRAINT aparat_name_check CHECK ( REGEXP_LIKE ( aparat_name,
    '^[-0-9A-Za-z]{30}$' ) );

ALTER TABLE software
    ADD CONSTRAINT soft_name_check CHECK ( REGEXP_LIKE ( soft_name,
    '^[-0-9A-Za-z]{30}$' ) );

ALTER TABLE software
    ADD CONSTRAINT version_check CHECK ( REGEXP_LIKE ( version,
    '^[-0-9A-Za-z]{30}$' ) );

ALTER TABLE software
    ADD CONSTRAINT description_check CHECK ( REGEXP_LIKE ( description,
    '^[-0-9A-Za-z]{100}$' ) );
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
GRANT
    CREATE ANY TABLE
TO adamovskiy;

GRANT
    INSERT ANY TABLE
TO adamovskiy;

GRANT
    SELECT ANY TABLE
TO adamovskiy;

/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

-- Відповідь reviewer-а

PROJECT(
    orderitems TIMES products
    WHERE orderitems.prod_id = products.prod_id
    AND products.prod_price = max(
        PROJECT products {prod_price}
    )
){order_num}

-- Відповідь reviewer-а переписана в SQL

SELECT
    order_num
FROM
    orderitems,
    products
WHERE
    orderitems.prod_id = products.prod_id
    and products.prod_price = max(
        SELECT 
            prod_price
        FROM
            products
    );

-- Завдання було виконано неправильно

-- Правильна відповідь

SELECT
    orders.order_num
FROM
    orders,
    orderitems
WHERE
    orders.order_num = orderitems.order_num
    AND   orderitems.item_price IN (
        SELECT
            MAX(item_price)
        FROM
            orderitems
    );

/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

-- Відповідь reviewer-а

PROJECT 
    customers{cust_name} 
RENAME cust_name AS count_name

-- Якщо проігнорувати неправильний синтаксис то можна переписати це в ось такий SQL запит

SELECT
    cust_name count_name
FROM
    customers;

-- Завдання було виконано неправильно

-- Правильна відповідь

SELECT
    COUNT(DISTINCT customers.cust_name) count_name
FROM
    customers,
    orders
WHERE
    orders.cust_id = customers.cust_id;

/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/

-- reviewer на надав його метод розв'язку даної задач в SQL

-- Правильна відповідь 

SELECT DISTINCT
    lower(TRIM(vendors.vend_name) ) vendor_name
FROM
    vendors,
    products
WHERE
    vendors.vend_id = products.vend_id
MINUS
SELECT DISTINCT
    lower(TRIM(vendors.vend_name) ) vendor_name
FROM
    vendors,
    products,
    orderitems
WHERE
    vendors.vend_id = products.vend_id
    AND   products.prod_id = orderitems.prod_id;

(
    PROJECT(
        vendors TIMES products
        WHERE
            vendors.vend_id = products.vend_id
    ){lower(TRIM(vendors.vend_name))} 
    RENAME TRIM(vendors.vend_name)) as vendor_name)

MINUS

(
    PROJECT(
        vendors TIMES products TIMES orderitems
        WHERE
            vendors.vend_id = products.vend_id
            AND  products.prod_id = orderitems.prod_id
    ){lower(TRIM(vendors.vend_name))} 
    RENAME TRIM(vendors.vend_name)) as vendor_name);



/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER DOVGOPOL IDENTIFIED  BY DOVGOPOL;
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
GRANT "CONNECT" to DOVGOPOL;
ALTER USER DOVGOPOL QUOTA 100M ON USERS
GRANT SELECT ANY TABLE TO DOVGOPOL;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE assembly (
    assembly_id             INTEGER NOT NULL,
    power_block_serial_id   INTEGER NOT NULL,
    processor_serial_id     INTEGER NOT NULL
);

ALTER TABLE assembly ADD CONSTRAINT assemblyv1_pk PRIMARY KEY ( assembly_id );

CREATE TABLE computer (
    computer_id              INTEGER
        CONSTRAINT nnc_computer_uuid NOT NULL,
    rating                   INTEGER,
    assemblyv1_assembly_id   INTEGER NOT NULL
);

ALTER TABLE computer ADD CONSTRAINT computer_pk PRIMARY KEY ( computer_id );

CREATE TABLE detail (
    serial_id11    INTEGER NOT NULL,
    name           VARCHAR2(20 CHAR) NOT NULL,
    manufacturer   VARCHAR2(20 CHAR)
);

ALTER TABLE detail ADD CONSTRAINT detail_pk PRIMARY KEY ( serial_id11 );

CREATE TABLE power_block (
    serial_id                 INTEGER NOT NULL,
    efficiency                INTEGER NOT NULL,
    power                     INTEGER NOT NULL,
    power_factor_correction   INTEGER
);

ALTER TABLE power_block ADD CONSTRAINT power_block_pk PRIMARY KEY ( serial_id );

CREATE TABLE processor (
    serial_id      INTEGER NOT NULL,
    core_count     INTEGER NOT NULL,
    frequency      INTEGER,
    heat_release   INTEGER
);

ALTER TABLE processor ADD CONSTRAINT processor_pk PRIMARY KEY ( serial_id );

CREATE TABLE program (
    program_id        INTEGER NOT NULL,
    program_type      VARCHAR2(20 CHAR),
    program_name      VARCHAR2(20 CHAR) NOT NULL,
    program_version   FLOAT NOT NULL
);

ALTER TABLE program ADD CONSTRAINT program_pk PRIMARY KEY ( program_id );

CREATE TABLE relation_5 (
    computer_computer_id   INTEGER NOT NULL,
    program_program_id     INTEGER NOT NULL
);

ALTER TABLE relation_5 ADD CONSTRAINT relation_5_pk PRIMARY KEY ( computer_computer_id,
                                                                  program_program_id );

ALTER TABLE assembly
    ADD CONSTRAINT assemblyv1_power_block_fk FOREIGN KEY ( power_block_serial_id )
        REFERENCES power_block ( serial_id );

ALTER TABLE assembly
    ADD CONSTRAINT assemblyv1_processor_fk FOREIGN KEY ( processor_serial_id )
        REFERENCES processor ( serial_id );

ALTER TABLE computer
    ADD CONSTRAINT computer_assemblyv1_fk FOREIGN KEY ( assemblyv1_assembly_id )
        REFERENCES assembly ( assembly_id );

ALTER TABLE detail
    ADD CONSTRAINT detail_power_block_fk FOREIGN KEY ( serial_id11 )
        REFERENCES power_block ( serial_id );

ALTER TABLE detail
    ADD CONSTRAINT detail_processor_fk FOREIGN KEY ( serial_id11 )
        REFERENCES processor ( serial_id );

ALTER TABLE relation_5
    ADD CONSTRAINT relation_5_computer_fk FOREIGN KEY ( computer_computer_id )
        REFERENCES computer ( computer_id );

ALTER TABLE relation_5
    ADD CONSTRAINT relation_5_program_fk FOREIGN KEY ( program_program_id )
        REFERENCES program ( program_id );

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE to DOVGOPOL;
GRANT UPDATE ANY TABLE to DOVGOPOL;
GRANT GRANT ANY TABLE to DOVGOPOL;
GRANT ALTER ANY TABLE to DOVGOPOL;

/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

select order_num from orderitems
where item_price in (select max(item_price) from orderitems)



/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
select COUNT(distinct CUST_NAME) AS count_name
from CUSTOMERS
WHERE cust_id IN
( select DISTINCT customers.cust_id
from CUSTOMERS, ORDERS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
)



/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT lower(TRIM(VEND_NAME)) as "vendor_name" FROM VENDORS
WHERE VEND_ID IN(
SELECT VEND_ID FROM PRODUCTS

MINUS

SELECT VEND_ID FROM PRODUCTS
WHERE PRODUCTS.PROD_ID IN (SELECT ORDERITEMS.PROD_ID FROM ORDERITEMS));

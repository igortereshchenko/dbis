/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER popravko IDENTIFIED BY popravko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER popravko GRANT ROLE "SELECT";
   
GRANT QUOTA 10M TO popravko;
GRANT SELECT ALL TABLES TO popravko;







/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE computer (
    computer_name   VARCHAR(20),
    computer_id     VARCHAR(4) NOT NULL
)

CREATE TABLE hardware (
    hardware_name   VARCHAR(20),
    hardware_id     VARCHAR(4) NOT NULL
)

CREATE TABLE software (
    software_name   VARCHAR(20),
    software_id     VARCHAR(4) NOT NULL
)

CREATE TABLE computer_hardware (
    computer_id   VARCHAR(4) NOT NULL,
    hardware_id   VARCHAR(4) NOT NULL
)

CREATE TABLE computer_software (
    computer_id   VARCHAR(4) NOT NULL,
    software_id   VARCHAR(4) NOT NULL
)

ALTER TABLE computer ADD CONSTRAINT computer_pk PRIMARY KEY ( computer_id );

ALTER TABLE hardware ADD CONSTRAINT hardware_pk PRIMARY KEY ( hardware_id );

ALTER TABLE software ADD CONSTRAINT software_pk PRIMARY KEY ( software_id );

ALTER TABLE computer_hardware ADD CONSTRAINT computer_hardware_pk PRIMARY KEY ( computer_id,
hardware_id );

ALTER TABLE computer_software ADD CONSTRAINT computer_software_pk PRIMARY KEY ( computer_id,
software_id );

ALTER TABLE computer_hardware
    ADD CONSTRAINT hardware_fk FOREIGN KEY ( hardware_id )
        REFERENCES hardware ( hardware_id );

ALTER TABLE computer_software
    ADD CONSTRAINT software_fk FOREIGN KEY ( software_id )
        REFERENCES software ( software_id );

ALTER TABLE computer
    ADD CONSTRAINT computer_check CHECK ( REGEXP_LIKE ( computer_id,
    '[A-Z]\d{3}' ) );

ALTER TABLE hardware
    ADD CONSTRAINT hardware_check CHECK ( REGEXP_LIKE ( hardware_id,
    '[A-Z]\d{3}' ) );

ALTER TABLE software
    ADD CONSTRAINT software_check CHECK ( REGEXP_LIKE ( software_id,
    '[A-Z]\d{3}' ) );

INSERT INTO computer (
    computer_name,
    computer_id
) VALUES (
    'Apple Mac Mini A1347',
    'C001'
);

INSERT INTO computer (
    computer_name,
    computer_id
) VALUES (
    'HP Envy',
    'C002'
);

INSERT INTO computer (
    computer_name,
    computer_id
) VALUES (
    'Lenovo I-350',
    'C003'
);

INSERT INTO computer (
    computer_name,
    computer_id
) VALUES (
    'ASUS X7',
    'C004'
);

INSERT INTO software (
    software_name,
    software_id
) VALUES (
    'WINDOWS X',
    'S001'
);

INSERT INTO software (
    software_name,
    software_id
) VALUES (
    'MAC OS',
    'S002'
);

INSERT INTO software (
    software_name,
    software_id
) VALUES (
    'UBUNTU',
    'S003'
);

INSERT INTO software (
    software_name,
    software_id
) VALUES (
    'FEDORA',
    'S004'
);

INSERT INTO hardware (
    hardware_name,
    hardware_id
) VALUES (
    'AMD Ryzen',
    'H001'
);

INSERT INTO hardware (
    hardware_name,
    hardware_id
) VALUES (
    'Intel core i3',
    'H002'
);

INSERT INTO hardware (
    hardware_name,
    hardware_id
) VALUES (
    'Intel Core i7',
    'H003'
);

INSERT INTO hardware (
    hardware_name,
    hardware_id
) VALUES (
    'Intel Core i5',
    'H004'
);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO popravko;
GRANT INSERT ANY TABLE TO popravko;
GRANT SELECT ANY TABLE TO popravko;





/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_ID
FROM ORDERITEMS
WHERE ITEM_PRICE=(SELECT MAX(ITEM_PRICE) FROM ORDERITEMS)); 













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT COUNT(DISTINCT CUST_NAME) AS count_name
FROM CUSTOMERS;
    














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

project vendors rename vendors name;

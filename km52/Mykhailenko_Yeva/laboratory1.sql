-- LABORATORY WORK 1
-- BY Mykhaylenko_Yeva
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER mykhaylenko IDENTIFIED BY mykhaylenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER mykhaylenko QUOTA 100M ON USERS;
GRANT "CONNECT" TO mykhaylenko ;

GRANT INSERT ANY TABLE TO mykhaylenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Класна кімната має парти та стільці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE classroom (
    room_id         NUMBER(3) PRIMARY KEY,
    room_size       NUMBER(4),
    number_chairs   NUMBER(2),
    number_desks    NUMBER(2)
);

CREATE TABLE chairs (
    chair_id      NUMBER(6) PRIMARY KEY,
    chair_model   VARCHAR2(4),
    room_id       NUMBER(3)
);

CREATE TABLE desks (
    desk_id      NUMBER(6) PRIMARY KEY,
    desk_model   VARCHAR2(4),
    room_id      NUMBER(3)
);

ALTER TABLE chairs
    ADD CONSTRAINT chair_fk FOREIGN KEY ( room_id )
        REFERENCES classroom ( room_id );

ALTER TABLE desks
    ADD CONSTRAINT desk_fk FOREIGN KEY ( room_id )
        REFERENCES classroom ( room_id );

CREATE TABLE reconditioning (
    reconditioning_date   DATE PRIMARY KEY,
    room_id               NUMBER(3)
);

ALTER TABLE reconditioning
    ADD CONSTRAINT rr_fk FOREIGN KEY ( room_id )
        REFERENCES classroom ( room_id );

INSERT INTO classroom (
    room_id,
    room_size,
    number_chairs,
    number_desks
) VALUES (
    101,
    42,
    30,
    15
);

INSERT INTO classroom (
    room_id,
    room_size,
    number_chairs,
    number_desks
) VALUES (
    102,
    42,
    29,
    15
);

INSERT INTO classroom (
    room_id,
    room_size,
    number_chairs,
    number_desks
) VALUES (
    103,
    65,
    44,
    20
);

INSERT INTO chairs (
    chair_id,
    chair_model,
    room_id
) VALUES (
    000001,
    'AE01',
    101
);

INSERT INTO chairs (
    chair_id,
    chair_model,
    room_id
) VALUES (
    000002,
    'AE01',
    101
);

INSERT INTO chairs (
    chair_id,
    chair_model,
    room_id
) VALUES (
    000003,
    'LT81',
    103
);

INSERT INTO desks (
    desk_id,
    desk_model,
    room_id
) VALUES (
    000001,
    'TB54',
    101
);

INSERT INTO desks (
    desk_id,
    desk_model,
    room_id
) VALUES (
    000002,
    'WR16',
    102
);

INSERT INTO desks (
    desk_id,
    desk_model,
    room_id
) VALUES (
    000003,
    'TB45',
    102
);

INSERT INTO reconditioning (
    reconditioning_date,
    room_id
) VALUES (
    TO_DATE('2014/05/03 00:00:00','yyyy/mm/dd hh24:mi:ss'),
    101
);

INSERT INTO reconditioning (
    reconditioning_date,
    room_id
) VALUES (
    TO_DATE('2014/05/04 00:00:00','yyyy/mm/dd hh24:mi:ss'),
    102
);

INSERT INTO reconditioning (
    reconditioning_date,
    room_id
) VALUES (
    TO_DATE('2014/05/05 00:00:00','yyyy/mm/dd hh24:mi:ss'),
    103
);

--drop table RECONDITIONING;
--drop table DESKS;
--drop table CHAIRS;
--drop table CLASSROOM;

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO mykhaylenko;
GRANT INSERT ANY TABLE TO mykhaylenko;
GRANT ALTER ANY TABLE TO mykhaylenko;
GRANT SELECT ANY TABLE TO mykhaylenko;


/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(ORDERS.cust_id)
FROM Orders, Orderitems
 WHERE (
        ORDERS.order_num = ORDERITEMS.order_num AND
        ORDERITEMS.item_price = (
            SELECT MAX(item_price) 
            FROM ORDERITEMS   )



/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних електронних адрес зберігається в таблиці CUSTOMERS - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(DISTINCT(cust_email)) COUNT_EMAIL
FROM CUSTOMERS;



/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT (CUSTOMERS)
WHERE
       CUSTOMERS.cust_id not IN (
           PROJECT (ORDERS) 
              { DISTINCT(cust_id)}
        ) {TRIM(cust_name) || ' ' || TRIM(cust_email) "client_name"};

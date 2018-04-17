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

CREATE TABLE Classroom
( room_id number(3) NOT NULL, 
  room_size float NOT NULL,
  reconditioning_date date 
  ); 
CREATE TABLE Desk
( desk_id number(6) NOT NULL,
  desk_material varchar2(15),
  desk_size float,
  desk_date date,
  desk_color varchar2(7),
  room_id number (3) NOT NULL
  );
CREATE TABLE Chair
( chair_id number(6) NOT NULL,
  chair_material varchar2(15),
  chair_size float,
  chair_date date,
  chair_color varchar2(7),
  room_id number (3) NOT NULL,
  desk_id number(6)
  );

ALTER TABLE Classroom
ADD CONSTRAINT pk 
PRIMARY KEY (room_id);

ALTER TABLE Desk
ADD CONSTRAINT fk_desk
FOREIGN KEY (room_id)
REFERENCES Classroom (room_id);

ALTER TABLE Chair
ADD CONSTRAINT fk_chair
FOREIGN KEY (room_id)
REFERENCES Classroom (room_id);

  
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

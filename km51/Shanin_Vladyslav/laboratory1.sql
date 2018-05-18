-- LABORATORY WORK 1
-- BY Shanin_Vladyslav

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER shanin
  IDENTIFIED BY shanin
  DEFAULT TABLESPACE "USERS"
  TEMPORARY TABLESPACE "TEMP";
  
ALTER USER shanin QUOTA 100M ON USERS;

GRANT "CONNECT" TO shanin; 
GRANT INSERT ANY TABLE TO shanin;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина танцює під музику.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE Person (
  person_name VARCHAR(50) NOT NULL
);

ALTER TABLE Person 
  ADD CONSTRAINT person_pk PRIMARY KEY (person_name);
  

CREATE TABLE Song (
  song_name VARCHAR(50) NOT NULL
);

ALTER TABLE Song 
  ADD CONSTRAINT song_pk PRIMARY KEY (song_name);
  

CREATE TABLE Dance (
  person_name_fk VARCHAR(50) NOT NULL,
  song_name_fk VARCHAR(50) NOT NULL
);

ALTER TABLE Dance 
  ADD CONSTRAINT dance_pk PRIMARY KEY (person_name_fk, song_name_fk);
  
ALTER TABLE Dance 
  ADD CONSTRAINT person_fk FOREIGN KEY (person_name_fk) 
    REFERENCES Person (person_name);

ALTER TABLE Dance 
  ADD CONSTRAINT song_fk FOREIGN KEY (song_name_fk) 
    REFERENCES Song (song_name);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO shanin;
GRANT SELECT ANY TABLE TO shanin;
GRANT INSERT ANY TABLE TO shanin;
GRANT ALTER ANY TABLE TO shanin;

/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдорожчого товару?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT Products.PROD_NAME
  FROM 
    OrderItems, Products
  WHERE 
    OrderItems.ITEM_PRICE = (SELECT MAX(ITEM_PRICE) FROM OrderItems)
    AND
    OrderItems.PROD_ID = Products.PROD_ID;
    
PROJECT 
  (OrderItems TIMES Products 
    WHERE (OrderItems.ITEM_PRICE = (PROJECT (OrderItems) {MAX(ITEM_PRICE)}) AND OrderItems.PROD_ID = Products.PROD_ID)
  ) {Products.PROD_NAME};
  
/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найкоротшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT MIN(TRIM(cust_name)) AS long_name
  FROM Customers;

/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, 
що не мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT Customers.CUST_NAME || ' ' || Customers.CUST_EMAIL AS client_name
  FROM 
    Customers
  WHERE
    Customers.CUST_ID NOT IN (SELECT CUST_ID FROM Orders);

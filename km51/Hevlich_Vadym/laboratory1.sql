-- LABORATORY WORK 1
-- BY Hevlich_Vadym


/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти дані.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER hevlich IDENTIFIED BY hevlich 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER hevlich QUOTA 50M ON USERS;

GRANT "CONNECT" TO hevlich;

GRANT DELETE ANY TABLE TO hevlich;
GRANT ALTER ANY TABLE TO hevlich;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Турист забронював готель. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE Tourist (
    tourist_id INT NOT NULL,
    tourist_name CHAR(30) NOT NULL,
    tourist_last_name CHAR(30) NOT NULL,
    hotel_id INT
);

CREATE TABLE Hotel (
    hotel_id INT NOT NULL,
    hotel_name CHAR(30) NOT NULL
);

ALTER TABLE  Tourist
    ADD CONSTRAINT tourist_pk PRIMARY KEY tourist_id;
    
ALTER TABLE  Hotel
    ADD CONSTRAINT hotel_pk PRIMARY KEY hotel_id;

ALTER TABLE  Tourist
  ADD CONSTRAINT hotel_fk FOREIGN KEY (hotel_id) REFERENCES Hotel (hotel_id);

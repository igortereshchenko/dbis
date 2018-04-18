-- LABORATORY WORK 1
-- BY Mironchenko_Valerii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER mironchenko IDENTIFIED BY mironchenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER mironchenko QUOTA 100M ON USERS;

GRANT "CONNECT" TO mironchenko;

GRANT CREATE ANY TABLE TO mironchenko;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE HUMAN(
  human_name VARCHAR2(35) NOT NULL
);
ALTER TABLE HUMAN
  ADD CONSTRAINT human_prk PRIMARY KEY (human_name);
-------------------------------------------------------

CREATE TABLE ACTION(
  action_name VARCHAR2(15) NOT NULL
);
ALTER TABLE  ACTION
  ADD CONSTRAINT action_prk PRIMARY KEY (human_name);  

-------------------------------------------------------
CREATE TABLE SONG_NAME(
  song_name_fk VARCHAR2(30) NOT NULL,
);

ALTER TABLE  SONG_NAME
  ADD CONSTRAINT song_prk PRIMARY KEY (human_name_fk, song_name_fk);  
  
ALTER TABLE  SONG_NAME
  ADD CONSTRAINT song_fk FOREIGN KEY (human_name_fk) REFERENCES HUMAN (human_name);
  
ALTER TABLE  SONG_NAME
  ADD CONSTRAINT song_fk FOREIGN KEY (human_name_fk) REFERENCES SONG (song_name);
  
  
/* —-------------------------------------------------------------------------
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць,
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT.
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити:
—-------------------------------------------------------------------------*/
—Код відповідь:

GRANT INSERT ANY TABLE mironchenko
GRANT SELECT ANY TABLE mironchenko
/---------------------------------------------------------------------------
3.a.
Скільки проданого найдорожчого товару?
Виконати завдання в SQL.
4 бали
—-------------------------------------------------------------------------/
—Код відповідь:

SELECT SUM(ORDERITEMS.QUANTITY) 
FROM ORDERITEMS
WHERE ORDERITEMS.ITEM_PRICE IN (
                                 SELECT MAX(ORDERITEMS.ITEM_PRICE)
                                 FROM ORDERITEMS
                               );
/---------------------------------------------------------------------------
3.b.
Який PROD_ID товару, з найкоротшою назвою?
Виконати завдання в SQL.
4 бали
—-------------------------------------------------------------------------/
—Код відповідь:

SELECT PRODUCTS.PROD_ID    
FROM PRODUCTS
WHERE LENGTH(TRIM(PRODUCTS.PROD_NAME)) IN (
                                             SELECT MIN(LENGTH(TRIM(PRODUCTS.PROD_NAME)))
                                             FROM PRODUCTS
                                          );
/---------------------------------------------------------------------------
c.
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда.
4 бали
—-------------------------------------------------------------------------/
—Код відповідь:

A = PROJECT (
             VENDORS TIMES PRODUCTS 
             WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID
            ) {vend_name}

B = PROJECT (VENDORS) {vend_name}

Answer = PROJECT (B MINUS A) {UPPER(RENAME(vend_name, "vendor_name"))}

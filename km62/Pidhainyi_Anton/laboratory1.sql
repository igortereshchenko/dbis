-- LABORATORY WORK 1
-- BY Pidhainyi_Anton
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER pidgayny IDENTIFIED BY 1111
  DEFAULT TABLESPACE "USERS"
  TEMPORARY TABLESPACE "TEMP";
  
ALTER USER pidgayny QUOTA 100M ON USERS;

GRANT CONNECT TO pidgayny;
GRANT SELECT ANY TABLE TO pidgayny;



/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE COMPUTERS(
    COMP_NAME varchar(20),
    COMP_ID varchar(3) not null
)

CREATE TABLE HARDWARE(
    HARD_NAME varchar(20),
    HARD_ID varchar(3) not null
)

CREATE TABLE SOFTWARE(
    SOFT_NAME varchar(20),
    SOFT_ID varchar(3) not null
)

CREATE TABLE COMP_HAS_HARDWARE(
    COMP_ID varchar(3) not null,
    HARD_ID varchar(3) not null
)

CREATE TABLE COMP_HAS_SOFTWARE(
    COMP_ID varchar(3) not null,
    SOFT_ID varchar(3) not null
)

ALTER TABLE COMPUTERS ADD CONSTRAINT COMPUTER_PK PRIMARY KEY (COMP_ID);
ALTER TABLE HARDWARE ADD CONSTRAINT HARDWARE_PK PRIMARY KEY (HARD_ID);
ALTER TABLE SOFTWARE ADD CONSTRAINT SOFTWARE_PK PRIMARY KEY (SOFT_ID);

ALTER TABLE COMP_HAS_HARDWARE ADD CONSTRAINT COMP_HAS_HARDWARE_PK PRIMARY KEY (COMP_ID , HARD_ID);
ALTER TABLE COMP_HAS_SOFTWARE ADD CONSTRAINT COMP_HAS_SOFTWARE_PK PRIMARY KEY (COMP_ID , SOFT_ID);
ALTER TABLE COMP_HAS_HARDWARE ADD CONSTRAINT HARDWARE_FK FOREIGN KEY (HARD_ID) REFERENCES HARDWARE(HARD_ID);
ALTER TABLE COMP_HAS_SOFTWARE ADD CONSTRAINT SOFTWARE_FK FOREIGN KEY (SOFT_ID) REFERENCES SOFTWARE(SOFT_ID);

ALTER TABLE COMPUTERS ADD CONSTRAINT COMP_CHECK CHECK (REGEXP_LIKE(COMP_ID,'^[A-Z]\d\d'));
ALTER TABLE HARDWARE ADD CONSTRAINT HARD_CHECK CHECK (REGEXP_LIKE(HARD_ID,'^[A-Z]\d\d'));
ALTER TABLE SOFTWARE ADD CONSTRAINT SOFT_CHECK CHECK (REGEXP_LIKE(SOFT_ID,'^[A_Z]\d\d'));

INSERT INTO COMPUTERS(COMP_NAME,COMP_ID) VALUES ('Asus x550','A01');
INSERT INTO COMPUTERS(COMP_NAME,COMP_ID) VALUES ('Comp1','A02');
INSERT INTO COMPUTERS(COMP_NAME,COMP_ID) VALUES ('Aser 1321','B64');
INSERT INTO COMPUTERS(COMP_NAME,COMP_ID) VALUES ('Dell 5500','C06');

INSERT INTO SOFTWARE(SOFT_NAME,SOFT_ID) VALUES ('Oracle SQL Developer','Z01');
INSERT INTO SOFTWARE(SOFT_NAME,SOFT_ID) VALUES ('Mozilla Firefox','Z02');
INSERT INTO SOFTWARE(SOFT_NAME,SOFT_ID) VALUES ('Telegram','Z03');
INSERT INTO SOFTWARE(SOFT_NAME,SOFT_ID) VALUES ('VLC media player','Z04');

INSERT INTO HARDWARE(HARD_NAME,HARD_ID) VALUES ('WEB Camera','H01');
INSERT INTO HARDWARE(HARD_NAME,HARD_ID) VALUES ('GPU NVIDIA GTX950','H02');
INSERT INTO HARDWARE(HARD_NAME,HARD_ID) VALUES ('CPU Intel Core i7','H03');
INSERT INTO HARDWARE(HARD_NAME,HARD_ID) VALUES ('CPU Intel Core 2 Duo','H04');

INSERT INTO COMP_HAS_HARDWARE(COMP_ID,HARD_ID) VALUES ('A01','H01');
INSERT INTO COMP_HAS_HARDWARE(COMP_ID,HARD_ID) VALUES ('A01','H02');
INSERT INTO COMP_HAS_HARDWARE(COMP_ID,HARD_ID) VALUES ('A01','H03');
INSERT INTO COMP_HAS_HARDWARE(COMP_ID,HARD_ID) VALUES ('C06','H04');

INSERT INTO COMP_HAS_SOFTWARE(COMP_ID,SOFT_ID) VALUES ('A01','Z01');
INSERT INTO COMP_HAS_SOFTWARE(COMP_ID,SOFT_ID) VALUES ('A01','Z02');
INSERT INTO COMP_HAS_SOFTWARE(COMP_ID,SOFT_ID) VALUES ('A01','Z03');



  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO pidgayny;
GRANT INSERT ANY TABLE TO pidgayny;
GRANT SELECT ANY TABLE TO pidgayny;




/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT ORDER_NUM FROM ORDERITEMS WHERE ITEM_PRICE IN (SELECT max(ORDERITEMS.ITEM_PRICE) FROM ORDERITEMS);













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT count(CUST_NAME) AS "count_name" FROM (SELECT DISTINCT CUST_NAME FROM CUSTOMERS);














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
lower(VEND_NAME) as "vendor_name" PROJECT (vendors TIMES products TIMES orderitems) WHERE 
(vendors.VEND_ID=products.VEND_ID AND (products.PROD_ID NOT IN (PROD_ID PROJECT orderitems);





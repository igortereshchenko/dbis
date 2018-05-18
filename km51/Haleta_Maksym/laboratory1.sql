-- LABORATORY WORK 1
-- BY Haleta_Maksym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER galeta IDENTIFIED BY galeta
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER galeta QUOTA 100M ON USERS;

GRANT "CONNECT" TO galeta;
GRANT SELECT ANY TABLE TO galeta;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE Hardware (
    part VARCHAR2(20) NOT NULL,
    part_name  VARCHAR2(30) NOT NULL,
    model_  VARCHAR2(30),
    type_ VARCHAR2(30)
    );

CREATE TABLE Software (
    programs VARCHAR2(30) NOT NULL,
    img  VARCHAR2(30),
    size_  NUMBER(10,2),
    name_ VARCHAR2(30) NOT NULL
    );
  
CREATE TABLE Computer (
    part_fk VARCHAR2(20) NOT NULL,
    programs_fk VARCHAR2(30) NOT NULL,
    name_ VARCHAR2(30),
    color VARCHAR2(10)
    );
 
CREATE TABLE Programmer (
  programmer_id INTEGER NOT NULL,
  name_ VARCHAR2(30) NOT NULL
  );

ALTER TABLE Hardware ADD CONSTRAINT part_pk PRIMARY KEY (part);
ALTER TABLE Software ADD CONSTRAINT programs_pk PRIMARY KEY (programs);
ALTER TABLE Computer ADD CONSTRAINT pk PRIMARY KEY (part_fk, programs_fk);
ALTER TABLE Computer ADD CONSTRAINT fk1 FOREIGN KEY (part_fk) REFERENCES Hardware(part);
ALTER TABLE Computer ADD CONSTRAINT fk2 FOREIGN KEY (programs_fk) REFERENCES Software(programs);
ALTER TABLE Programmer ADD CONSTRAINT id_pk PRIMARY KEY (id);

INSERT INTO Hardware (part, part_name, model_, type_)
VALUES('processor', 'Intel', 'model_1', 'type_1');
INSERT INTO Hardware (part, part_name, model_, type_)
VALUES('motherboard', 'jsnh_2', 'model_2', 'type_2');
INSERT INTO Hardware (part, part_name, model_, type_)
VALUES('keyboard', 'sdki_3', 'model_3', 'type_3');

INSERT INTO Software (programs, img, size_, name_)
VALUES('program_1', 'img_1', 20, 'name_1');
INSERT INTO Software (programs, img, size_, name_)
VALUES('program_2', 'img_2', 30, 'name_2');
INSERT INTO Software (programs, img, size_, name_)
VALUES('program_3', 'img_3', 100, 'name_3');

INSERT INTO Computer(part_fk, programs_fk, name_, color)
VALUES('processor', 'program_1', 'HP', 'black');
INSERT INTO Computer(part_fk, programs_fk, name_, color)
VALUES('motherboard', 'program_2', 'Dell', 'red');
INSERT INTO Computer(part_fk, programs_fk, name_, color)
VALUES('processor', 'program_3', 'Dell', 'black');

INSERT INTO Programmer(programmer_id, name_)
VALUES(1, 'David');
INSERT INTO Programmer(programmer_id, name_)
VALUES(2, 'John');
INSERT INTO Programmer(programmer_id, name_)
VALUES(3, 'Max');


  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO galeta;
GRANT INSERT ANY TABLE TO galeta;




/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT DISTINCT ORDER_ITEM
FROM ORDERITEMS
WHERE ITEM_PRICE IN(
  SELECT MAX(ITEM_PRICE)
  FROM ORDERITEMS);
PROJECT(ORDERITEMS WHERE ITEM_PRICE IN 
        (
        PROJECT(ORDERITEMS)
            {MAX(ITEM_PRICE)}
     )
{DISTINCT ORDER_ITEM}









/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT COUNT(DISTINCT CUST_NAME) AS count_name
FROM CUSTOMERS;
PROJECT(CUSTOMERS){RENAME COUNT(DISTINCT CUST_NAME) AS count_name}













/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT distinct LOWER( vend_name) AS "vendor_name"
FROM Vendors,ORDERITEMS,PRODUCTS
WHERE VENDORS.vend_id=PRODUCTS.vend_id
minus
SELECT distinct LOWER( vend_name) AS "vendor_name"
FROM Vendors,ORDERITEMS,PRODUCTS
WHERE ORDERITEMS.prod_id=PRODUCTS.prod_id
and
VENDORS.vend_id=PRODUCTS.vend_id;

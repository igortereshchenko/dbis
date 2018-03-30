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
  part VARCHAR2(20) NOT NULL);
CREATE TABLE Software (
  programs VARCHAR2(30) NOT NULL);
CREATE TABLE Computer (
  part_fk VARCHAR2(20) NOT NULL,
  programs_fk VARCHAR2(30) NOT NULL,
  name VARCHAR2(30));

ALTER TABLE Hardware ADD CONSTRAINT part_pk PRIMARY KEY (part);
ALTER TABLE Software ADD CONSTRAINT programs_pk PRIMARY KEY (programs);
ALTER TABLE Computer ADD CONSTRAINT pk PRIMARY KEY (part_fk, programs_fk);
ALTER TABLE Computer ADD CONSTRAINT fk1 FOREIGN KEY (part_fk) REFERENCES Hardware(part);
ALTER TABLE Computer ADD CONSTRAINT fk2 FOREIGN KEY (programs_fk) REFERENCES Software(programs);




  
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


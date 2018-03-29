-- LABORATORY WORK 1
-- BY Tyshkevych_Nikyta
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER TYSHKEVYCH IDENTIFIED BY  tyshkevych
DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";
ALTER USER TYSHKEVYCH QUOTA 100M ON USERS;

GRANT SELECT ANY TABLE TO TYSHKEVYCH;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:




CREATE TABLE COMPUTER1 (
  computer_id INT,
  computer_name VARCHAR(30)
)

ALTER TABLE COMPUTER1 ADD CONSTRAINT comp_pk1 PRIMARY KEY  (computer_id);

CREATE TABLE HARDWARE1 (
  hard_id INT,
  cpu_name VARCHAR(30),
  power_name VARCHAR(30)
);

ALTER TABLE HARDWARE1 ADD CONSTRAINT hard_pk1 PRIMARY KEY  (hard_id);

CREATE TABLE SOFTWARE1 (
  soft_id INT,
  program_name VARCHAR(30)
);

ALTER TABLE SOFTWARE1 ADD CONSTRAINT soft_pk1 PRIMARY KEY  (soft_id);

ALTER TABLE HARDWARE1 ADD CONSTRAINT hard_fk FOREIGN KEY (hard_id) REFERENCES COMPUTER1(computer_id);

ALTER TABLE SOFTWARE1 ADD CONSTRAINT soft_fk FOREIGN KEY (soft_id) REFERENCES COMPUTER1(computer_id);









  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO TYSHKEVYCH;
GRANT INSERT ANY TABLE TO TYSHKEVYSH;






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


SELECT COUNT(CUST_NAME) AS count_name
FROM (SELECT DISTINCT CUST_NAME FROM CUSTOMERS)












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



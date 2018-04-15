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
CREATE TABLE hardware(
  procc_id number(2,0) NOT NULL,
  power_block_id number(2,0) NOT NULL,
  procc_name varchar2(20),  
  power_block_name varchar2(20)
  );
  
ALTER TABLE harware ADD CONSTRAINT procc_pk PRIMARY KEY (procc_id); 
ALTER TABLE harware ADD CONSTRAINT power_pk PRIMARY KEY (power_block_id);

CREATE TABLE software(
  os_id varchar(2) NOT NULL,    
  os_name varchar2(20)  
  );

ALTER TABLE software ADD CONSTRAINT os_pk PRIMARY KEY (os_id);

CREATE TABLE computer(
  comp_id varchar2(20)

  );
  
ALTER TABLE computer ADD CONSTRAINT procc_fk FOREIGN KEY REFERENCES hardware(procc_id);
ALTER TABLE computer ADD CONSTRAINT power_fk FOREIGN KEY REFERENCES hardware(power_block_id);
ALTER TABLE computer ADD CONSTRAINT os_fk FOREIGN KEY REFERENCES software(os_id);
  
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
SELECT ORDER_NUM FROM 
  SELECT * FROM ORDERITEMS WHERE ITEM_PRICE=MAX(ITEM_PRICE);













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
count_name=COUNT(SELECT CUST_NAME FROM CUSTOMERS);














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
vendor_name=PROJECT(LOWER(VEND_NAME) VENDORS COND )





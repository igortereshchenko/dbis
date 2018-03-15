-- LABORATORY WORK 1
-- BY Popravko_Oleksii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER popravko IDENTIFIED BY popravko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER popravko GRANT ROLE "SELECT";
   
GRANT QUOTA 10M TO popravko;
GRANT SELECT ALL TABLES TO popravko;







/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE HARDWARE(
    detail varchar2(30) NOT NULL
    );
ALTER TABLE HARDWARE
    ADD CONSTRAINT detail_pk PRIMARY KEY (detail);
CREATE TABLE SOFTWARE(
    program_name varchar2(30) NOT NULL
    );
ALTER TABLE SOFTWARE
    ADD CONSTRAINT program_pk PRIMARY KEY (program_name);
CREATE TABLE COMPUTER(
    detail_on varchar2(30) NOT NULL,
    program_on varchar2(30) NOT NULL,
    part_price number(6,2) NOT NULL
    );
ALTER TABLE COMPUTER
    ADD CONSTRAINT detail_on_pk PRIMARY KEY (detail_on);
ALTER TABLE COMPUTER
    ADD CONSTRAINT program_on_pk PRIMARY KEY (program_on);
ALTER TABLE COMPUTER
    ADD CONSTRAINT part_price_fk FOREIGN KEY (part_price) REFERENCES TO HARDWARE(detail_pk);













  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLES TO popravko;
GRANT INSERT ANY TABLES TO popravko;
GRANT SELECT ANY TABLES TO popravko;





/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_ID
WHERE MAX(ITEM_PRICE); 













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT  CUST_NAME as count_name
where CUS tNAME is distinct;
    














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

project vendors rename vendors name;

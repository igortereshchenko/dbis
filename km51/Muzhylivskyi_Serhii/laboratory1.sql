-- LABORATORY WORK 1
-- BY Muzhylivskyi_Serhii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER muzhylivskyi IDENTIFIED BY muzhylivskyi
    DEFAULT TABLESPACE "USERS"
    TEMPORARY TABLESPACE "TEMP";

ALTER USER MUZHYLIVSKYI QUOTA 100M ON USERS;

GRANT "CONNECT" TO MUZHYLIVSKYI;










/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE HARDWARE(
    PROCESSOR VARCHAR2(30 CHAR) NOT NULL
    
);

CREATE TABLE SOFTWARE(
    OS VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE HARDWARE
    ADD CONSTRAINT hardware_pk PRIMARY KEY(PROCESSOR);

ALTER TABLE SOFTWARE
    ADD CONSTRAINT software_pk PRIMARY KEY(OS);

CREATE TABLE hardware_software(
    hardware_software_ID NUMBER NOT NULL,
    processor VARCHAR2(30 CHAR) NOT NULL,
    OS VARCHAR2(30 CHAR)
);
ALTER TABLE hardware_software
    ADD CONSTRAINT hardware_software_PK PRIMARY KEY(hardware_software_ID);

ALTER TABLE hardware_software
    ADD CONSTRAINT hardware_software_fk FOREIGN KEY(PROCESSOR) REFERENCES HARDWARE(PROCESSOR);














  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT INSERT ANY TABLE TO muzhylivskyi;
GRANT CREATE ANY TABLE TO muzhylivskyi;
GRANT SELECT ANY TABLE TO muzhylivskyi;
GRANT ALTER ANY TABLE TO muzhylivskyi;




    
/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT ORDER_NUM FROM ORDERITEMS WHERE(SELECT MAX(ITEM_PRice)); 













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


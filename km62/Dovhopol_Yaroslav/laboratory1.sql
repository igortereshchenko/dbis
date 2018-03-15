-- LABORATORY WORK 1
-- BY Dovhopol_Yaroslav

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER DOVGOPOL IDENTIFIED  BY DOVGOPOL;
DEFAULT TABLESPACE "SYSTEM";
TEMPORARY TABLESPACE "TEMP";
GRANT "CONNECT" to DOVGOPOL;
ALTER USER "DOVGOPOL" QUOTA 300M ON USERS
GRANT SELECT ANY TABLE TO DOVGOPOL;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE computer(
comp_name VARCHAR2(15) NOT NULL,
);

CREATE TABLE hardware(
comp_name_fk VARCHAR2(15) NOT NULL,
core VARCHAR(30) NOT NULL,
powerblock VARCHAR(20) NOT NULL
);

CREATE TABLE software(
comp_name_fk VARCHAR2(15) NOT NULL,
software_name VARCHAR2(25) NOT NULL
);
----------------------------------------------------
ALTER TABLE computer
ADD CONSTRAINT comp_pk PRIMARY KEY (comp_name);

ALTER TABLE hardware 
ADD CONSTRAINT hard_pk PRIMARY KEY (core, powerblock);

ALTER TABLE software
ADD CONSTRAINT soft_pk PRIMARY KEY(software_name);

-----------------------------------------------------

ALTER TABLE hardware
ADD CONSTRAINT hard_fk FOREIGN KEY (comp_name_fk) REFERENCES computer(comp_name);

ALTER TABLE software
ADD CONSTRAINT soft_fk FOREIGN KEY (comp_name_fk) REFERENCES computer(comp_name);

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE to DOVGOPOL;
GRANT UPDATE ANY TABLE to DOVGOPOL;
GRANT GRANT ANY TABLE to DOVGOPOL;
GRANT ALTER ANY TABLE to DOVGOPOL;

/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT ORDER_NUM
FROM ORDERS
WHERE 



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


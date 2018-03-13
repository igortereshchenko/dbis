-- LABORATORY WORK 1
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER lukianchenko
IDENTIFIED BY LUK
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
QUOTA 200M ON USERS;


GRANT connect TO lukianchenko;
GRANT SELECT ANY TABLE TO lukianchenko;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE computer(
comp_model char(30) not null
);
ALTER TABLE computer
ADD CONSTRAINT comp_pk PRIMARY KEY (comp_model);

CREATE TABLE hard(
hard_power CHAR(30) not null,
prossesor char(30) not null
);
ALTER TABLE hard
ADD CONSTRAINT hard_pk PRIMARY KEY (prossesor);

CREATE TABLE soft(
oper_system CHAR(30) not null
);
ALTER TABLE soft
ADD CONSTRAINT soft_pk PRIMARY KEY (oper_system);


CREATE TABLE comp_hard_soft(
comp_model char(30) not null,
hard_power CHAR(30) not null,
prossesor char(30) not null,
oper_system CHAR(30) not null
);
ALTER TABLE comp_hard_soft
ADD CONSTRAINT comp_hard_soft_pk PRIMARY KEY (comp_model, prossesor);

ALTER TABLE comp_hard_soft
ADD CONSTRAINT comp_fk FOREIGN KEY (comp_model) REFERENCES computer(comp_model) ;

ALTER TABLE comp_hard_soft
ADD CONSTRAINT hard_fk FOREIGN KEY ( prossesor) REFERENCES hard( prossesor) ;

ALTER TABLE comp_hard_soft
ADD CONSTRAINT soft_fk FOREIGN KEY ( oper_system) REFERENCES soft( oper_system) ;

















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO lukianchenko;
GRANT INSERT ANY TABLE TO lukianchenko;
GRANT SELECT ANY TABLE TO lukianchenko;





/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select count(DISTINCT cust_name) from customers;













/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:



-- BY Lukianchenko_Rehina

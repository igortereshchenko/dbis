-- LABORATORY WORK 1
-- BY Pits_Vadym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти таблиці та робити запити з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER pits IDENTIFIED BY pits;
DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";

ALTER USER QUOTA 100M ON "USERS";

GRANT DELETE ANY TABLE TO pits;
GRANT SELECT ANY TABLE TO pits;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На комп'ютері встановлено OS Windows.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE windows
{
version_of_windows VARCHAR2(5) NOT NULL
};
ALTER TABLE windows ADD CONSTRAINT windows_pk PRIMARY KEY (version_of_windows) ;


CREATE TABLE computer
{
computer_age NUMBER(4,0) NOT NULL
};
ALTER TABLE computer ADD CONSTRAINT computer_pk PRIMARY KEY (computer);


CREATE TABLE windows_on_computer
{
version_of_OSwindows VARCHAR2(5) NOT NULL,
age_of_computer NUMBER(4,0) NOT NULL,
age_of_user NUMBER(3,0)
};
ALTER TABLE windows_on_computer ADD CONSTRAINT windows_on_computer_fk FOREIGN KEY (windows,computer);
ALTER TABLE windows_on_computer ADD CONSTRAINT version_of_OSwindows PRIMARY KEY (windows_on_computer);
ALTER TABLE windows_on_computer ADD CONSTRAINT age_of_computer_pk PRIMARY KEY (windows_on_computer);

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO pits;
GRANT INSERT ANY TABLE TO pits;

/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що не купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:



/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що продають товар з найдовшим коментарем.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VENDORS as vendor_name

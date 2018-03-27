/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та видалення даних
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
Create user artem IDENTIFIED by usenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

GRANT CONNECT to artem;
GRANT SELECT any TABLE to artem;
GRANT DROP any TABLE to artem;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Програмісти програмують на мові C++
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE Programist
(
  programist_id VARCHAR(5) not null,
  programist_name VARCHAR(40) not null
);

CREATE TABLE Language
(
language_id varchar(5) not null,
language_name VARCHAR(40) not null
);

CREATE TABLE Programist_Language 
(
programist_language_id varchar(5) not null,
programist_id VARCHAR(5) not null,
language_id varchar(5) not null
);

Alter TABLE Programist ADD CONSTRAINT programist_pk PRIMARY KEY (programist_id);
Alter TABLE Language ADD CONSTRAINT language_pk PRIMARY KEY (language_id);
ALTER TABLE Programist_Language ADD CONSTRAINT programist_language_pk PRIMARY KEY (programist_language_id);
ALTER TABLE Programist_Language ADD CONSTRAINT programist_language_fk FOREIGN KEY (programist_id) REFERENCES Programist(programist_id);
ALTER TABLE Programist_Language ADD CONSTRAINT programist_language_fk FOREIGN KEY (language_id) REFERENCES Language(language_id);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE any TABLE to artem;
GRANT SELECT any TABLE to artem;
GRANT INSERT any TABLE to artem;
GRANT ALTER any TABLe to artem;

/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в Адгебрі кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT 
    OrderItems.order_num  
      FROM OrderItems 
          WHERE OrderItems.item_price = 
              (SELECT MAX(OrderItems.item_price ) FROM OrderItems);

/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен продавців - назвавши це поле name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT
   COUNT(DISTINCT TRIM(vend_name)) as name
FROM VENDORS;


/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його купляли.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
  (LOWER (Vendors.vend_name)) as vendor_name
  FROM Vendors 
  WHERE Vendors.vend_id  IN
  (SELECT 
     DISTINCT Products.vend_id    
    FROM Products
      Where  Products.prod_id IN 
      (
        SELECT 
          DISTINCT OrderItems.prod_id
         FROM OrderItems
      )
  );

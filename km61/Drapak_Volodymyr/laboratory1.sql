@@ -1,2 1,144 @@
 -- LABORATORY WORK 1
 -- BY Drapak_Volodymyr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Drapak
IDENTIFIED BY qwerty123456;

GRANT UPDATE ANY TABLE TO Drapak;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE Clients(
    First_name VARCHAR(30) NOT NULL,
    Last_name VARCHAR(30) NOT NULL
);

CREATE TABLE Films(
    Title VARCHAR(100) NOT NULL
);

CREATE TABLE Genres(
    Genre VARCHAR(50) NOT NULL
);

CREATE TABLE Countries(
    Country VARCHAR(50) NOT NULL
);

CREATE TABLE Film_genre(
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL
);

CREATE TABLE Film_country(
    Title VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

CREATE TABLE Seances(
    Film_title VARCHAR(100) NOT NULL,
    Client_first_name VARCHAR(30) NOT NULL,
    Client_last_name VARCHAR(30) NOT NULL,
    Seance_date DATE NOT NULL
);

ALTER TABLE Clients ADD
    (CONSTRAINT Name_pk PRIMARY KEY (First_name, Last_name),
    CONSTRAINT Name_check CHECK (REGEXP_LIKE(First_name, '[A-Za-z]+') AND
                                REGEXP_LIKE(Last_name, '[A-Za-z]+')));
    
ALTER TABLE Films ADD
    (CONSTRAINT Films_pk PRIMARY KEY (Title),
    CONSTRAINT Title_check CHECK(REGEXP_LIKE(Title, '[A-Za-z\s]+')));
    
ALTER TABLE Genres ADD
    (CONSTRAINT Genres_pk PRIMARY KEY (Genre),
    CONSTRAINT Genre_check CHECK(REGEXP_LIKE(Genre, '[A-Za-z\s]+')));
    
ALTER TABLE Countries ADD
    (CONSTRAINT Countries_pk PRIMARY KEY (Country),
    CONSTRAINT Country_check CHECK(REGEXP_LIKE(Country, '[A-Za-z\s]+')));

ALTER TABLE Film_genre ADD
    (CONSTRAINT Film_genre_pk PRIMARY KEY (Title, Genre),
    CONSTRAINT Film_genre_title_fk FOREIGN KEY (Title) REFERENCES Films(Title),
    CONSTRAINT Genre_fk FOREIGN KEY (Genre) REFERENCES Genres(Genre));

ALTER TABLE Film_country ADD
    (CONSTRAINT Film_country_pk PRIMARY KEY (Title, Country),
    CONSTRAINT Film_country_title_fk FOREIGN KEY (Title) REFERENCES Films(Title),
    CONSTRAINT Country_fk FOREIGN KEY (Country) REFERENCES Countries(Country));

ALTER TABLE Seances ADD 
    (CONSTRAINT Seance_pk PRIMARY KEY (Seance_date, Film_title, Client_first_name, Client_last_name),
    CONSTRAINT Date_check CHECK(EXTRACT(YEAR FROM Seance_date) BETWEEN 1900 AND 2017),
    CONSTRAINT Film_title_fk FOREIGN KEY (Film_title) REFERENCES Films(Title),
    CONSTRAINT Client_name_fk FOREIGN KEY (Client_first_name, Client_last_name) REFERENCES Clients(First_name, Last_name));
    
INSERT ALL
    INTO Clients VALUES('Lexa', 'Subotin')
    INTO Clients VALUES('Gendalf', 'White')
    INTO Clients VALUES('Steve', 'Works')
SELECT * FROM DUAL;

INSERT ALL
    INTO Films VALUES('Gde Lexa?')
    INTO Films VALUES('The Lord Of The Rings')
    INTO Films VALUES('Jobs')
SELECT * FROM DUAL;

INSERT ALL
    INTO Genres VALUES('Drama')
    INTO Genres VALUES('Thriller')
    INTO Genres VALUES('Biography')
SELECT * FROM DUAL;

INSERT ALL
    INTO Countries VALUES('Russia')
    INTO Countries VALUES('USA')
    INTO Countries VALUES('New Zeeland')
SELECT * FROM DUAL;

INSERT ALL
    INTO Film_genre VALUES('Gde Lexa?', 'Drama')
    INTO Film_genre VALUES('The Lord Of The Rings', 'Drama')
    INTO Film_genre VALUES('Jobs', 'Biography')
SELECT * FROM DUAL;

INSERT ALL
    INTO Film_country VALUES('Gde Lexa?', 'Russia')
    INTO Film_country VALUES('The Lord Of The Rings', 'New Zeeland')
    INTO Film_country VALUES('Jobs', 'USA')
SELECT * FROM DUAL;

INSERT ALL
    INTO Seances VALUES('Gde Lexa?', 'Lexa', 'Subotin', '12-12-2017')
    INTO Seances VALUES('The Lord Of The Rings', 'Gendalf', 'White', '20-12-1999')
    INTO Seances VALUES('Jobs', 'Steve', 'Works', '31-01-2015')
SELECT * FROM DUAL;

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO Drapak;
GRANT INSERT ANY TABLE TO Drapak;
GRANT SELECT ANY TABLE TO Drapak;


/*---------------------------------------------------------------------------
3.a.
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(DISTINCT CUSTOMERS.CUST_ID)
FROM CUSTOMERS, ORDERS, ORDERITEMS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID AND
    ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM AND
    ORDERITEMS.ITEM_PRICE = (
        SELECT MIN(ITEM_PRICE)
        FROM ORDERITEMS
    );

/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT VEND_COUNTRY
FROM VENDORS
WHERE LENGTH(TRIM(VEND_COUNTRY)) = (
    SELECT MAX(VEND_COUNTRY_LENGTH)
    FROM (
        SELECT LENGTH(TRIM(VEND_COUNTRY)) AS VEND_COUNTRY_LENGTH
        FROM VENDORS
    )
);

/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

RENAME(
    PROJECT(CUSTOMERS){CUST_COUNTRY||''||CUST_NAME} WHERE CUST_ID IN(
        PROJECT(ORDERS){CUST_ID} WHERE ORDER_NUM IS NOT NULL
    )
){CUST_COUNTRY||''||CUST_NAME / client_name}

--(

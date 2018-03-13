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

ALTER USER Drapak
    GRANT ALTER ANY TABLE TO Drapak;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE Human(
    Name VARCHAR(30) NOT NULL,
    Age NUMBER(3, 3) NOT NULL
)

CREATE TABLE Film(
    Name VARCHAR(100) NOT NULL,
    Human_name_fk VARCHAR(100) NOT NULL,
    Genre VARCHAR(20) NOT NULL
)

ALTER TABLE Human
    ADD CONSTRAINT Human_name_pk PRIMARY KEY(Name);
    
ALTER TABLE Film
    ADD CONSTRAINT Film_name_pk PRIMARY KEY(Name);
    
ALTER TABLE Human
    ADD CONSTRAINT Human_watching_name_fk FOREIGN KEY(Human_name_fk) REFERENCES TO Human(Name);
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

ALTER USER Drapak
    GRANT CREATE ANY TABLE TO Drapak;
    GRANT INSERT INTO ANY TABLE TO Drapak;
    GRANT SELECT ANY TABLE TO Drapak;



/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

COUNT(
    
    SELECT CUST_ID
    FROM ORDERS
    WHERE ORDER_NUM IS IN(
        SELECT * FROM ORDERITEMS
        WHERE ITEM_PRICE = MIN(ITEM_PRICE)
    )
        
)




/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT VEND_COUNTRY
FROM VENDORS
WHERE LENGTH(VEND_COUNTRY) IS IN(
    SELECT MAX(LENGTH(VEND_COUNTRY))
    FROM VENDORS
)













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT CUST_COUNTRY||' '||CUST_NAME AS client_name
FROM CUSTOMERS
WHERE CUST_ID IS IN(

    SELECT CUST_ID
    FROM ORDERS
    WHERE ORDER_NUM IS NOT NULL

)

--Agebra of Kodd

PROJECT RENAME(CONCAT(CONCAT(CUST_COUNTRY, ' '), CUST_NAME)) AS client_name
    FROM CUTOMERS
    WHERE CUST_ID IS IN(
    
        PROJECT CUST_ID
        FROM ORDERS
        WHERE ORDER_NUM IS NOT NULL
    
    )

--(

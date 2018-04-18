-- LABORATORY WORK 1
-- BY Moroziuk_Yevhenii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER student IDENTIFIED BY student 
DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";

ALTER USER student QUOTA 100M ON USERS;

GRANT DROP ANY TABLE TO student;
GRANT INSERT ANY TABLE TO student;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE mobile ( 
        mobile_brand            VARCHAR2(12) NOT NULL,  
        mobile_camera           NUMBER(2) NOT NULL, 
        mobile_processor        VARCHAR(200) NOT NULL, 
        CONSTRAINT mobile_phone_pk PRIMARY KEY ( mobile_brand) 
    ); 
   
    ALTER TABLE mobile 
        ADD CONSTRAINT mobile_price_ch CHECK ( length(mobile_brand) >= 3 ); 
         
     
    CREATE TABLE Human (
        human_id   NUMBER(8) NOT NULL, 
        human_name VARCHAR(24) NOT NULL, 
        birth      DATE,  
        CONSTRAINT human_id_pk PRIMARY KEY ( human_id ) 
    ); 

    ALTER TABLE human 
        ADD CONSTRAINT human_name_ch CHECK ( length(human_name) >= 2 ); 

     
    CREATE TABLE Humans_phone ( 
        human_id_fk          NUMBER(8) NOT NULL, 
        mobile_brand_fk      VARCHAR2(12) NOT NULL  
    ); 
     
    ALTER TABLE Humans_phone 
        ADD CONSTRAINT human_with_mobile_pk PRIMARY KEY ( human_id_fk, 
        mobile_brand_fk ); 
     
    ALTER TABLE Humans_phone 
        ADD CONSTRAINT mobile_fk FOREIGN KEY ( mobile_brand_fk ) 
            REFERENCES mobile ( mobile_brand ); 
     
    ALTER TABLE Humans_phone 
        ADD CONSTRAINT human_fk FOREIGN KEY ( human_id_number_fk ) 
            REFERENCES human ( human_id_number ); 
          
     
    CREATE TABLE shop ( 
        mobile_phone_fk VARCHAR2(14) NOT NULL,
        mobile_price    NUMBER(5) NOT NULL,  
        packages_p      NUMBER(4) NOT NULL,  
        accessories_p   NUMBER(4) NOT NULL 
    ); 
     
    ALTER TABLE shop 
        ADD CONSTRAINT mobile_from_shop_pk PRIMARY KEY ( mobile_phone_fk, 
        mobile_price ); 
     
    ALTER TABLE shop 
        ADD CONSTRAINT mob_phone_fk FOREIGN KEY ( mobile_phone_fk ) 
            REFERENCES mobile ( mobile_brand ); 
        
 
    
    INSERT INTO mobile ( 
        mobile_brand,              
        mobile_camera,            
        mobile_processor  
    ) VALUES ( 
        'iPhone 8', 
        12, 
        'A11 bionic'
        ); 
     
      INSERT INTO mobile ( 
        mobile_brand,              
        mobile_camera,            
        mobile_processor  
    ) VALUES ( 
        'SG S7', 
        12, 
        'Exynos 8'
        ); 
        
    INSERT INTO mobile ( 
        mobile_brand,              
        mobile_camera,            
        mobile_processor  
    ) VALUES ( 
        'Mi Mix 2s', 
        12, 
        'SD 845'
        ); 
    
     INSERT INTO human ( 
        human_id, 
        human_name, 
        birth  
    ) VALUES ( 
        777777, 
        'Yevhenii', 
        TO_DATE('1999-03-10','YYYY-MM-DD') 
    ); 
    
    INSERT INTO human ( 
        human_id, 
        human_name, 
        birth  
    ) VALUES ( 
        888888, 
        'Yevhenii8', 
        TO_DATE('1999-03-10','YYYY-MM-DD') 
    );
    
    INSERT INTO human ( 
        human_id, 
        human_name, 
        birth  
    ) VALUES ( 
        999999, 
        'Yevhenii9', 
        TO_DATE('1999-03-10','YYYY-MM-DD') 
    );
    
    
    INSERT INTO Humans_phone ( 
        human_id_fk, 
        mobile_brand_fk
    ) VALUES ( 
        777777, 
        'iPhone 8' 
    ); 
     
    INSERT INTO Humans_phone ( 
        human_id_fk, 
        mobile_brand_fk
    ) VALUES ( 
        888888, 
        'SG S7' 
    );
    
    INSERT INTO Humans_phone ( 
        human_id_fk, 
        mobile_brand_fk
    ) VALUES ( 
        999999, 
        'Mi Mix 2s' 
    );  
     
    INSERT INTO mobile_shop ( 
        mobile_phone_fk,
        mobile_price,  
        packages_p,  
        accessories_p
    ) VALUES ( 
        'iPhone 8', 
        '25000', 
        999, 
        500 
    ); 
     
    INSERT INTO mobile_shop ( 
        mobile_phone_fk,
        mobile_price,  
        packages_p,  
        accessories_p
    ) VALUES ( 
        'SG S7', 
        '15000', 
        799, 
        600 
    );
    
    INSERT INTO mobile_shop ( 
        mobile_phone_fk,
        mobile_price,  
        packages_p,  
        accessories_p
    ) VALUES ( 
        'Mi Mix 2s', 
        '22000', 
        900, 
        600 
    );
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO student;
GRANT INSERT ANY TABLE TO student;
GRANT SELECT ANY TABLE TO student;




/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

(((Products WHERE prod_id NOT IN (Orderitems PROJECT prod_id))
 Project prod_id, prod_price) RENAME max(prod_price) -> max_price) Project max_price










/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT CUST_NAME as "Customer_name"
FROM CUSTOMERS, ORDERS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
AND ORDERS.ORDER_NUM IN (
  SELECT ORDERITEMS.ORDER_NUM
  FROM ORDERITEMS
  WHERE ORDERITEMS.ITEM_PRICE = (
    SELECT MAX(ORDERITEMS.ITEM_PRICE)
    FROM ORDERITEMS)
    







/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT TRIM(VEND_NAME)||' '||TRIM(VEND_COUNTRY) as "vendor_name"
FROM VENDORS, PRODUCTS

MINUS

(SELECT TRIM(VEND_NAME)||' '||TRIM(VEND_COUNTRY) as "vendor_name"
FROM VENDORS, PRODUCTS
WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID);





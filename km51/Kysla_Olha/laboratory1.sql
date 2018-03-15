-- LABORATORY WORK 1
-- BY Kysla_Olha
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER OLGAKYSLA IDENTIFIED BY pass
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE  "TEMP";

ALTER USER OLGAKYSLA QUOTA 100M ON USERS;


GRANT CONNECT TO OLGAKYSLA;
GRANT CREATE ANY TABLE TO OLGAKYSLA ;




/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE STUDENTS(
    student_id_code INTEGER,
    city VARCHAR(50)
);
ALTER TABLE STUDENTS ADD CONSTRAINT stud_pk PRIMARY KEY (student_id_code);
ALTER TABLE STUDENTS ADD CONSTRAINT city_pk PRIMARY KEY (city);

CREATE TABLE OPERATORS(
      Code_operator INTEGER,
      
);
ALTER TABLE PHONE ADD CONSTRAINT Code_operator_pk PRIMARY KEY (Code_operator);


CREATE TABLE PHONE(
     phone_tel INTEGER,
     Code_operator_fk INTEGER,
     city_fk VARCHAR(50)
);
ALTER TABLE PHONE ADD CONSTRAINT phone_pk PRIMARY KEY (Code_operator_fk,city_fk);

ALTER TABLE PHONE ADD CONSTRAINT Code_operator_fk FOREIGN KEY OPERATORS(Code_operator) ;
ALTER TABLE PHONE ADD CONSTRAINT cityfk FOREIGN KEY STUDENTS (sity);






  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO OLGAKYSLA ;
GRANT SELECT ANY TABLE TO OLGAKYSLA ;
GRANT INSERT ANY TABLE TO OLGAKYSLA ;





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/
select (customers.cust_name)
from customers, orders, orderitems 
where (orders.ORDER_NUM = orderitems.ORDER_NUM) 
    and (customers.cust_id = orders.cust_id)
    and (item_price = (Select min(item_price) from orderitems ));

--Код відповідь:

 












/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT cust_name as client_name
FROM CUSTOMERS, ORDERS 
WHERE (CUSTOMERS.CUST_ID != ORDERS.CUST_ID) AND CUST_ADDRESS = NULL;



/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

select distinct upper (vend_name) as vendor_name
from vendors, products, orderitems
where Vendors.vend_id = Products.vend_id AND Products.prod_id = Orderitems.prod_id ;

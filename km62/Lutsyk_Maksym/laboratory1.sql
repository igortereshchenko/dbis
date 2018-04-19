-- LABORATORY WORK 1
-- BY Lutsyk_Maksym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user Lutsyk identified by password;

default tablespace "users";
temporary tablespace 'temp';

alter uses quota 100m on user;

grant 'connect' to Lutsyk;
grant create any table to Lutsyk;
grant delete any table to Lutsyk;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент здає роботу викладачу.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:    (додано 19.04.2018)

CREATE TABLE student( 
gbook_num VARCHAR(20) NOT NULL
); 

ALTER TABLE STUDENT
ADD CONSTRAINT gbook_num_pk PRIMARY KEY(gbook_num); 

Create table TEACHER(
TEACHER_NAME VARCHAR (20) NOT NULL
);

ALTER TABLE TEACHER
ADD CONSTRAINT teacher_name_pk PRIMARY KEY(TEACHER_NAME); 

Create table WORKs (
GBOOK_NUM VARCHAR (20) NOT NULL, 
teacher_name VARCHAR(20) NOT NULL
);

ALTER TABLE works
    ADD CONSTRAINT gbook_num_fk FOREIGN KEY ( gbook_num )
        REFERENCES student ( gbook_num );
ALTER TABLE works        
    ADD CONSTRAINT teacher_name_fk FOREIGN KEY ( TEACHER_NAME )
        REFERENCES TEACHER ( TEACHER_NAME );


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant create any table to Lutsyk; 
grant insert any table to Lutsyk; 
grant select any table to Lutsyk; 





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь: (додано 18.04.2018)

SELECT CUST_NAME
FROM Customers,Orders, ORDERITEMS
 WHERE customers.cust_id = orders.cust_id
 AND orders.order_num = orderitems.order_num
AND item_price IN (SELECT MIN(orderitems.item_price) FROM orderitems);

/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:    (додано 18.04.2018)
SELECT     
	CUST_NAME as "client_name"
FROM CUSTOMERS
	WHERE CUST_ID  IN (
                        SELECT CUST_ID  
			FROM ORDERS
            		)
     		and CUST_EMAIL IS NULL;

/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:   (додано 18.04.2018)
                                 
                                 SELECT upper(CUST_NAME) as "customer_name"
FROM CUSTOMERS
WHERE CUSTOMERS.CUST_ID NOT IN (
                         SELECT CUST_ID   
                         FROM ORDERS);


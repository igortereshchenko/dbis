/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та створювати таблиці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER ushatska IDENTIFIED BY ushatska 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER ushatska QUOTA 100M ON USERS;

GRANT "CONNECT" TO ushatska ;

GRANT CREATE ANY TABLE TO ushatska ;
GRANT ALTER ANY TABLE TO ushatska;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент пише нотатки у блокноті.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь: 
create table notatock_1( notatock_body_1 char(250) )
alter table constraint  (notatock_1_name_pk char(30) not null)
primary key 

















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO ushatska;
GRANT ALTER ANY TABLE TO ushatska;
GRANT INSERT ANY TABLE TO ushatska;







/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив не найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
#ревьювер Алгебра Кодда
PROJECT (CUSTOMERS, ORDERS)
WHERE
ORDERS.CUST_ID = CUSTOMERS.CUST_ID
and
ITEM_PRICE in (
PROJECT ORDERITEMS
{MAX(ITEM_PRICE)}
)
{ CUST_NAME}


# моя Алгебра Кодда
PROJECT (CUSTOMERS TIMES ORDERS TIMES ORDERITEMS
 WHERE CUSTOMERS.CUST_ID =ORDERS.CUST_ID
AND ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM)
{CUSTOMERS.CUST_NAME}
MINUS
PROJECT (CUSTOMERS TIMES ORDERS TIMES ORDERITEMS
 WHERE CUSTOMERS.CUST_ID =ORDERS.CUST_ID
AND ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
AND ORDERITEMS.ITEM_PRICE=((PROJECT  ORDERITEMS) {MAX(ORDERITEMS.ITEM_PRICE)}))
{CUSTOMERS.CUST_NAME};
















/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть покупці має не найкоротшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

#мой SQL
SELECT CUST_COUNTRY
FROM CUSTOMERS 
WHERE LENGTH(TRIM(CUST_COUNTRY))=(SELECT MIN(LENGTH( TRIM(CUST_COUNTRY)))FROM CUSTOMERS);















/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення у яке входить найдорожчий товар. 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
#C REVIEWER SQL 
SELECT CUST_NAME
FROM CUSTOMERS, ORDERS
WHERE
ORDERS.CUST_ID = CUSTOMERS.CUST_ID
and ITEM_PRICE in (
SELECT MAX(ITEM_PRICE) FROM ORDERITEMS)


#C MY SQL

SELECT CUSTOMERS.CUST_COUNTRY || CUSTOMERS.CUST_EMAIL AS CLIENT_NAME
FROM CUSTOMERS,ORDERS,ORDERITEMS
WHERE CUSTOMERS.CUST_ID =ORDERS.CUST_ID
AND ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
MINUS
SELECT CUSTOMERS.CUST_COUNTRY  || CUSTOMERS.CUST_EMAIL AS CLIENT_NAME
FROM CUSTOMERS,ORDERS,ORDERITEMS
WHERE CUSTOMERS.CUST_ID =ORDERS.CUST_ID
AND ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
AND ORDERITEMS.ITEM_PRICE=(SELECT MAX(ORDERITEMS.ITEM_PRICE)
                           FROM ORDERITEMS);    


-- LABORATORY WORK 1
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--create user Samovilov identified by 12345
--default tablespace "users"
--temporary tablespace "temp"
--alter user Samovilov quota 100mb on "users" 
--grant create any table to Samovilov
--grant alter any table to Samovilov ;
--grant delete any table to Samovilov ;

alter user "Samovilov" quota 100mb on users ;
--alter user "Samovilov" default role "connect" ;
/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Користувач Facebook читає новини.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
--create table 'fb_users'(
--log vchar2(15) not null,
 --passw char(10) not null
 --);















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:







/*---------------------------------------------------------------------------
3.a. 
Які назви товарів, що не продавались покупцям?
Виконати завдання в алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
select PROD_NAME 
from PRODUCTS, ORDERS, ORDERITEMS
where PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID 
and ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
and CUST_ID.













/*---------------------------------------------------------------------------
3.b. 
Яка найдовша назва купленого товару?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести ім'я та пошту покупця, як єдине поле client_name, для тих покупців, що мають не порожні замовлення.
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
-- BY Samovilov_Serhii

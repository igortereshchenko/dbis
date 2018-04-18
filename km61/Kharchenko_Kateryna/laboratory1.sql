/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE user kharchenko
IDENTIFIED users 

GRANT ANY CREATE by kharchenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE student
  student_name varchar2(30)
  
ALTER TABLE student 
  student_name_pk Praymery KEY student_name  
  
CREATE TABLE phone
  cosntry varchar2(30)
  operators varchar2(30)
  phone nomber(10)

ALTER TABLE student 
  phone_pk Pramery KEY phone
  
CREATE TABLE know
  fk_student varchar2(30)
  fk_costry varchar2(30)
  fk_operators varchar2(30)
  fk_phone nomber(10)

ALTER TABLE know
  fk_student CONSTENT student from student
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT INSERT INTO ANY TABLE by kharchenko;
GRANT SELECT ANY TABLE by kharchenko;

/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
--Версія рев'ювера в SQL
SELECT Clients.name FROM Clients, OrderItems
WHERE
OrderItems.item_price in (SELECT max(item_price) FROM OrderItems)
AND
Clients.client_id = OrderItems.client.id

---Правильний варіант в Алгебрі Кодда
(
  (Customers TIMES 
   (
    (Orders RENAME cust_id cust_id_fk)   TIMES 
    (
      (
        (OrderItems RENAME order_num order_num_fk) 
        PROJECT item_price order_num_fk
      ) TIMES 
      (
        OrderItems RENAME min(item_price) min_price
      ) 
    )
   )
 ) WHERE cust_id_fk == cust_id AND order_num_fk == order_num AND item_price == min_price
) PROJECT cust_name




/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

--Версія рев'ювера в SQL
SELECT '('||trim(name)||')'
FROM shop
WHERE mail is not null

---Правильний варіант в SQL
Select '('||trim(cust_name)||')'  AS "client_name"

from (Select customers.cust_name
      From customers
      Where customers.cust_zip is null
      
      MINUS
      Select customers.cust_name
      From customers, orders
      Where customers.cust_zip is null 
      and customers.cust_id = orders.cust_id);


/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--Версія рев'ювера в SQL
SELECT upper(name) AS "vendor_name"
From vendors
Where products is null

---Правильний варіант в SQL
Select vend_name  AS "vendor_name"
From (
  SELECT vendors.vend_name
  From vendors
  MINUS
  SELECT vendors.vend_name
  From vendors, products, orderitems
  Where products.prod_id = orderitems.prod_id 
  and vendors.vend_id = products.vend_id);

-- LABORATORY WORK 1
-- BY Mashnenkova_Ellina
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти дані.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
Create USER Mashnenkova;
Indetified Mashnenkova;
Default tablespace "Users"
Temporary tablespace "Temp";
Grant connect to Mashnenkova;
GRANT CREATE ANY TABLE TO Mashnenkova;
GRANT ALTER ANY TABLE TO Mashnenkova;
GRANT SELECT ANY TABLE TO Mashnenkova;












/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Турист забронював готель. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

Create table tourist (
tourist_id int NOT NULL,
tourist_name VARCHAR(30) NOT NULL,
tourist_lastname VARCHAR(30) NOT NULL,
hotel_id int);

Create table hotel (hotel_id int NOT NULL,
hotel_name VARCHAR(30) NOT NULL);

Alter table tourist 
ADD constraint tourist_p
PRIMARY_KEY tourist_id

Alter table tourist 
ADD constraint tourist_pk
PRIMARY_KEY tourist_id









  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


Create USER Mashnenkova;
Indetified Mashnenkova;
Default tablespace "Users"
Temporary tablespace "Temp";
Grant connect to Mashnenkova;
GRANT CREATE ANY TABLE TO Mashnenkova;
GRANT ALTER ANY TABLE TO Mashnenkova;
GRANT SELECT ANY TABLE TO Mashnenkova;




/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що не купив найдорожчий продукт.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


GRANT INSERT ANY TABLE TO Mashnenkova;









/*---------------------------------------------------------------------------
3.b. 
Вивести номер замовлення та назву товару у даному замовленні, що має найнижчу ціну у рамках замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name у нижньому регістрі, для тих покупців, що купляли продукти у постачальника з іменем "James". 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


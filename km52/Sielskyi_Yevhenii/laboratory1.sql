-- LABORATORY WORK 1
-- BY Sielskyi_Yevhenii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

Create user eugene_sel IDENTIFIED BY 12345
Default tablespace "USERS"
Temporary tablespace "TEMP";

ALTER User eugene_sel Quota unlimited on USERS;

Grant Connect TO eugene_sel;

Grant Alter Any table to eugene_sel;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Класна кімната має парти та стільці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

Create table Classroom (
    classroom_number char(4) NOT NULL,
    classroom_subject char(20)
);

Alter Table Classroom 
    Add Constraint classroom_pk Primary key (classroom_number);
    
Create table Desks (
    desk_zip number(10) not null,
    classroom_number_fk char(4) NOT NULL
);

Alter Table Desks 
    Add Constraint desk_pk Primary key (desk_zip);
    
Alter Table Desks 
    Add Constraint classroom_fk Foreign key (classroom_number_fk) References Classroom (classroom_number);    

Create table Chairs (
    chair_zip number(10) not null,
    classroom_number_fk char(4) NOT NULL
);

Alter Table Chairs 
    Add Constraint chair_pk Primary key (chair_zip);
    
Alter Table Chairs
    Add Constraint classroom_chair_fk Foreign key (classroom_number_fk) References Classroom (classroom_number);  


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

Grant Create Any table to eugene_sel;
Grant Select Any table to eugene_sel;


/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

Select 
    count(cust_name)
From (  Select Distinct 
            cust_id, cust_name, prod_name
        From customers, products, orders, orderitems
        Where customers.cust_id = orders.cust_id
            and orders.order_num = orderitems.order_num
            and orderitems.prod_id = products.prod_id
            and products.prod_price = max(
                                        Select prod_price 
                                        From products
                                        )
    );
    













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних електронних адрес зберігається в таблиці CUSTOMERS - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


Select count(cust_email) as "count_email"
From (
    Select Distinct cust_email
    From Customers
    );


/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
Rename (Project (
    Customers TIMES Orders
    Where customers.cust_id != orders.cust_id
    
    ) cust_name
    
Union    

Project (
    Customers TIMES Orders
    Where customers.cust_id != orders.cust_id
    
    ) cust_email) client_name

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

/*==============================================================*/
/* Table: Blackboard                                            */
/*==============================================================*/
create table Blackboard 
(
   blackboard_zip       NUMBER(10)           not null,
   classroom_number_fk_bb CHAR(4),
   blackboard_type      VARCHAR2(11)         not null,
   blackboard_color     VARCHAR2(20)         not null
);

/*==============================================================*/
/* Table: Chair                                                 */
/*==============================================================*/
create table Chair 
(
   chair_zip            NUMBER(10)           not null,
   classroom_number_fk_ch CHAR(4),
   chair_color          VARCHAR2(20)         not null,
   chair_height         NUMBER(2,2)          not null
);


/*==============================================================*/
/* Table: Classroom                                             */
/*==============================================================*/
create table Classroom 
(
   classroom_number     CHAR(4)              not null,
   classroom_subject    CHAR(20),
   classroom_space      NUMBER(2,2)          not null,
   classroom_floor      NUMBER(1)            not null
);

/*==============================================================*/
/* Table: Desk                                                  */
/*==============================================================*/
create table Desk 
(
   desk_zip             NUMBER(10)           not null,
   classroom_number_fk_ds CHAR(4),
   desk_color           VARCHAR2(20)         not null,
   desk_height          NUMBER(2,2)          not null
);

alter table Blackboard
    add constraint PK_BLACKBOARD primary key (blackboard_zip);

alter table Chair
   add constraint PK_CHAIR primary key (chair_zip);

alter table Classroom
   add constraint PK_CLASSROOM primary key (classroom_number);

alter table Desk
   add constraint PK_DESK primary key (desk_zip);

alter table Blackboard
   add constraint CLASSROOM_BLACKBOARD_FK foreign key (classroom_number_fk_bb)
      references Classroom (classroom_number)
      on delete cascade;

alter table Chair
   add constraint CLASSROOM_CHAIR_FK foreign key (classroom_number_fk_ch)
      references Classroom (classroom_number)
      on delete cascade;

alter table Desk
   add constraint CLASSROOM_DESK_FK foreign key (classroom_number_fk_ds)
      references Classroom (classroom_number)
      on delete cascade;

alter table Classroom
   add constraint valid_classroom_number check (Regexp_like(classroom_number, '^[0-9]{1,3}[A-Z, a-z]{0,1}'));
   
alter table Classroom
   add constraint valid_classroom_subject check (Regexp_like(classroom_subject, '[A-Z][a-z]{2,}'));   
   
alter table Classroom
   add constraint positive_classroom_space check (classroom_space > 0);  
   
alter table Classroom
   add constraint valid_classroom_floor check (classroom_floor >= 0); 
   
alter table Blackboard
   add constraint valid_blackboard_zip check (Regexp_like(blackboard_zip, '[0-9]{10}'));   
   
alter table Blackboard
   add constraint valid_blackboard_type check (blackboard_type IN ('Default', 'Interactive'));     
   
alter table Blackboard
   add constraint valid_blackboard_color check (blackboard_color IN ('Green', 'Brown', 'Black', 'White'));  

alter table Chair
   add constraint valid_chair_zip check (Regexp_like(chair_zip, '[0-9]{10}'));   
   
alter table Chair
   add constraint valid_chair_color check (chair_color IN ('Yellow', 'Brown', 'Black', 'White', 'Grey')); 
   
alter table Chair
   add constraint positive_chair_height check (chair_height > 0); 
   
alter table Desk
   add constraint valid_desk_zip check (Regexp_like(desk_zip, '[0-9]{10}'));     
   
alter table Desk
   add constraint valid_desk_color check (desk_color IN ('Yellow', 'Brown', 'Black', 'White', 'Grey')); 
   
alter table Desk
   add constraint positive_desk_height check (desk_height > 0);   


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

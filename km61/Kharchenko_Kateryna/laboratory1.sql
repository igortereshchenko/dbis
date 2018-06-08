/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE user kharchenko
IDENTIFIED users 

GRANT CREATE ANY TABLE by kharchenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

/*==============================================================*/
/* Table: "Countries"                                           */
/*==============================================================*/
create table "Countries" 
(
   "country_name"       CHAR(30)             not null,
   "country_phoneCode"  NUMBER(8)            not null,
   constraint Country_name_chk check ("country_name" LIKE [A-Z][a-z]{1,8}[:blank:][a-z]{0,9}[:blank:][a-z]{0,9}),
   constraint Country_phoneCode_chk check ("country_phoneCode" LIKE [0-9]{1,8})
);

/*==============================================================*/
/* Table: "Countries has operators"                             */
/*==============================================================*/
create table "Countries has operators" 
(
   "Operator_name"      CHAR(30)             not null,
   "country_name"       CHAR(30)             not null,
   "operator_country_phoneCode" NUMBER(8)            not null,
   constraint Operator_name_chk check ("Operator_name" LIKE [A-Z][a-z]{1,8}[:blank:][a-z]{0,9}[:blank:][a-z]{0,9}),
   constraint country_name_chk check Country_name_chk check ("country_name" LIKE [A-Z][a-z]{1,8}[:blank:][a-z]{1,9}[:blank:][a-z]{1,9}),
   constraint operator_country_phoneCode_chk ("perator_country_phoneCode" LIKE [0-9]{1,8})
);



/*==============================================================*/
/* Table: "Operators"                                           */
/*==============================================================*/
create table "Operators" 
(
   "Operator_name"      CHAR(30)             not null,
   constraint Operator_name_chk check ("Operator_name" LIKE [A-Z][a-z]{1,8}[:blank:][a-z]{0,9}[:blank:][a-z]{0,9})
);

/*==============================================================*/
/* Table: "Students"                                            */
/*==============================================================*/
create table "Students" 
(
   "student_name"       CHAR(50)             not null,
   "student_IDCardNumber" CHAR(20)             not null,
   constraint student_name_chk check ("student_name" LIKE [A-Z][a-z]{1,15}[:blank:][A-Z][a-z]{1,15}[:blank:][][A-Z,a-z]{0,15}),
   constraint student_IDCardNumber_chk ("perator_country_phoneCode" LIKE [A-Z]{2}[0-9]{1,8})
);

/*==============================================================*/
/* Table: "phoneNumbers"                                        */
/*==============================================================*/
create table "phoneNumbers" 
(
   "student_name"       CHAR(50)             not null,
   "student_IDCardNumber" CHAR(20)             not null,
   "Operator_name"      CHAR(30)             not null,
   "country_name"       CHAR(30)             not null,
   "phoneNumber"        NUMBER(20)           not null,
   constraint student_name_chk check ("student_name" LIKE [A-Z][a-z]{1,15}[:blank:][A-Z][a-z]{1,15}[:blank:][][A-Z,a-z]{0,15}),
   constraint student_IDCardNumber_chk ("perator_country_phoneCode" LIKE [A-Z]{2}[0-9]{1,8}),
   constraint Operator_name_chk check ("Operator_name" LIKE [A-Z][a-z]{1,8}[:blank:][a-z]{0,9}[:blank:][a-z]{0,9}),
   constraint country_name_chk check Country_name_chk check ("country_name" LIKE [A-Z][a-z]{1,8}[:blank:][a-z]{1,9}[:blank:][a-z]{1,9}),
   constraint phoneNumber_chk check ("phoneNumber" LIKE [0-9]{1,20})


   );

alter table "Countries has operators"
   add constraint FK_COUNTRIE_COUNTRIES_COUNTRIE foreign key ("country_name")
      references "Countries" ("country_name");

alter table "Countries has operators"
   add constraint FK_COUNTRIE_OPERATORS_OPERATOR foreign key ("Operator_name")
      references "Operators" ("Operator_name");

alter table "phoneNumbers"
   add constraint FK_PHONENUM_COUNTRIES_COUNTRIE foreign key ("Operator_name", "country_name")
      references "Countries has operators" ("Operator_name", "country_name");

alter table "phoneNumbers"
   add constraint PK_PHONENUMBERS primary key ("student_name", "student_IDCardNumber", "Operator_name", "country_name", "phoneNumber")

 constraint "FK_PHONENUM_STUDENT H_STUDENTS" foreign key ("student_name", "student_IDCardNumber")
      references "Students" ("student_name", "student_IDCardNumber");

alter table "Students"
   add constraint PK_STUDENTS primary key ("student_name", "student_IDCardNumber")

alter table "Operators"
   add constraint PK_OPERATORS primary key ("Operator_name")

alter table "Countries has operators"
   add constraint "PK_COUNTRIES HAS OPERATORS" primary key ("Operator_name", "country_name")

alter table "Countries"
   add constraint PK_COUNTRIES primary key ("country_name")
   
   
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

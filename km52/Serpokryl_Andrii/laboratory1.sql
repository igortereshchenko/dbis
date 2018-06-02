-- LABORATORY WORK 1
-- BY Serpokryl_Andrii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create user Serpokryl identified by serpokryl
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

alter user Serpokryl quota 100M on USERS;

grant delete any table to Serpokryl;




/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Університет має факультети, що складаються з кафедр.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE "Department" (
  "Faculty_Name" varchar(50),
  "Department_Name" varchar(50),
  "Department_Code" int,
);


CREATE TABLE "Faculty" (
  "Faculty_Name" varchar(50),
  "University_Name" varchar(50),
);


CREATE TABLE "University" (
  "University_Name" varchar(50),
  "Year_of_establishing" int,
  "GPS" varchar(10),
);


CREATE TABLE "Depatments_has_groups" (
  "Group_Name" varcahr(6),
  "Group_year" int,
  "Department_Name" varchar(50),
  "Department_Code" int
);


CREATE TABLE "Group" (
  "Group_Name" varcahr(6),
  "Group_year" int,
);

ALTER TABLE University ADD CONSTRAINT PK_University PRIMARY KEY (University_Name);
ALTER TABLE Department ADD CONSTRAINT PK_Department PRIMARY KEY (Department_Name, Department_Code);
ALTER TABLE Faculty ADD CONSTRAINT PK_Faculty PRIMARY KEY (Faculty_Name);
ALTER TABLE Group ADD CONSTRAINT PK_Group PRIMARY KEY (Group_Name, Group_year);

ALTER TABLE Faculty
ADD CONSTRAINT FK_Faculty FOREIGN KEY (University_Name) REFERENCES University (University_Name);
ALTER TABLE Department
ADD CONSTRAINT FK_Department FOREIGN KEY (Faculty_Name) REFERENCES Faculty (Faculty_Name);
ALTER TABLE Department_has_groups
ADD CONSTRAINT FK_Department_has_groups_Group FOREIGN KEY (Group_Name, Group_year) REFERENCES Group (Group_Name, Group_year);
ALTER TABLE Department_has_groups
ADD CONSTRAINT FK_Department_has_groups_Department FOREIGN KEY (Department_Name, Department_Code) REFERENCES Department (Department_Name, Department_Code);

ALTER TABLE University ADD CONSTRAINT Check_University_Name CHECK (regexp_like(University_Name, '^[A-Z]*'));
ALTER TABLE University ADD CONSTRAINT Check_Year_of_establishing CHECK (Year_of_establishing > 0);
ALTER TABLE University ADD CONSTRAINT Check_GPS CHECK (regexp_like(GPS, '[0-9]{2}|([0-9]{2}\.[0-9]{2})°[0-9]{2}|([0-9]{2}\.[0-9]{2})\'[0-9]{2}|([0-9]{2}\.[0-9]{2})"'));

ALTER TABLE Faculty ADD CONSTRAINT Check_Faculty_Name CHECK (regexp_like(Faculty_Name, '^[A-Z]*'));

ALTER TABLE Department ADD CONSTRAINT Check_Department_Name CHECK (regexp_like(Department_Name, '^[A-Z]*'));
ALTER TABLE Department ADD CONSTRAINT Check_Department_Code CHECK (Department_Code > 0);

ALTER TABLE Group ADD CONSTRAINT Check_Group_Name CHECK (regexp_like(Group_Name, '([A-Z]{2}-\d{2})|([A-Z]{2}-\d{2}m)'));
ALTER TABLE Group ADD CONSTRAINT Check_Group_Year CHECK (Group_Year > 0);

INSERT INTO University(University_Name, Year_of_establishing, GPS)
VALUES('NTUU KPI','1898','40°45'58"');
INSERT INTO University(University_Name, Year_of_establishing, GPS)
VALUES('Lviv Polytechnic','1488','30°98.56'96"');
INSERT INTO University(University_Name, Year_of_establishing, GPS)
VALUES('Taras Shevchenko National University of Kyiv','1834','50°00.26'99');
INSERT INTO University(University_Name, Year_of_establishing, GPS)
VALUES('National Aviation University','1933','58°92.36'76');

INSERT INTO Faculty(Faculty_Name, University_Name)
VALUES('Faculty of applied mathematics ','NTUU KPI');
INSERT INTO Faculty(Faculty_Name, University_Name)
VALUES('Faculty of architecture','Lviv Polytechnic');
INSERT INTO Faculty(Faculty_Name, University_Name)
VALUES('Faculty of law ','Taras Shevchenko National University of Kyiv');
INSERT INTO Faculty(Faculty_Name, University_Name)
VALUES('Faculty of mechanical engineering','National Aviation University');

INSERT INTO Department(Faculty_Name, Department_Name, Department_Code)
VALUES('Faculty of applied mathematics','Applied mathematics','1');
INSERT INTO Department(Faculty_Name, Department_Name, Department_Code)
VALUES('Faculty of architecture','Bridge construction','2');
INSERT INTO Department(Faculty_Name, Department_Name, Department_Code)
VALUES('Faculty of law','Jurisprudence','3');
INSERT INTO Department(Faculty_Name, Department_Name, Department_Code)
VALUES('Faculty of mechanical engineering','Laser','4');

INSERT INTO Group(Group_Name, Group_Year)
Values('FU-13','2013');
INSERT INTO Group(Group_Name, Group_Year)
Values('CK-14','2014');
INSERT INTO Group(Group_Name, Group_Year)
Values('KM-52','2015');
INSERT INTO Group(Group_Name, Group_Year)
Values('BJ-16m','2016');







  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


grant create any table to Serpokryl;
grant insert any table to Serpokryl;




/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


select Distinct Orders.order_num
from Orders left join orderitems 
    On orders.order_num = orderitems.order_num left join products
    On orderitems.prod_id = products.prod_id,(select min(prod_price) as a
                                                    from products) b
where products.prod_price = b.a;











/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних країн зберігається в таблиці CUSTOMERS - назвавши це поле country.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


select count(Distinct Customer.cust_country) as "country"
from Customers;

  --Another way:
 select count(*) as "country"
 from (select Distinct Customers.cust_country
        from Customers);










/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

RENAME(
  LOWER(
    PROJECT((VENDORS TIMES PRODUCTS TIMES ORDERITEMS) 
            WHERE VENDORS.vend_id = PRODUCTS.vend_id AND PRODUCTS.prod_id = ORDERITEMS.prod_id ) 
    vend_name)
) AS "vendor_name"



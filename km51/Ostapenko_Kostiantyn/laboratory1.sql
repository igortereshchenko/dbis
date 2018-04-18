/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та створювати таблиці.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER ostapenko
IDENTIFIED by ostapenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER ostapenko QUOTA 100M ON USERS;

GRANT "CONNECT" to ostapenko;
GRANT CREATE ANY table TO ostapenko;
GRANT ALTER any table TO  ostapenko;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент пише нотатки у блокноті.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

alter table notes
   drop constraint FK_NOTES_NOTEBOOK;

alter table students_have_notebooks
   drop constraint FK_STUDENT_has_NOTEBOOK;

alter table students_have_notebooks
   drop constraint FK_STUDENTS__NOTEBOOK;

drop table notebook cascade constraints;

drop table notes cascade constraints;

drop table student cascade constraints;

drop index students_have_hotebooks_FK;

drop index students_have_hotebooks2_FK;

drop table students_have_notebooks cascade constraints;

/*==============================================================*/
/* Table: notebook                                              */
/*==============================================================*/
create table notebook 
(
   notebook_name        VARCHAR2(40)         not null,
   notebook_code        INTEGER              not null,
   constraint PK_NOTEBOOK primary key (notebook_code, notebook_name)
);

alter table notebook
	add constraint notebook_name_check check(regexp_like (notebook_name, '^[A-Za-z0-9- ]+$'));

alter table notebook
	add constraint notebook_code_check check(regexp_like (notebook_code, '^[0-9]+$'));
/*==============================================================*/
/* Table: notes                                                 */
/*==============================================================*/
create table notes 
(
   notebook_code        INTEGER              not null,
   notebook_name        VARCHAR2(40)         not null,
   note_name            VARCHAR2(40),
   creat_date           DATE,
   note_text            VARCHAR2(20),
   constraint PK_NOTES primary key (notebook_code, notebook_name)
);

alter table notes
	add constraint n_notebook_code_check check(regexp_like (notebook_code, '^[0-9]+$'));

alter table notes
	add constraint n_notebook_name_check check(regexp_like (notebook_name, '^[A-Za-z0-9- ]+$'));

alter table notes
	add constraint note_name_check check(regexp_like (note_name, '^[A-Za-z0-9- ]+$'));

alter table notes
	add constraint create_date_check check(regexp_like(date_check, '^([1-9]|[12][0-9]||[31][30]).([A-Z]{1,3}).[1-2][0-9]{3}$'));


alter table notes
	add constraint note_text_check check(regexp_like (note_text, '^[A-Za-z0-9-!@#$%^&*()_+= ]+$'));

/*==============================================================*/
/* Table: student                                               */
/*==============================================================*/
create table student 
(
   name                 VARCHAR2(40)         not null,
   surname              VARCHAR2(40)         not null,
   email                VARCHAR2(40)         not null,
   constraint PK_STUDENT primary key (email)
);
alter table student
	add constraint name_check check(regexp_like (name, '^[A-Z][a-z]+$'));
alter table student
	add constraint surname_check check(regexp_like (surname, '^[A-Z][a-z]+$'));
alter tabel student 
	add constraint email_check check(regexp_like (email< '^[a-z0-9.-_]{4,20}[@][a-z]{2,6}[.][a-z]{2,3}$')); 

/*==============================================================*/
/* Table: students_have_notebooks                               */
/*==============================================================*/
create table students_have_notebooks 
(
   notebook_code        INTEGER              not null,
   notebook_name        VARCHAR2(40)         not null,
   email                VARCHAR2(40)         not null,
   used_time            DATE                 not null,
   constraint PK_STUDENTS_HAVE_NOTEBOOKS primary key (notebook_code, notebook_name, email, used_time)
);

alter table students_have_notebooks   
	add constraint s_notebook_code_check check(regexp_like (notebook_code, '^[0-9]+$'));

alter table students_have_notebooks
	add constraint s_notebook_name_check check(regexp_like (notebook_name, '^[A-Za-z0-9- ]+$'));
alter table students_have_notebooks
	add constraint n_email_check check(regexp_like (email, '^[a-z0-9.-_]{4,20}[@][a-z]{2,6}[.][a-z]{2,3}$'));
alter table students_have_notebooks
	add constraint used_time_check check(regexp_like(used_check, '^([1-9]|[12][0-9]||[31][30]).([A-Z]{1,3}).[1-2][0-9]{3}$'));

/*==============================================================*/
/* Index: students_have_hotebooks2_FK                           */
/*==============================================================*/
create index students_have_hotebooks2_FK on students_have_notebooks (
   email ASC
);

/*==============================================================*/
/* Index: students_have_hotebooks_FK                            */
/*==============================================================*/
create index students_have_hotebooks_FK on students_have_notebooks (
   notebook_code ASC,
   notebook_name ASC
);

alter table notes
   add constraint FK_NOTES_NOTEBOOK foreign key (notebook_code, notebook_name)
      references notebook (notebook_code, notebook_name)
      on delete cascade;

alter table students_have_notebooks
   add constraint FK_STUDENT_has_NOTEBOOK foreign key (email)
      references student (email)
      on delete cascade;

alter table students_have_notebooks
   add constraint FK_STUDENTS__NOTEBOOK foreign key (notebook_code, notebook_name)
      references notebook (notebook_code, notebook_name)
      on delete cascade;

insert into notebook(notebook_name, notebook_code)
VALUES('work', '234356');

insert into notebook(notebook_name, notebook_code)
VALUES('love', '342435');

insert into notebook(notebook_name, notebook_code)
VALUES('time', '222432');



insert into notes(notebook_code, notebook_name, note_name, creat_date, note_text) 
VALUES('234356', 'work', 'django', '25.04.2018', 'work in my life')

insert into notes(notebook_code, notebook_name, note_name, creat_date, note_text) 
VALUES('342435', 'love', 'river', '23.04.2015', 'i love you')


insert into notes(notebook_code, notebook_name, note_name, creat_date, note_text) 
VALUES('222432', 'time', 'blood', '24.04.2003', 'no many no time')

insert into student ( name, surname, email)
VALUES('Pasha', 'Ivanov', 'rembo23@gmil.com');

insert into student ( name, surname, email)
VALUES('Petr', 'Ostapenko', 'rota23@gmil.com');

insert into student ( name, surname, email)
VALUES('Jora', 'Rivnov', 'milk23@gmil.com');


insert into students_have_notebooks(notebook_code, notebook_name, email, used_time)
VALUES('234356','work','rembo23@gmil.com','23.04.2018');




insert into students_have_notebooks(notebook_code, notebook_name, email, used_time)
VALUES('342435','love','rota23@gmil.com','21.02.2018');















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT INSERT ANY TABLE TO ostapenko;
GRANT SELECT ANY TABLE TO ostapenko;





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив не найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT( CUSTOMERS TIMES ORDERS TIMES ORDERITEMS TIMES PRODUCTS
	Where CUSTOMERS.cust_id = ORDERS.cust_id
and orders.order_num = orderitems.order_num
and orderitems.prod_id = products.prod_id
and products.prod_price != max(products.prod_price) )
{ cust_name};


PROJECT(PROJECT( CUSTOMERS TIMES ORDERS TIMES ORDERITEMS 
	Where CUSTOMERS.cust_id = ORDERS.cust_id
and orders.order_num = orderitems.order_num
and ORDERITEMS.ITEM_PRICE NOT IN (PROJECT (ORDERITEMS) {max(products.prod_price)} )
{ distinct cust_id,cust_name} ){cust_name};









/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть покупці має не найкоротшу назву?
Виконати завдання в SQL. 

4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_COUNTRY
	FROM CUSTOMERS
	WHERE  length(cust_country) != min(length(cust_country);
				
SELECT distinct CUST_COUNTRY
	FROM CUSTOMERS
	WHERE  length(cust_country) != (SELECT min(length(cust_country)
						   FROM CUSTOMERS);







/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення у яке входить найдорожчий товар. 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

((SELECT customers.cust_country
	FROM CUSTOMERS, ORDERS, ORDERITEMS, PRODUCTS
	Where CUSTOMERS.cust_id = ORDERS.cust_id
	and orders.order_num = orderitems.order_num
	and orderitems.prod_id = products.prod_id
	and products.prod_price != max(products.prod_price))
CONCAT
 (SELECT customers.cust_email
	FROM CUSTOMERS, ORDERS, ORDERITEMS, PRODUCTS
	Where CUSTOMERS.cust_id = ORDERS.cust_id
	and orders.order_num = orderitems.order_num
	and orderitems.prod_id = products.prod_id
	and products.prod_price != max(products.prod_price)) )	AS client_name;
					
SELECT distinct	trim(cust_country)||' '|| trim(cust_email) AS "client_name"			
	FROM CUSTOMERS, ORDERS, ORDERITEMS
	Where CUSTOMERS.cust_id = ORDERS.cust_id
	and orders.order_num = orderitems.order_num				
	and ORDERITEMS.ITEM_PRICE NOT IN 	(SELECT MAX(ITEM_PRICE)
	                                 FROM ORDERITEMS);

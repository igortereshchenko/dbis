/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER yavtukhovskiy IDENTIFIED BY yavtukhovskiy;
DEFAULT TABLESPACE "USERS" TEMPORARY TABLESPACE "TEMP" 
ALTER USER yavtukhovskiy QUOTA 100M ON USERS;
GRANT "CONNECT" TO yavtukhovskiy;
GRANT ALTER ANY TABLE TO yavtukhovskiy;














/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Книжка складається з сторінок, на яких є рядки тексту.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

/*==============================================================*/
/* Table: authors                                               */
/*==============================================================*/
create table authors 
(
   pass_code            VARCHAR2(8)          not null,
   author_first_name    VARCHAR2(30)         not null,
   author_second_name   VARCHAR2(30)         not null,
   constraint PK_AUTHORS primary key (pass_code)
);

/*==============================================================*/
/* Table: book                                                  */
/*==============================================================*/
create table book 
(
   book_name            VARCHAR2(30)         not null,
   book_author          VARCHAR2(30)         not null,
   publ_year            NUMBER(4)            not null,
   book_id              NUMBER(6)            not null,
   constraint PK_BOOK primary key (book_id)
);

/*==============================================================*/
/* Table: book_has_page_with_rows                               */
/*==============================================================*/
create table book_has_page_with_rows 
(
   row_data             VARCHAR2(60)         not null,
   page_format          CHAR(2)              not null,
   page_number          NUMBER(5)            not null,
   book_id              NUMBER(6)            not null,
   constraint PK_BOOK_HAS_PAGE_WITH_ROWS primary key (row_data, page_format, page_number, book_id)
);

/*==============================================================*/
/* Index: Relationship_6_FK                                     */
/*==============================================================*/
create index Relationship_6_FK on book_has_page_with_rows (
   book_id ASC
);

/*==============================================================*/
/* Index: Relationship_7_FK                                     */
/*==============================================================*/
create index Relationship_7_FK on book_has_page_with_rows (
   row_data ASC,
   page_format ASC,
   page_number ASC
);

/*==============================================================*/
/* Table: books_author                                          */
/*==============================================================*/
create table books_author 
(
   book_id              NUMBER(6)            not null,
   pass_code            VARCHAR2(8)          not null,
   constraint PK_BOOKS_AUTHOR primary key (book_id, pass_code)
);

/*==============================================================*/
/* Index: Relationship_3_FK                                     */
/*==============================================================*/
create index Relationship_3_FK on books_author (
   pass_code ASC
);

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on books_author (
   book_id ASC
);

/*==============================================================*/
/* Table: page                                                  */
/*==============================================================*/
create table page 
(
   page_format          CHAR(2)              not null,
   page_number          NUMBER(5)            not null,
   constraint PK_PAGE primary key (page_format, page_number)
);

/*==============================================================*/
/* Table: page_has_row                                          */
/*==============================================================*/
create table page_has_row 
(
   row_data             VARCHAR2(60)         not null,
   page_format          CHAR(2)              not null,
   page_number          NUMBER(5)            not null,
   constraint PK_PAGE_HAS_ROW primary key (row_data, page_format, page_number)
);

/*==============================================================*/
/* Index: page_has_row2_FK                                      */
/*==============================================================*/
create index page_has_row2_FK on page_has_row (
   page_format ASC,
   page_number ASC
);

/*==============================================================*/
/* Index: page_has_row_FK                                       */
/*==============================================================*/
create index page_has_row_FK on page_has_row (
   row_data ASC
);

/*==============================================================*/
/* Table: "row"                                                 */
/*==============================================================*/
create table "row" 
(
   row_data             VARCHAR2(60)         not null,
   constraint PK_ROW primary key (row_data)
);

alter table book_has_page_with_rows
   add constraint book_has_page_book_id_fk foreign key (book_id)
      references book (book_id);

alter table book_has_page_with_rows
   add constraint book_has_page_row_fk foreign key (row_data, page_format, page_number)
      references page_has_row (row_data, page_format, page_number);

alter table books_author
   add constraint book_fk foreign key (book_id)
      references book (book_id);

alter table books_author
   add constraint author_fk foreign key (pass_code)
      references authors (pass_code);

alter table page_has_row
   add constraint page_has_row_row_fk foreign key (row_data)
      references "row" (row_data);

alter table page_has_row
   add constraint page_has_row_page_fk foreign key (page_format, page_number)
      references page (page_format, page_number);
  
alter table authors
add constraint pass_code_ch check (REGEXP_LIKE(pass_code, '^\d{6}$'));

alter table authors
add constraint author_first_name_ch check (REGEXP_LIKE(author_first_name, '^[A-Z][a-z]{1,29}$'));

alter table authors
add constraint author_last_name_ch check (REGEXP_LIKE(author_last_name, '^[A-Z][a-z]{1,29}$'));

alter table book
add constraint book_name_ch check (REGEXP_LIKE(book_name, '^.{1,30}$'));

alter table book
add constraint publ_year_ch check (REGEXP_LIKE(publ_year, '^[0-2]\d{1,3}$'));


alter table book
add constraint book_id_ch check (REGEXP_LIKE(book_id, '^\d{6}$'));

alter table page
add constraint page_format_ch check (REGEXP_LIKE(page_format, '^A[0-6]$'));

alter table page
add constraint page_number_ch check (REGEXP_LIKE(page_number, '^\d{0,5}$'));

alter table row
add constraint row_data_ch check (REGEXP_LIKE(row_data, '^.{0-30}$'));


  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO yavtukhovskiy;
GRANT INSERT ANY TABLE TO yavtukhovskiy;
GRANT SELECT ANY TABLE TO yavtukhovskiy;






/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT (CUSTOMERS TIMES ORDERS TIMES ORDERITEMS
         WHERE customers.cust_id=orders.cust_id
         AND orders.order_num=orderitems.order_num
         AND orderitems.item_price=max(orderitems.item_price))
         {customers.cust_name};












/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть покупці має найкоротшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT Min(Length) as "MinLength"
FROM (
SELECT length(trim(cust_country)) as "Length" From customers);














/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name, для тих покупців, що мають замовлення, але воно порожнє (нема orderitems). 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT TRIM(CUST_COUNTRY) || ' ' || TRIM(CUST_EMAIL) AS "CLIENT_NAME"
FROM CUSTOMERS
WHERE CUST_ID IN (
SELECT CUSTOMERS.CUST_ID AS "CUST_ID"
FROM CUSTOMERS

MINUS 

SELECT DISTINCT ORDERS.CUST_ID AS "CUST_ID"
FROM ORDERS
);


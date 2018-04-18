-- LABORATORY WORK 1
-- BY Kuzina_Anna
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER kuzina 
IDENTIFIED BY ann
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER kuzina QUOTA 100M ON USERS;

GRANT "CONNECT" TO kuzina;

GRANT ALTER ANY TABLE TO kuzina;









/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Книжка складається з сторінок, на яких є рядки тексту.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     18.04.2018 22:43:55                          */
/*==============================================================*/


alter table books_have_pages
   drop constraint books_have_pages_fk;

alter table books_have_pages
   drop constraint page_in_book_fk;

alter table pages_have_rows
   drop constraint pages_have_rows_fk;

alter table pages_have_rows
   drop constraint pages_rows_fk;

drop table BOOKS cascade constraints;

drop table PAGES cascade constraints;

drop table STRING_ROW cascade constraints;

drop index page_in_book_FK;

drop index books_have_pages_FK;

drop table books_have_pages cascade constraints;

drop index pages_rows_FK;

drop index pages_have_rows_FK;

drop table pages_have_rows cascade constraints;

/*==============================================================*/
/* Table: BOOKS                                                 */
/*==============================================================*/
create table BOOKS 
(
   book_id              NUMBER(10)           not null,
   book_name            VARCHAR2(40)         not null,
   book__author         VARCHAR2(40)         not null,
   constraint PK_BOOKS primary key (book_id)
);

/*==============================================================*/
/* Table: PAGES                                                 */
/*==============================================================*/
create table PAGES 
(
   page_id              NUMBER(10)           not null,
   page_number          NUMBER(4)            not null,
   constraint PK_PAGES primary key (page_id)
);

/*==============================================================*/
/* Table: STRING_ROW                                            */
/*==============================================================*/
create table STRING_ROW 
(
   row_id               NUMBER(10)           not null,
   row_number           NUMBER(20)           not null,
   constraint PK_STRING_ROW primary key (row_id)
);

/*==============================================================*/
/* Table: books_have_pages                                      */
/*==============================================================*/
create table books_have_pages 
(
   row_id               NUMBER(10)           not null,
   page_id              NUMBER(10)           not null,
   book_id              NUMBER(10)           not null,
   constraint PK_BOOKS_HAVE_PAGES primary key (row_id, page_id, book_id)
);

/*==============================================================*/
/* Index: books_have_pages_FK                                   */
/*==============================================================*/
create index books_have_pages_FK on books_have_pages (
   book_id ASC
);

/*==============================================================*/
/* Index: page_in_book_FK                                       */
/*==============================================================*/
create index page_in_book_FK on books_have_pages (
   row_id ASC,
   page_id ASC
);

/*==============================================================*/
/* Table: pages_have_rows                                       */
/*==============================================================*/
create table pages_have_rows 
(
   row_id               NUMBER(10)           not null,
   page_id              NUMBER(10)           not null,
   constraint PK_PAGES_HAVE_ROWS primary key (row_id, page_id)
);

/*==============================================================*/
/* Index: pages_have_rows_FK                                    */
/*==============================================================*/
create index pages_have_rows_FK on pages_have_rows (
   page_id ASC
);

/*==============================================================*/
/* Index: pages_rows_FK                                         */
/*==============================================================*/
create index pages_rows_FK on pages_have_rows (
   row_id ASC
);

alter table books_have_pages
   add constraint books_have_pages_fk foreign key (book_id)
      references BOOKS (book_id)
      on delete cascade;

alter table books_have_pages
   add constraint page_in_book_fk foreign key (row_id, page_id)
      references pages_have_rows (row_id, page_id)
      on delete cascade;

alter table pages_have_rows
   add constraint pages_have_rows_fk foreign key (page_id)
      references PAGES (page_id)
      on delete cascade;

alter table pages_have_rows
   add constraint pages_rows_fk foreign key (row_id)
      references STRING_ROW (row_id)
      on delete cascade;

ALTER TABLE BOOKS
ADD CONSTRAINT check_book_id
CHECK (book_id > 0); 
   
ALTER TABLE BOOKS
ADD CONSTRAINT check_book_name
CHECK (REGEXP_LIKE(book_name,'(\s?\w+)+'));

ALTER TABLE BOOKS
ADD CONSTRAINT check_book_author
CHECK (REGEXP_LIKE(book__author,'([A-Z][a-z]+[\-\s]?){2,}'));


ALTER TABLE BOOKS_HAVE_PAGES
ADD CONSTRAINT check_row_id
CHECK (row_id > 0); 

ALTER TABLE BOOKS_HAVE_PAGES
ADD CONSTRAINT check_page_id
CHECK (page_id > 0); 

ALTER TABLE BOOKS_HAVE_PAGES
ADD CONSTRAINT check1_book_id
CHECK (book_id > 0); 

ALTER TABLE PAGES
ADD CONSTRAINT check1_page_id
CHECK (page_id > 0); 

ALTER TABLE PAGES
ADD CONSTRAINT check1_page_number
CHECK (page_number > 0); 


ALTER TABLE PAGES_HAVE_ROWS
ADD CONSTRAINT check1_row_id
CHECK (row_id > 0);

ALTER TABLE PAGES_HAVE_ROWS
ADD CONSTRAINT check2_page_id
CHECK (page_id > 0);

ALTER TABLE STRING_ROW
ADD CONSTRAINT check2_row_id
CHECK (row_id > 0); 

ALTER TABLE STRING_ROW
ADD CONSTRAINT check2_row_number
CHECK (row_number > 0); 


/*======INSERTS=======*/
--Create BOOKS
INSERT INTO BOOKS (book_id, BOOK_NAME, BOOK__AUTHOR)
VALUES ('1', 'Typhoon', 'Joseph Conrad');
INSERT INTO BOOKS (book_id, BOOK_NAME, BOOK__AUTHOR)
VALUES ('2', 'Harry Potter', 'Joanne Rowling');  
INSERT INTO BOOKS (book_id, BOOK_NAME, BOOK__AUTHOR)
VALUES ('3', 'IRELAND', 'Tim Vicary');

--Create PAGES
INSERT INTO PAGES (PAGE_ID, PAGE_NUMBER)
VALUES ('1', '10');
INSERT INTO PAGES (PAGE_ID, PAGE_NUMBER)
VALUES ('2', '11');  
INSERT INTO PAGES (PAGE_ID, PAGE_NUMBER)
VALUES ('8', '11'); 

--Create STRING_ROW
INSERT INTO STRING_ROW (ROW_ID, ROW_NUMBER)
VALUES ('10', '17');
INSERT INTO STRING_ROW (ROW_ID, ROW_NUMBER)
VALUES ('20', '1');  
INSERT INTO STRING_ROW (ROW_ID, ROW_NUMBER)
VALUES ('80', '18'); 


--Create PAGES_HAVE_ROWS
INSERT INTO PAGES_HAVE_ROWS (ROW_ID, PAGE_ID)
VALUES ('10', '1');
INSERT INTO PAGES_HAVE_ROWS (ROW_ID, PAGE_ID)
VALUES ('20', '2');  
INSERT INTO PAGES_HAVE_ROWS (ROW_ID, PAGE_ID)
VALUES ('80', '8'); 

--Create BOOKS_HAVE_PAGES
INSERT INTO BOOKS_HAVE_PAGES (ROW_ID, PAGE_ID, BOOK_ID)
VALUES ('10', '1', '1');
INSERT INTO BOOKS_HAVE_PAGES (ROW_ID, PAGE_ID, BOOK_ID)
VALUES ('20', '2', '2');  
INSERT INTO BOOKS_HAVE_PAGES (ROW_ID, PAGE_ID, BOOK_ID)
VALUES ('80', '8', '3');
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO kuzina;
GRANT INSERT ANY TABLE TO kuzina;
GRANT ALTER ANY TABLE TO kuzina;
GRANT SELECT ANY TABLE TO kuzina





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT
    cust_name
FROM
    orders,
    orderitems,
    customers
WHERE
    item_price IN (
        SELECT
            MAX(item_price)
        FROM
            orderitems
    )
    AND   customers.cust_id = orders.cust_id
    AND   orders.order_num = orderitems.order_num;


PROJECT 
(Orders TIMES OrderItems TIMES CUSTOMERS
WHERE (item_price in ( PROJECT (orderitems) (max(item_price))) AND customers.cust_id = orders.cust_id
AND orders.order_num = orderitems.order_num)
)(cust_name)














/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть покупці має найкоротшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT DISTINCT
    ( cust_country )
FROM
    customers
WHERE
    length(TRIM(cust_country) ) IN (
        SELECT
            MIN(length(TRIM(cust_country) ) )
        FROM
            customers
    );















/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name, для тих покупців, що мають замовлення, але воно порожнє (нема orderitems). 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
    TRIM(cust_country)
    || ' '
    || TRIM(cust_email) AS "CLIENT_NAME"
FROM
    customers
WHERE
    cust_id IN (
        SELECT
            cust_id AS "CUST_ID"
        FROM
            customers
        MINUS
        SELECT DISTINCT
            orders.cust_id AS "CUST_ID"
        FROM
            orders
    );


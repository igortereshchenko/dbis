-- LABORATORY WORK 1
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Beshta IDENTIFIED BY beshta
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER Beshta QUOTA 100M ON USERS;

GRANT "CONNECT" TO BESHTA;

GRANT ALTER ANY TABLE TO Beshta

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Книжка складається з сторінок, на яких є рядки тексту.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     18.04.2018 18:24:06                          */
/*==============================================================*/
/*==============================================================*/
/* Table: book                                                  */
/*==============================================================*/
CREATE TABLE book (
    book_id       NUMBER(6) NOT NULL,
    book_name     VARCHAR2(20) NOT NULL,
    book_author   VARCHAR2(20) NOT NULL,
    book_year     NUMBER(6) NOT NULL,
    CONSTRAINT pk_book PRIMARY KEY ( book_id )
);

/*==============================================================*/
/* Table: book_page                                             */
/*==============================================================*/

CREATE TABLE book_page (
    page_id       NUMBER(6) NOT NULL,
    book_id       NUMBER(6) NOT NUll,
    page_number   NUMBER(6) NOT NULL,
    CONSTRAINT pk_book_page PRIMARY KEY ( page_id )
);

/*==============================================================*/
/* Index: "book has pages_FK"                                   */
/*==============================================================*/

CREATE INDEX "book has pages_FK" ON
    book_page ( book_id ASC );

/*==============================================================*/
/* Table: cover_book                                            */
/*==============================================================*/

CREATE TABLE cover_book (
    cover_id         NUMBER(6) NOT NULL,
    book_id          NUMBER(6) NOT NULL,
    cover_color      VARCHAR2(10) NOT NULL,
    cover_hardness   NUMBER(2) NOT NULL,
    CONSTRAINT pk_cover_book PRIMARY KEY ( cover_id )
);

/*==============================================================*/
/* Index: "book has covers_FK"                                  */
/*==============================================================*/

CREATE INDEX "book has covers_FK" ON
    cover_book ( book_id ASC );

/*==============================================================*/
/* Table: page_row                                              */
/*==============================================================*/

CREATE TABLE page_row (
    row_id       NUMBER(6) NOT NULL,
    page_id      NUMBER(6) NOT NULL,
    row_number   NUMBER(6) NOT NULL,
    CONSTRAINT pk_page_row PRIMARY KEY ( row_id )
);

/*==============================================================*/
/* Index: "page has row_FK"                                     */
/*==============================================================*/

CREATE INDEX "page has row_FK" ON
    page_row ( page_id ASC );

ALTER TABLE book_page
    ADD CONSTRAINT "FK_BOOK_PAG_BOOK HAS _BOOK" FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE cover_book
    ADD CONSTRAINT "FK_COVER_BO_BOOK HAS _BOOK" FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE page_row
    ADD CONSTRAINT "FK_PAGE_ROW_PAGE HAS _BOOK_PAG" FOREIGN KEY ( page_id )
        REFERENCES book_page ( page_id );
        
        
/*==============================================================*/
/* CONSTRAINT CHECK                                             */
/*==============================================================*/


ALTER TABLE book
    ADD CONSTRAINT book_id_chek CHECK (book_id>0);

ALTER TABLE book
    ADD CONSTRAINT book_name_chek CHECK ( REGEXP_LIKE (book_name,
    '(\s?\w+)+' ) );
ALTER TABLE book
    ADD CONSTRAINT book_year_chek CHECK ( book_year>0);

ALTER TABLE book
    ADD CONSTRAINT book_author_chek CHECK ( REGEXP_LIKE ( book_author,
    '(\s?\w+)+'));

ALTER TABLE book_page
    ADD CONSTRAINT page_id_chek CHECK (page_id>0);

ALTER TABLE book_page
    ADD CONSTRAINT page_number_chek CHECK ( page_number>0);

ALTER TABLE page_row
    ADD CONSTRAINT row_id_chek CHECK (row_id>0);

ALTER TABLE page_row
    ADD CONSTRAINT row_number_chek CHECK (row_number>0);

ALTER TABLE cover_book
    ADD CONSTRAINT cover_id_chek CHECK ( cover_id>0);
    
ALTER TABLE cover_book
        ADD CONSTRAINT cover_color_chek CHECK ( REGEXP_LIKE (cover_color,
    '(\s?\w+)+' ) );

ALTER TABLE cover_book
    ADD CONSTRAINT cover_hardness_chek CHECK ( cover_hardness>0);

/*==============================================================*/
/*               INSERT to TABLE                                */
/*==============================================================*/
INSERT INTO book(book_id, book_name, book_author, book_year)
VALUES('100001', 'Harry Potter', 'J.K. Rowling', '1998');
INSERT INTO book(book_id, book_name, book_author, book_year)
VALUES('100002', 'The Long Goodbye', 'Raymond Chandler', '1705');
INSERT INTO book(book_id, book_name, book_author, book_year)
VALUES('100003', 'The Sun Also Rises', 'Ernest Hemingway', '1954');
INSERT INTO book(book_id, book_name, book_author, book_year)
VALUES('100004', 'Things Fall Apart', 'Chinua Achebe', '2001');

INSERT INTO book_page (page_id,book_id,page_number)
VALUES('1111','100001', '0001');
INSERT INTO book_page (page_id,book_id ,page_number)
VALUES('2222','100002', '0002');
INSERT INTO book_page (page_id,book_id ,page_number)
VALUES('3333','100003', '0003');
INSERT INTO book_page (page_id,book_id ,page_number)
VALUES('4444','100004', '0004');

INSERT INTO page_row (row_id,page_id, row_number)
VALUES('101','1111','001');
INSERT INTO page_row (row_id,page_id, row_number)
VALUES('102','2222','002');
INSERT INTO page_row (row_id,page_id, row_number)
VALUES('103','3333','003');
INSERT INTO page_row (row_id,page_id, row_number)
VALUES('104','4444','004');

INSERT INTO cover_book (cover_id, book_id,cover_color,cover_hardness)
VALUES('2000','100001', 'Black','7');
INSERT INTO cover_book (cover_id, book_id,cover_color,cover_hardness)
VALUES('3000','100002', 'Blue','8');
INSERT INTO cover_book (cover_id, book_id,cover_color,cover_hardness)
VALUES('5000','100003', 'Yellow','25');
INSERT INTO cover_book (cover_id, book_id,cover_color,cover_hardness)
VALUES('7000','100004', 
  
/* ---------------------------------------------------------------------------
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць,
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT.
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити:

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO Beshta;
GRANT SELECT ANY TABLE TO Beshta;
GRANT INSERT ANY TABLE TO Beshta;


/---------------------------------------------------------------------------
3.a.
Як звуть покупця, що купив найдорожчий товар.
Виконати завдання в Алгебрі Кодда.
4 бали
---------------------------------------------------------------------------/

--Код відповідь:
PROJECT (    
    CUSTOMERS TIMES ORDERS TIMES ORDERITEMS
    WHERE ( 
        CUSTOMERS.cust_id = ORDERS.cust_id AND
        ORDERS.order_num = ORDERITEMS.order_num AND
        ORDERITEMS.item_price = (
            PROJECT (
                ORDERITEMS
            ) {MAX(item_price)}        
        )
    )
) {CUSTOMERS.cust_name)};

/*---------------------------------------------------------------------------
3.b.
Яка країна, у якій живуть покупці має найкоротшу назву?
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT
    MIN(cust_country) AS min_name
FROM
    customers;

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
    SELECT CUST_ID AS "CUST_ID"
    FROM CUSTOMERS
    
    MINUS 
    
    SELECT DISTINCT ORDERS.CUST_ID AS "CUST_ID"
    FROM ORDERS
);
  
-- BY Beshta_Vladyslav

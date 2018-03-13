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

ALTER USER Beshta QUOTA 100M ON USER;

GRANT "CONNECT" TO BESHTA;

GRANT ALTER ANY TABLE TO Beshta

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Книжка складається з сторінок, на яких є рядки тексту.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE BOOK(
book_name VARCHAR(30) NOT NULL
);

ALTER TABLE BOOK ADD CONSTRAINT pk_book_name PRIMARY KEY(book_name);

CREATE TABLE BOOK_PAGE(
book_page NUMBER (3) NOT NULL
);

ALTER TABLE BOOK_PAGE ADD CONSTRAINT pk_book_page PRYMARY KEY (book_page);

CREATE TABLE PAGE_ROW(
book_name_fk VARCHAR(30) NOT NULL,
book_page_fk NUMBER (3) NOT NULL,
page_row VARCHAR2(500) NOT NULL
);

ALTER TABLE PAGE_ROW ADD CONSTRAINT book_name_fk FOREIGN KEY (book_name) REFERENCES BOOK (book_name);

ALTER TABLE PAGE_ROW ADD CONSTRAINT book_page_fk FOREIGN KEY (book_name) REFERENCES BOOK (book_page);

ALTER TABLE PAGE_ROW ADD CONSTRAINT page_row_pk PRIMARY KEY (row_page);
  
-- BY Beshta_Vladyslav

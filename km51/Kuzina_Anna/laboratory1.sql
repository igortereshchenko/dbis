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

CREATE TABLE BOOK(
  book_name VARCHAR(30) NOT NULL
);
ALTER TABLE BOOK
  ADD CONSTRAINT book_pk PRIMARY KEY (book_name);

CREATE TABLE PAGE(
  page_name VARCHAR(30) NOT NULL
);
ALTER TABLE  PAGE
  ADD CONSTRAINT page_pk PRIMARY KEY (paget_name);  


CREATE TABLE BOOK_PAGE(
  book_name_fk VARCHAR(30) NOT NULL,
  page_name_fk VARCHAR(30) NOT NULL,
  page_row NUMBER(8) NOT NULL
);

ALTER TABLE  BOOK_PAGE
  ADD CONSTRAINT book_page_pk PRIMARY KEY (book_name_fk,page_name_fk);  
  
ALTER TABLE  BOOK_PAGE
  ADD CONSTRAINT book_fk FOREIGN KEY (book_name_fk ) REFERENCES BOOK (book_name);
  
ALTER TABLE  BOOK_PAGE
  ADD CONSTRAINT page_fk FOREIGN KEY (page_name_fk) REFERENCES PAGE (page_name);















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO kuzina;
GRANT INSERT ANY TABLE TO kuzina;
GRANT ALTER ANY TABLE TO kuzina;






/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть покупці має найкоротшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name, для тих покупців, що мають замовлення, але воно порожнє (нема orderitems). 
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


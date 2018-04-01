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

CREATE TABLE BOOKS(
book_name VARCHAR(20),
book_id NUMBER(6) NOT NULL
);

CREATE TABLE BOOK_PAGE(
page_number NUMBER(6) NOT NULL,
fk_book_id NUMBER(6) NOT NULL,
page_id NUMBER(6) NOT NULL
);

CREATE TABLE BOOK_ROW(
page_row VARCHAR2(200),
fk_page_id NUMBER(6) NOT NULL
);

ALTER TABLE  BOOKS
  ADD CONSTRAINT book_id_pk PRIMARY KEY (book_id); 
  
ALTER TABLE  BOOK_PAGE
  ADD CONSTRAINT page_id_pk PRIMARY KEY (page_id);
  
ALTER TABLE BOOK_PAGE
  ADD CONSTRAINT book_id_fk FOREIGN KEY (fk_book_id)
  REFERENCES BOOKS (book_id);
  
ALTER TABLE BOOK_ROW
  ADD CONSTRAINT fk_page_id FOREIGN KEY (fk_page_id)
  REFERENCES BOOK_PAGE (page_id);
  
/* ---------------------------------------------------------------------------
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць,
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT.
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити:

---------------------------------------------------------------------------*/
--Код відповідь:

/---------------------------------------------------------------------------
3.a.
Як звуть покупця, що купив найдорожчий товар.
Виконати завдання в Алгебрі Кодда.
4 бали
---------------------------------------------------------------------------/

--Код відповідь:
SELECT CUST_NAME FROM CUSTOMERS
  WHERE CUST_ID IN (SELECT CUST_ID FROM ORDERS
    WHERE ORDER_NUM IN (SELECT ORDER_NUM FROM ORDERITEMS
      WHERE PROD_ID IN (SELECT PROD_ID FROM PRODUCTS
        WHERE PROD_PRICE IN (SELECT MAX(PROD_PRICE)FROM PRODUCTS))));

/*---------------------------------------------------------------------------
3.b.
Яка країна, у якій живуть покупці має найкоротшу назву?
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT CUST_COUNTRY {Customers}
WHERE LEN(CUST_COUNTRY) = MIN(
PROJECT LEN(CUST_COUNTRY) {Customers});

/*---------------------------------------------------------------------------
c.
Вивести країну та пошту покупця, як єдине поле client_name, для тих покупців, що мають замовлення, але воно порожнє (нема orderitems).
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
 PROJECT CUST_COUNTRY,CUST_EMAIL {Customers}
WHERE CUST_ID IN(
(PROJECT CUST_ID {Orders TIMES Orderitems}
WHERE Orders.ORDER_NUM = Orderitems.ORDER_NUM AND QUANITY=0); 
  
-- BY Beshta_Vladyslav

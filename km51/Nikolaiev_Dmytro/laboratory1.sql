-- LABORATORY WORK 1
-- BY Nikolaiev_Dmytro
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

Create User Nikolaev identified by nikolaev;
Grant CREATE ANY TABLE to Nikolaev;
Create Role "Connect";
Grant "Connect" to Nikolaev;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE table humans (
human_name char NOT NULL,  timbre varchar2(15) NOT NULL, age int NOT NULL
);

CREATE table songs (
song_name char NOT NULL, song_performer varchar2(30) NOT NULL
);

ALTER TABLE humans 
ADD Constraint human_pk Primary key (human_name);

Alter table songs 
ADD Constraint song_pk Primary Key (song_name);

CREATE TABLE SONG_HUMAN
(human_name_fk CHAR(30) NOT NULL,
song_fk CHAR(30) NOT NULL,
lines_amount NUMBER(2) NOT NULL);
ALTER TABLE SONG_HUMAN
ADD CONSTRAINT human_song_pk PRIMARY KEY (human_name_fk, song_fk);

ALTER TABLE SONG_HUMAN
ADD CONSTRAINT human_fk FOREIGN KEY (human_name_fk) REFERENCES humans (human_name);
ALTER TABLE SONG_HUMAN 
ADD CONSTRAINT songname_fk FOREIGN KEY (song_fk) REFERENCES songs (song_name);















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE Any table to  Nikolaev
GRANT SELECT any table to Nikolaev
GRANT INSERT any table to Nikoalev;





/*---------------------------------------------------------------------------
3.a. 
Скільки проданого найдорожчого товару?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

Select sum(quantity) FROM ORDERITEMS
WHERE ITEM_PRICE = 
(Select Max(ITEM_PRICE) FROM ORDERITEMS);















/*---------------------------------------------------------------------------
3.b. 
Який PROD_ID товару, з найкоротшою назвою?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

Select prod_id, length(TRIM(prod_name)) as "name_length"
FROM PRODUCTS
WHERE length(trim(prod_name)) =
(Select min(length(trim(prod_name))) FROM PRODUCTS)
;












/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT (vendors) {upper(vendors.vend_name)}
where vendors.vend_name not in (
    PROJECT (vendors TIMES products) {vendors.vend_name}
    where vendors.vend_id=products.vend_id)

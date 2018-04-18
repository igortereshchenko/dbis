-- LABORATORY WORK 1
-- BY Kharytonchyk_Oleksandr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER кharytonchyk
IDENTIFIED BY 12345
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER kharrytonchyk QUOTA 100M ON USERS;

GRANT "CONNECT" TO tereshchenko ;
GRANT CREATE ANY TABLE TO tereshchenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     18.04.2018 23:21:45                          */
/*==============================================================*/


alter table human_sings_song
   drop constraint FK_SINGER_SINGS_SONG;

alter table human_sings_song
   drop constraint FK_SINGER_SONG;

alter table human_writes_song
   drop constraint FK_AUTHOR_SONG;

alter table human_writes_song
   drop constraint FK_AUTOR_WROTE_SONG;

drop table Human cascade constraints;

drop table Song cascade constraints;

drop index human_sings_song_FK;

drop index human_sings_song2_FK;

drop table human_sings_song cascade constraints;

drop index human_writes_song_FK;

drop index human_writes_song2_FK;

drop table human_writes_song cascade constraints;

/*==============================================================*/
/* Table: Human                                                 */
/*==============================================================*/
create table Human 
(
   human_identific_number NUMBER(10)           not null,
   human_name           VARCHAR2(30)         not null,
   human_surname        VARCHAR2(30)         not null,
   constraint PK_HUMAN primary key (human_identific_number)
);

/*==============================================================*/
/* Table: Song                                                  */
/*==============================================================*/
create table Song 
(
   song_title           VARCHAR2(50)         not null,
   song_release_year    DATE                 not null,
   song_album           VARCHAR2(50),
   song_duration        NUMBER(5),
   constraint PK_SONG primary key (song_title, song_release_year)
);

/*==============================================================*/
/* Table: human_sings_song                                      */
/*==============================================================*/
create table human_sings_song 
(
   song_title           VARCHAR2(50)         not null,
   song_release_year    DATE                 not null,
   human_identific_number NUMBER(10)           not null,
   sing_time            DATE                 not null,
   constraint PK_HUMAN_SINGS_SONG primary key (song_title, song_release_year, human_identific_number, sing_time)
);

/*==============================================================*/
/* Index: human_sings_song2_FK                                  */
/*==============================================================*/
create index human_sings_song2_FK on human_sings_song (
   human_identific_number ASC
);

/*==============================================================*/
/* Index: human_sings_song_FK                                   */
/*==============================================================*/
create index human_sings_song_FK on human_sings_song (
   song_title ASC,
   song_release_year ASC
);

/*==============================================================*/
/* Table: human_writes_song                                     */
/*==============================================================*/
create table human_writes_song 
(
   song_title           VARCHAR2(50)         not null,
   song_release_year    DATE                 not null,
   human_identific_number NUMBER(10)           not null,
   end_date             DATE,
   constraint PK_HUMAN_WRITES_SONG primary key (song_title, song_release_year, human_identific_number)
);

/*==============================================================*/
/* Index: human_writes_song2_FK                                 */
/*==============================================================*/
create index human_writes_song2_FK on human_writes_song (
   human_identific_number ASC
);

/*==============================================================*/
/* Index: human_writes_song_FK                                  */
/*==============================================================*/
create index human_writes_song_FK on human_writes_song (
   song_title ASC,
   song_release_year ASC
);

alter table human_sings_song
   add constraint FK_SINGER_SINGS_SONG foreign key (human_identific_number)
      references Human (human_identific_number)
      on delete cascade;

alter table human_sings_song
   add constraint FK_SINGER_SONG foreign key (song_title, song_release_year)
      references Song (song_title, song_release_year)
      on delete cascade;

alter table human_writes_song
   add constraint FK_AUTHOR_SONG foreign key (song_title, song_release_year)
      references Song (song_title, song_release_year)
      on delete cascade;

alter table human_writes_song
   add constraint FK_AUTOR_WROTE_SONG foreign key (human_identific_number)
      references Human (human_identific_number)
      on delete cascade;

alter table Human
add constraint human_identific_number_check check(regexp_like(human_identific_number,'^\d{10}$'));

alter table Human
add constraint human_name_check check(regexp_like(human_name,'^[A-Z][a-z]{1,29}$'));

alter table Human
add constraint human_surname_check check(regexp_like(human_surname,'^[A-Z][a-z]{1,29}$'));

alter table Song
add constraint song_title_check check(regexp_like(song_title,'^[A-Z][a-z]{1,49}$'));

alter table Song
add constraint song_release_year_check check(regexp_like(song_release_year,'^([1-9]|[12][0-9]|[31]|[30]).([A-Z]{3}).[1-2][0-9]{3}$'));

alter table Song
add constraint song_album_check check(regexp_like(song_album,'^[A-Z][a-z]{1,49}$'));

alter table Song
add constraint song_duration_check check(regexp_like(song_duration,'^\d{1,5}$'));

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

--Код reviewer`a:
GRANT INSERT ANY TABLE TO KHARITONCHYK ;
GRANT SELECT ANY TABLE TO KHARITONCHYK;

--Виправлений код:
GRANT CREATE ANY TABLE TO Kharytonchyk;
GRANT INSERT ANY TABLE TO Kharytonchyk;
GRANT SELECT ANY TABLE TO Kharytonchyk;

/*---------------------------------------------------------------------------
3.a. 
Скільки проданого найдорожчого товару?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

--Код reviewer`a:
SELECT SUM(QUANTITY)
FROM ORDERITEMS
WHERE ORDERITEMS.ITEM_PRICE = (SELECT MAX(ITEM_PRICE)
                                FROM ORDERITEMS);
                                
--Виправлений код:                              
SELECT
    SUM(quantity)
FROM
    orderitems
WHERE
    prod_id IN (
                SELECT
                    prod_id
                FROM
                    orderitems
                WHERE
                    item_price = (
                                    SELECT
                                        MAX(item_price)
                                    FROM
                                        orderitems
                                   )
              );

/*---------------------------------------------------------------------------
3.b. 
Який PROD_ID товару, з найкоротшою назвою?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

--Код reviewer`a:
SELECT PROD_ID 
FROM PRODUCTS
WHERE PRODUCTS.PROD_NAME = (SELECT  MAX(LENGTH(TRIM(PROD_NAME)))
                            FROM PRODUCTS);

--Виправлений код:
SELECT PROD_ID 
FROM PRODUCTS
WHERE LENGTH(TRIM(PROD_NAME)) = (SELECT  MAX(LENGTH(TRIM(PROD_NAME)))
                            FROM PRODUCTS);

/*---------------------------------------------------------------------------
3.c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

--Код reviewer`a:
PROJECT(VENDORS){VEND_NAME}
MINUS 
PROJECT(VENDORS TIMES PRODUCTS
WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID){VEND_NAME};

--Виправлений код:
PROJECT (VENDORS
        WHERE VENDORS.VEND_ID NOT IN (PROJECT(PRODUCTS){ distinct PRODUCTS.VEND_ID}) 
    ){ DISTINCT RENAME(UPPER(TRIM(VENDORS.VEND_NAME)), "vendor_name")};
    

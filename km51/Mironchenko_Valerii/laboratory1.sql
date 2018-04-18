-- LABORATORY WORK 1
-- BY Mironchenko_Valerii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER mironchenko IDENTIFIED BY mironchenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER mironchenko QUOTA 100M ON USERS;

GRANT "CONNECT" TO mironchenko;

GRANT CREATE ANY TABLE TO mironchenko;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

drop table "Singer" cascade constraints;

/*==============================================================*/
/* Table: "Singer"                                              */
/*==============================================================*/
create table "Singer" 
(
   "singer_id"          NUMBER(10)           not null,
   "singer_first_name"  VARCHAR2(40),
   "singer_last_name"   VARCHAR2(40),
   "singer_age"         NUMBER(3),
   "singer_genre"       VARCHAR2(40),
   constraint PK_SINGER primary key ("singer_id")
);
/*--------------------------------------------------------------*/

drop table "Song" cascade constraints;

/*==============================================================*/
/* Table: "Song"                                                */
/*==============================================================*/
create table "Song" 
(
   "song_id"            NUMBER(10)           not null,
   "song_name"          VARCHAR2(40),
   "song_duration"      VARCHAR2(40),
   "song_temp"          VARCHAR2(40),
   "song_genre"         VARCHAR2(40),
   constraint PK_SONG primary key ("song_id")
);
/*--------------------------------------------------------------*/

alter table "Friend"
   drop constraint FK_FRIEND_FIRST_FRI_SINGER;

alter table "Friend"
   drop constraint FK_FRIEND_SECOND_FR_SINGER;

drop index "second_friend_FK";

drop index "first_friend_FK";

drop table "Friend" cascade constraints;

/*==============================================================*/
/* Table: "Friend"                                              */
/*==============================================================*/
create table "Friend" 
(
   "Sin_singer_id"      NUMBER(10)           not null,
   "singer_id"          NUMBER(10)           not null,
   "friend_id"          NUMBER(10)           not null,
   "friend_first_name"  VARCHAR2(40),
   "friend_last_name"   VARCHAR2(40),
   constraint PK_FRIEND primary key ("Sin_singer_id", "singer_id", "friend_id")
);

/*==============================================================*/
/* Index: "first_friend_FK"                                     */
/*==============================================================*/
create index "first_friend_FK" on "Friend" (
   "singer_id" ASC
);

/*==============================================================*/
/* Index: "second_friend_FK"                                    */
/*==============================================================*/
create index "second_friend_FK" on "Friend" (
   "Sin_singer_id" ASC
);

alter table "Friend"
   add constraint FK_FRIEND_FIRST_FRI_SINGER foreign key ("singer_id")
      references "Singer" ("singer_id");

alter table "Friend"
   add constraint FK_FRIEND_SECOND_FR_SINGER foreign key ("Sin_singer_id")
      references "Singer" ("singer_id");

/*--------------------------------------------------------------*/
alter table "The singer sings the song"
   drop constraint "FK_THE SING_THE SINGE_SONG";

alter table "The singer sings the song"
   drop constraint "FK_THE SING_THE SINGE_SINGER";

drop index "The singer sings the song_FK";

drop index "The singer sings the song2_FK";

drop table "The singer sings the song" cascade constraints;

/*==============================================================*/
/* Table: "The singer sings the song"                           */
/*==============================================================*/
create table "The singer sings the song" 
(
   "song_id"            NUMBER(10)           not null,
   "singer_id"          NUMBER(10)           not null,
   constraint "PK_THE SINGER SINGS THE SONG" primary key ("song_id", "singer_id")
);

/*==============================================================*/
/* Index: "The singer sings the song2_FK"                       */
/*==============================================================*/
create index "The singer sings the song2_FK" on "The singer sings the song" (
   "singer_id" ASC
);

/*==============================================================*/
/* Index: "The singer sings the song_FK"                        */
/*==============================================================*/
create index "The singer sings the song_FK" on "The singer sings the song" (
   "song_id" ASC
);

alter table "The singer sings the song"
   add constraint "FK_THE SING_THE SINGE_SONG" foreign key ("song_id")
      references "Song" ("song_id");

alter table "The singer sings the song"
   add constraint "FK_THE SING_THE SINGE_SINGER" foreign key ("singer_id")
      references "Singer" ("singer_id");

  
  
/* —-------------------------------------------------------------------------
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць,
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT.
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити:
—-------------------------------------------------------------------------*/
—Код відповідь:

GRANT INSERT ANY TABLE mironchenko
GRANT SELECT ANY TABLE mironchenko
/---------------------------------------------------------------------------
3.a.
Скільки проданого найдорожчого товару?
Виконати завдання в SQL.
4 бали
—-------------------------------------------------------------------------/
—Код відповідь:

SELECT SUM(ORDERITEMS.QUANTITY) 
FROM ORDERITEMS
WHERE ORDERITEMS.ITEM_PRICE IN (
                                 SELECT MAX(ORDERITEMS.ITEM_PRICE)
                                 FROM ORDERITEMS
                               );
/---------------------------------------------------------------------------
3.b.
Який PROD_ID товару, з найкоротшою назвою?
Виконати завдання в SQL.
4 бали
—-------------------------------------------------------------------------/
—Код відповідь:

SELECT PRODUCTS.PROD_ID    
FROM PRODUCTS
WHERE LENGTH(TRIM(PRODUCTS.PROD_NAME)) IN (
                                             SELECT MIN(LENGTH(TRIM(PRODUCTS.PROD_NAME)))
                                             FROM PRODUCTS
                                          );
/---------------------------------------------------------------------------
c.
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда.
4 бали
—-------------------------------------------------------------------------/
—Код відповідь:

A = PROJECT (
             VENDORS TIMES PRODUCTS 
             WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID
            ) {vend_name}

B = PROJECT (VENDORS) {vend_name}

Answer = PROJECT (B MINUS A) {UPPER(RENAME(vend_name, "vendor_name"))}

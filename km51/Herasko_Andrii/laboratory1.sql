/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

--rewier's version
create user herasko IDENTIFIED by herasko;
grant create any table to herasko;

GRANT "CONNECT" TO herasko ;

DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER herasko QUOTA 200M ON USERS;

-- author's version
CREATE USER herasko IDENTIFIED BY herasko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER herasko QUOTA 200M ON USERS;

GRANT "CONNECT" TO herasko;
GRANT CREATE ANY TABLE TO herasko;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


/*==============================================================*/
/* Table: Author                                                */
/*==============================================================*/
create table Author 
(
   song_title           VARCHAR2(20)         not null,
   song_release_year    INTEGER              not null,
   person_id_number     INTEGER              not null,
   constraint PK_AUTHOR primary key (song_title, song_release_year, person_id_number)
);

alter table Author
	add constraint author_id_number_check check(regexp_like(person_id_number,'^[0-9]{6,10}$'));
alter table Author
	add constraint author_song_title_check check(regexp_like(song_title,'^[A-Za-z0-9#@%$&!* ]+$'));
alter table Author
	add constraint author_song_release_year_check check(regexp_like(song_release_year,'^[012][0-9]{3}$'));


/*==============================================================*/
/* Index: author_wrote_song_FK                                  */
/*==============================================================*/
create index author_wrote_song_FK on Author (
   person_id_number ASC
);

/*==============================================================*/
/* Index: author_song_FK                                        */
/*==============================================================*/
create index author_song_FK on Author (
   song_title ASC,
   song_release_year ASC
);

/*==============================================================*/
/* Table: Person                                                */
/*==============================================================*/
create table Person 
(
   person_id_number     INTEGER              not null,
   person_name          VARCHAR2(15),
   person_surname       VARCHAR2(15),
   constraint PK_PERSON primary key (person_id_number)
);

alter table Person
	add constraint person_name_check check(regexp_like(person_name,'^[A-Za-z ]+$'));
alter table Person
	add constraint person_surname_check check(regexp_like(person_surname,'^[A-Za-z ]+$'));
alter table Person
	add constraint person_id_number_check check(regexp_like(person_id_number,'^[0-9]{6,10}$'));

/*==============================================================*/
/* Table: Singer                                                */
/*==============================================================*/
create table Singer 
(
   person_id_number     INTEGER              not null,
   song_title           VARCHAR2(20)         not null,
   song_release_year    INTEGER              not null,
   constraint PK_SINGER primary key (person_id_number, song_title, song_release_year)
);

alter table Singer
	add constraint singer_id_number_check check(regexp_like(person_id_number,'^[0-9]{6,10}$'));
alter table Singer
	add constraint singer_song_title_check check(regexp_like(song_title,'^[A-Za-z0-9#@%$&!* ]+$'));
alter table Singer
	add constraint singer_song_release_year_check check(regexp_like(song_release_year,'^[012][0-9]{3}$'));


/*==============================================================*/
/* Index: singer_song_FK                                        */
/*==============================================================*/
create index singer_song_FK on Singer (
   song_title ASC,
   song_release_year ASC
);

/*==============================================================*/
/* Index: singer_sings_song_FK                                  */
/*==============================================================*/
create index singer_sings_song_FK on Singer (
   person_id_number ASC
);

/*==============================================================*/
/* Table: Song                                                  */
/*==============================================================*/
create table Song 
(
   song_title           VARCHAR2(20)         not null,
   song_album           VARCHAR2(20),
   song_release_year    INTEGER              not null,
   constraint PK_SONG primary key (song_title, song_release_year)
);

alter table Song
	add constraint song_title_check check(regexp_like(song_title,'^[A-Za-z0-9#@%$&!* ]+$'));
alter table Song
	add constraint song_album_check check(regexp_like(song_album,'^[A-Za-z0-9#@%$&!* ]+$'));
alter table Song
	add constraint song_release_year_check check(regexp_like(song_release_year,'^[012][0-9]{3}$'));

alter table Author
   add constraint FK_AUTHOR_SONG foreign key (song_title, song_release_year)
      references Song (song_title, song_release_year)
      on delete cascade;

alter table Author
   add constraint FK_AUTHOR_WROTE_SONG foreign key (person_id_number)
      references Person (person_id_number)
      on delete cascade;

alter table Singer
   add constraint FK_SINGER_SINGS_SONG foreign key (person_id_number)
      references Person (person_id_number)
      on delete cascade;

alter table Singer
   add constraint FK_SINGER_SONG foreign key (song_title, song_release_year)
      references Song (song_title, song_release_year)
      on delete cascade;

INSERT INTO Person(person_id_number, person_name, person_surname)
VALUES('67676767', 'John', 'Smith');

INSERT INTO Person(person_id_number, person_name, person_surname)
VALUES('67543637', 'Mary', 'Smith');

INSERT INTO Person(person_id_number, person_name, person_surname)
VALUES('35432555', 'Peter', 'Tramp');

INSERT INTO Song(song_title, song_album, song_release_year)
VALUES('Love', 'Back', '2007');

INSERT INTO Song(song_title, song_album, song_release_year)
VALUES('Kiss', 'Back', '2007');

INSERT INTO Song(song_title, song_album, song_release_year)
VALUES('Mercury', 'Ghoste', '2015');

INSERT INTO Singer(person_id_number, song_title, song_release_year)
VALUES('67543637','Mercury', '2015');

INSERT INTO Singer(person_id_number, song_title, song_release_year)
VALUES('67676767','Love', '2007');

INSERT INTO Singer(person_id_number, song_title, song_release_year)
VALUES('35432555','Love', '2007');

INSERT INTO Author(person_id_number, song_title, song_release_year)
VALUES('67543637','Mercury', '2015');

INSERT INTO Author(person_id_number, song_title, song_release_year)
VALUES('67676767','Love', '2007');

INSERT INTO Author(person_id_number, song_title, song_release_year)
VALUES('35432555','Love', '2007');




  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

grant insert any table to herasko;
grant select any table to herasko;



/*---------------------------------------------------------------------------
3.a. 
Скільки проданого найдорожчого товару?
Виконати завдання в SQL.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
FROM SUM(QUANTITY), ORDERITEMS
WHERE PROD_ID = (SELECT 
                  FROM  PROD_ID,PRODUCTS 
                  WHERE PROD_PRICE = (SELECT
                                      FROM MAX(PROD_PRICE), PRODUCTS);

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

SELECT 
FROM PROD_ID, PRODUCTS
WHERE LENGTH(REPLACE(PROD_NAME, ' ', '') )  = (SELECT 
                  FROM  MIN(LENGTH(REPLACE(PROD_NAME, ' ', '') )),PRODUCTS );
                                              
SELECT
    prod_id
FROM
    products
WHERE
    length(TRIM(prod_name) ) = (
        SELECT
            MIN(length(TRIM(prod_name) ) )
        FROM
            products
    );       



/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
  PROJECT (VENDORS
        WHERE VEND_ID IN (PROJECT(VENDORS){VEND_ID}) 
    ){ RENAME(UPPER(VEND_NAME), "vendor_name")}  

MINUS 
PROJECT(PRODUCTS){VEND_ID};                
                 
                 
 PROJECT (VENDORS
        WHERE VENDORS.VEND_ID NOT IN (PROJECT(PRODUCTS){ distinct PRODUCTS.VEND_ID}) 
    ){ DISTINCT RENAME(UPPER(TRIM(VENDORS.VEND_NAME)), "vendor_name")}                 


-- LABORATORY WORK 1
-- BY Kurshakov_Mykhailo
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Kurshakov IDENTIFIED BY 123456
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER Kurshakov QUOTA 100M ON USERS;

GRANT "CONNECT" TO Kurshakov;

GRANT INSERT ANY TABLE TO Kurshakov;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина танцює під музику.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

/*==============================================================*/
/* Table: BirthYear                                             */
/*==============================================================*/
create table BirthYear 
(
   birth_year           DATE                 not null,
   constraint PK_BIRTHYEAR primary key (birth_year)
);

/*==============================================================*/
/* Table: Music                                                 */
/*==============================================================*/
create table Music 
(
   music_title          VARCHAR2(100)        not null,
   music_genre          VARCHAR2(50)         not null,
   constraint PK_MUSIC primary key (music_title)
);

/*==============================================================*/
/* Table: MusicInfo                                             */
/*==============================================================*/
create table MusicInfo 
(
   music_author2        VARCHAR2(100)        not null,
   music_year           DATE                 not null,
   constraint PK_MUSICINFO primary key (music_author2)
);

/*==============================================================*/
/* Table: Person                                                */
/*==============================================================*/
create table Person 
(
   nick_name            VARCHAR2(50)         not null,
   birth_year_fk        DATE                 not null,
   person_name          VARCHAR2(50)         not null,
   person_surname       VARCHAR2(50)         not null,
   constraint PK_PERSON primary key (nick_name)
);

/*==============================================================*/
/* Table: "info about music"                                    */
/*==============================================================*/
create table "info about music" 
(
   music_title          VARCHAR2(100)        not null,
   music_author2        VARCHAR2(100)        not null,
   constraint "PK_INFO ABOUT MUSIC" primary key (music_title, music_author2)
);

/*==============================================================*/
/* Table: "person dancing"                                      */
/*==============================================================*/
create table "person dancing" 
(
   music_title          VARCHAR2(100)        not null,
   nick_name            VARCHAR2(50)         not null,
   constraint "PK_PERSON DANCING" primary key (music_title, nick_name)
);


alter table Person
   add constraint "FK_PERSON_PERSON BI_BIRTHYEA" foreign key (birth_year_fk)
      references BirthYear (birth_year);

alter table "info about music"
   add constraint "FK_INFO ABO_INFO ABOU_MUSIC" foreign key (music_title)
      references Music (music_title);

alter table "info about music"
   add constraint "FK_INFO ABO_INFO ABOU_MUSICINF" foreign key (music_author2)
      references MusicInfo (music_author2);

alter table "person dancing"
   add constraint "FK_PERSON D_PERSON DA_MUSIC" foreign key (music_title)
      references Music (music_title);

alter table "person dancing"
   add constraint "FK_PERSON D_PERSON DA_PERSON" foreign key (nick_name)
      references Person (nick_name);

ALTER TABLE BIRTHYEAR
    ADD CONSTRAINT BIRTH_YEAR_CHEK CHECK (REGEXP_LIKE(BIRTH_YEAR, '^(0[1-9]|[12][0-9]|3[01])[-.]([A-Z]{1,3})[-.]\d\d$'));

ALTER TABLE MUSIC
    ADD CONSTRAINT MUSIC_TITLE_CHEK CHECK (REGEXP_LIKE(MUSIC_TITLE, '^\S[A-z_0-9- ().]{1,100}\S$'));
ALTER TABLE MUSIC
    ADD CONSTRAINT MUSIC_GENRE_CHEK CHECK (REGEXP_LIKE(MUSIC_GENRE, '^[A-Z][A-z_0-9- \]{1,50}\S$'));

ALTER TABLE MUSICINFO
    ADD CONSTRAINT MUSIC_AUTHOR2_CHEK CHECK (REGEXP_LIKE(MUSIC_AUTHOR2, '^\S[A-z_0-9- ().]{1,100}\S$'));   
ALTER TABLE MUSICINFO
    ADD CONSTRAINT MUSIC_YEAR_CHEK CHECK (REGEXP_LIKE(MUSIC_YEAR, '^(0[1-9]|[12][0-9]|3[01])[-.]([A-Z]{1,3})[-.]\d\d$'));

ALTER TABLE PERSON
    ADD CONSTRAINT NICK_NAME_CHEK CHECK (REGEXP_LIKE(NICK_NAME, '^[A-Z0-9a-z_]{1,50}$'));
ALTER TABLE PERSON
    ADD CONSTRAINT PERSON_NAME_CHEK CHECK (REGEXP_LIKE(PERSON_NAME, '^[A-Z][a-z]{1,49}$'));
ALTER TABLE PERSON
    ADD CONSTRAINT PERSON_SURNAME_CHEK CHECK (REGEXP_LIKE(PERSON_SURNAME, '^[A-Z][a-z]{1,49}'));
    
    
    
    INSERT INTO BIRTHYEAR (BIRTH_YEAR)
VALUES(TO_DATE('1990-01-01', 'yyyy-mm-dd'));
INSERT INTO BIRTHYEAR (BIRTH_YEAR)
VALUES(TO_DATE('1991-02-02', 'yyyy-mm-dd'));
INSERT INTO BIRTHYEAR (BIRTH_YEAR)
VALUES(TO_DATE('1992-03-03', 'yyyy-mm-dd'));

INSERT INTO MUSIC (MUSIC_TITLE,MUSIC_GENRE)
VALUES('First composition.', 'Rock');
INSERT INTO MUSIC (MUSIC_TITLE,MUSIC_GENRE)
VALUES('Second composition.', 'Jazz');
INSERT INTO MUSIC (MUSIC_TITLE,MUSIC_GENRE)
VALUES('Third composition.', 'Alternative');


INSERT INTO MUSICINFO (MUSIC_AUTHOR2,MUSIC_YEAR)
VALUES('First Author', TO_DATE('2000-01-01', 'yyyy-mm-dd'));
INSERT INTO MUSICINFO (MUSIC_AUTHOR2,MUSIC_YEAR)
VALUES('Second Author', TO_DATE('2001-02-02', 'yyyy-mm-dd'));
INSERT INTO MUSICINFO (MUSIC_AUTHOR2,MUSIC_YEAR)
VALUES('Third Author', TO_DATE('2002-03-03', 'yyyy-mm-dd'));

INSERT INTO PERSON (NICK_NAME,PERSON_NAME,PERSON_SURNAME,BIRTH_YEAR_FK)
VALUES('First_nick', 'Firstname','Firstsurname',TO_DATE('1990-01-01', 'yyyy-mm-dd'));
INSERT INTO PERSON (NICK_NAME,PERSON_NAME,PERSON_SURNAME,BIRTH_YEAR_FK)
VALUES('Second_nick', 'Secondname','Secondtsurname',TO_DATE('1991-02-02', 'yyyy-mm-dd'));
INSERT INTO PERSON (NICK_NAME,PERSON_NAME,PERSON_SURNAME,BIRTH_YEAR_FK)
VALUES('Third_nick', 'Thirdname','Thirdsurname',TO_DATE('1991-02-02', 'yyyy-mm-dd'));


INSERT INTO "info about music" (MUSIC_TITLE,MUSIC_AUTHOR2)
VALUES ('First composition.','First Author');
INSERT INTO "info about music" (MUSIC_TITLE,MUSIC_AUTHOR2)
VALUES ('Second composition.','First Author');
INSERT INTO "info about music" (MUSIC_TITLE,MUSIC_AUTHOR2)
VALUES ('Third composition.','Second Author');


INSERT INTO "person dancing" (MUSIC_TITLE,NICK_NAME)
VALUES ('First composition.','First_nick');
INSERT INTO "person dancing" (MUSIC_TITLE,NICK_NAME)
VALUES ('Second composition.','Third_nick');
INSERT INTO "person dancing" (MUSIC_TITLE,NICK_NAME)
VALUES ('Third composition.','Second_nick');




/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO Kurshakov;
GRANT SELECT ANY TABLE TO Kurshakov;
GRANT UPDATE ANY TABLE TO Kurshakov;


/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдорожчого товару?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT (ORDERITEMS TIMES PRODUCTS 
    WHERE ORDERITEMS.ITEM_PRICE = (PROJECT (ORDERITEMS) {MAX(ITEM_PRICE)}) 
        AND PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID){PROD_NAME}; 

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найкоротшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_CONTACT as "long_name" 
FROM CUSTOMERS
    WHERE LENGTH(TRIM(CUST_CONTACT)) = (SELECT MIN(LENGTH(TRIM(CUST_CONTACT))) FROM CUSTOMERS);






/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT CUSTOMERS.CUST_CONTACT||CUSTOMERS.CUST_EMAIL AS "client_name"
FROM CUSTOMERS
WHERE 
    (SELECT CUST_ID FROM CUSTOMERS
    MINUS
    SELECT DISTINCT CUST_ID FROM ORDERS) = CUSTOMERS.CUST_ID;

;


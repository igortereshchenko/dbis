/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER alukyanenko IDENTIFIED BY alukyanenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER alukyanenko QUOTA 100M on "USERS";
GRANT "CONNECT" TO alukyanenko;
GRANT INSERT ANY TABLE TO alukyanenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина танцює під музику.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

--Old version

CREATE TABLE USERS(
EMAIL VARCHAR(40) NOT NULL,
USER_NAME VARCHAR(30) NULL,
USER_LASTNAME VARCHAR(30) NULL,
SEX VARCHAR(30) NULL
);

ALTER TABLE USERS
    ADD CONSTRAINT USER_PK PRIMARY KEY (EMAIL);

ALTER TABLE USERS
    ADD CONSTRAINT EMAIL_CHECK CHECK (REGEXP_LIKE(EMAIL, '^[a-zA-Z0-9_.+-]{1,20}@[a-zA-Z0-9-]{1,15}\.[a-zA-Z0-9-.]{1,3}$'));
ALTER TABLE USERS
    ADD CONSTRAINT USER_NAME_CHECK CHECK (REGEXP_LIKE(USER_NAME, '^[A-Z][a-z]{1,29}$'));
ALTER TABLE USERS
    ADD CONSTRAINT USER_LASTNAME_CHECK CHECK (REGEXP_LIKE(USER_LASTNAME, '^[A-Z][a-z]{1,29}$'));
ALTER TABLE USERS
    ADD CONSTRAINT SEX_CHECK CHECK (REGEXP_LIKE(SEX, '^[A-Za-z]{1,30}$'));
    
CREATE TABLE MUSIC(
MUSIC_NAME VARCHAR(30) NOT NULL,
GENRE VARCHAR(30) NULL,
AUTHOR VARCHAR(30) NOT NULL,
DANCE_LEVEL NUMBER(1,0) NULL
);

ALTER TABLE MUSIC
    ADD CONSTRAINT MUSIC_NAME_CHECK CHECK (REGEXP_LIKE(MUSIC_NAME, '^[A-Za-z 0-9]{1,30}$'));
ALTER TABLE MUSIC
    ADD CONSTRAINT GENRE_CHECK CHECK (REGEXP_LIKE(GENRE, '^[A-Za-z -]{1,30}$'));
ALTER TABLE MUSIC
    ADD CONSTRAINT AUTHOR_CHECK CHECK (REGEXP_LIKE(AUTHOR, '^[A-Za-z -]{1,30}$'));
ALTER TABLE MUSIC
    ADD CONSTRAINT DANCE_LEVEL_CHECK CHECK (REGEXP_LIKE(DANCE_LEVEL, '^[0-9]{1}$'));

ALTER TABLE MUSIC
    ADD CONSTRAINT MUSIC_PK PRIMARY KEY (MUSIC_NAME, AUTHOR);

CREATE TABLE PLAYLIST(
EMAIL_FK VARCHAR(40) NOT NULL,
MUSIC_NAME_FK VARCHAR(30) NOT NULL,
AUTHOR_FK VARCHAR(30) NOT NULL,
PLAYLIST_NAME VARCHAR(30) NULL
);

ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_PK PRIMARY KEY (EMAIL_FK, MUSIC_NAME_FK, AUTHOR_FK);

ALTER TABLE PLAYLIST
    ADD CONSTRAINT EMAIL_FK_CHECK CHECK (REGEXP_LIKE(EMAIL_FK, '^[a-zA-Z0-9_.+-]{1,20}@[a-zA-Z0-9-]{1,15}\.[a-zA-Z0-9-.]{1,3}$'));
ALTER TABLE PLAYLIST
    ADD CONSTRAINT MUSIC_NAME_FK_CHECK CHECK (REGEXP_LIKE(MUSIC_NAME_FK, '^[A-Za-z 0-9]{1,30}$'));
ALTER TABLE PLAYLIST
    ADD CONSTRAINT AUTHOR_FK_CHECK CHECK (REGEXP_LIKE(AUTHOR_FK, '^[A-Za-z -]{1,30}$'));
ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_NAME_CHECK CHECK (REGEXP_LIKE(PLAYLIST_NAME, '^[A-Za-z 0-9]{1,30}$'));
    
CREATE TABLE USER_CONTACTS(
EMAIL_FK VARCHAR(40) NOT NULL,
CONTACT_EMAIL VARCHAR(40) NOT NULL,
CONTACT_NAME VARCHAR(30) NULL,
DATE_ADDED DATE NULL
);

ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT USER_CONTACTS_PK PRIMARY KEY (EMAIL_FK, CONTACT_EMAIL);

ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT EMAILCONT_FK_CHECK CHECK (REGEXP_LIKE(EMAIL_FK, '^[a-zA-Z0-9_.+-]{1,20}@[a-zA-Z0-9-]{1,15}\.[a-zA-Z0-9-.]{1,3}$'));
ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT CONTACT_EMAIL_FK_CHECK CHECK (REGEXP_LIKE(CONTACT_EMAIL, '^[a-zA-Z0-9_.+-]{1,20}@[a-zA-Z0-9-]{1,15}\.[a-zA-Z0-9-.]{1,3}$'));
ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT CONTACT_NAME_CHECK CHECK (REGEXP_LIKE(CONTACT_NAME, '^[A-Za-z 0-9]{1,30}$'));
ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT DATE_ADDED_CHECK CHECK (REGEXP_LIKE(DATE_ADDED, '^(0[1-9]|[12][0-9]|3[01])[-.]([A-Z]{1,3})[-.]\d\d$'));


ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_FK FOREIGN KEY (MUSIC_NAME_FK, AUTHOR_FK) REFERENCES MUSIC(MUSIC_NAME, AUTHOR);
ALTER TABLE PLAYLIST
    ADD CONSTRAINT PLAYLIST_USER_FK FOREIGN KEY (EMAIL_FK) REFERENCES USERS(EMAIL);

ALTER TABLE USER_CONTACTS
    ADD CONSTRAINT USER_CONTACTS_FK FOREIGN KEY (EMAIL_FK) REFERENCES USERS(EMAIL);
    
INSERT INTO USERS(EMAIL, USER_NAME, USER_LASTNAME, SEX)
VALUES('sales@villagetoys.com', 'John', 'Smith', 'male');
INSERT INTO USERS(EMAIL, USER_NAME, USER_LASTNAME, SEX)
VALUES('jjones@fun4all.com', 'Jim', 'Jones', 'male');
INSERT INTO USERS(EMAIL, USER_NAME, USER_LASTNAME, SEX)
VALUES('dstephens@fun4all.com', 'Denise', 'Stephens', 'male');

INSERT INTO MUSIC(MUSIC_NAME, GENRE, AUTHOR, DANCE_LEVEL)
VALUES('Its my life', 'rock', 'Bon Jovi', 5);
INSERT INTO MUSIC(MUSIC_NAME, GENRE, AUTHOR, DANCE_LEVEL)
VALUES('Summertime sadness', 'pop', 'Lana Del Rey', 3);
INSERT INTO MUSIC(MUSIC_NAME, GENRE, AUTHOR, DANCE_LEVEL)
VALUES('Desposito', 'pop', 'Louis Fonsie', 9);

INSERT INTO PLAYLIST(EMAIL_FK, MUSIC_NAME_FK, AUTHOR_FK, PLAYLIST_NAME)
VALUES('jjones@fun4all.com', 'Its my life', 'Bon Jovi', 'ROCK YOUR BODY');
INSERT INTO PLAYLIST(EMAIL_FK, MUSIC_NAME_FK, AUTHOR_FK, PLAYLIST_NAME)
VALUES('sales@villagetoys.com', 'Desposito', 'Louis Fonsie', 'Lets dance');
INSERT INTO PLAYLIST(EMAIL_FK, MUSIC_NAME_FK, AUTHOR_FK, PLAYLIST_NAME)
VALUES('dstephens@fun4all.com', 'Desposito', 'Louis Fonsie', 'Spanish songs');

INSERT INTO USER_CONTACTS(EMAIL_FK, CONTACT_EMAIL, CONTACT_NAME, DATE_ADDED)
VALUES('sales@villagetoys.com', 'jjones@fun4all.com', 'Jim', TO_DATE('2017-02-08', 'yyyy-mm-dd'));
INSERT INTO USER_CONTACTS(EMAIL_FK, CONTACT_EMAIL, CONTACT_NAME, DATE_ADDED)
VALUES('jjones@fun4all.com', 'sales@villagetoys.com', 'John', TO_DATE('2017-02-08', 'yyyy-mm-dd'));
INSERT INTO USER_CONTACTS(EMAIL_FK, CONTACT_EMAIL, CONTACT_NAME, DATE_ADDED)
VALUES('dstephens@fun4all.com', 'vanessa_paradi@gmail.com', 'Vanessa', TO_DATE('2000-05-30', 'yyyy-mm-dd'));

--Power Designer version

/*==============================================================*/
/* Table: MUSIC                                                 */
/*==============================================================*/
create table MUSIC 
(
   music_id             INTEGER              not null,
   music_name           VARCHAR2(30)         not null,
   music_author         VARCHAR2(30)         not null,
   music_genre          VARCHAR2(30),
   music_dance_lvl      NUMBER(1,0),
   constraint PK_MUSIC primary key (music_id)
);

/*==============================================================*/
/* Table: Music_in_playlist                                     */
/*==============================================================*/
create table Music_in_playlist 
(
   playlist_user_id_fk  INTEGER              not null,
   playlist_music_id_fk INTEGER              not null,
   playlist_id          INTEGER              not null,
   music_id             INTEGER              not null,
   constraint PK_MUSIC_IN_PLAYLIST primary key (playlist_user_id_fk, playlist_music_id_fk, playlist_id, music_id)
);

/*==============================================================*/
/* Index: Music_in_playlist2_FK                                 */
/*==============================================================*/
create index Music_in_playlist2_FK on Music_in_playlist (
   music_id ASC
);

/*==============================================================*/
/* Index: Music_in_playlist_FK                                  */
/*==============================================================*/
create index Music_in_playlist_FK on Music_in_playlist (
   playlist_id ASC
);

/*==============================================================*/
/* Table: PLAYLIST                                              */
/*==============================================================*/
create table PLAYLIST 
(
   playlist_id          INTEGER              not null,
   playlist_user_id_fk  INTEGER              not null,
   playlist_music_id_fk INTEGER              not null,
   playlist_name        VARCHAR2(30),
   constraint PK_PLAYLIST primary key (playlist_id)
);

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create table USERS 
(
   user_id              INTEGER              not null,
   user_email           VARCHAR2(40)         not null,
   user_name            VARCHAR2(30),
   user_lastname        VARCHAR2(30),
   user_sex             VARCHAR2(30),
   constraint PK_USERS primary key (user_id)
);

/*==============================================================*/
/* Table: USER_CONTACTS                                         */
/*==============================================================*/
create table USER_CONTACTS 
(
   user_contacts_id     INTEGER              not null,
   user_contacts_user_id_fk INTEGER              not null,
   user_contacts_contact_email VARCHAR2(40)         not null,
   user_contacts_name   VARCHAR2(30),
   user_contacts_date_added DATE,
   constraint PK_USER_CONTACTS primary key (user_contacts_id)
);

/*==============================================================*/
/* Table: User_has_contacts                                     */
/*==============================================================*/
create table User_has_contacts 
(
   user_contacts_id     INTEGER              not null,
   user_contacts_user_id_fk INTEGER              not null,
   user_id              INTEGER              not null,
   constraint PK_USER_HAS_CONTACTS primary key (user_contacts_id, user_contacts_user_id_fk, user_id)
);

/*==============================================================*/
/* Index: User_has_contacts2_FK                                 */
/*==============================================================*/
create index User_has_contacts2_FK on User_has_contacts (
   user_id ASC
);

/*==============================================================*/
/* Table: User_has_playlists                                    */
/*==============================================================*/
create table User_has_playlists 
(
   playlist_user_id_fk  INTEGER              not null,
   playlist_music_id_fk INTEGER              not null,
   playlist_id          INTEGER              not null,
   user_id              INTEGER              not null,
   constraint PK_USER_HAS_PLAYLISTS primary key (playlist_user_id_fk, playlist_music_id_fk, playlist_id, user_id)
);

/*==============================================================*/
/* Index: User_has_playlists2_FK                                */
/*==============================================================*/
create index User_has_playlists2_FK on User_has_playlists (
   user_id ASC
);

/*==============================================================*/
/* Index: User_has_playlists_FK                                 */
/*==============================================================*/
create index User_has_playlists_FK on User_has_playlists (
   playlist_id ASC
);

alter table Music_in_playlist
   add constraint FK_MUSIC_PLAYLIST foreign key (playlist_id)
      references PLAYLIST (playlist_id);

alter table Music_in_playlist
   add constraint FK_MUSIC_IN_PLAYLIST foreign key (music_id)
      references MUSIC (music_id);

alter table User_has_contacts
   add constraint FK_USER_CONTACTS foreign key (user_contacts_id)
      references USER_CONTACTS (user_contacts_id);

alter table User_has_contacts
   add constraint FK_USER_HAS_CONTACTS foreign key (user_id)
      references USERS (user_id);

alter table User_has_playlists
   add constraint FK_USER_PLAYLIST foreign key (playlist_id)
      references PLAYLIST (playlist_id);

alter table User_has_playlists
   add constraint FK_USER_HAS_PLAYLIST foreign key (user_id)
      references USERS (user_id);

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO alukyanenko;
GRANT INSERT ANY TABLE TO alukyanenko;
GRANT SELECT ANY TABLE TO alukyanenko;

/*---------------------------------------------------------------------------
3.a. 
Яка назва проданого найдорожчого товару?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT(orderitems TIMES products)
WHERE
    orderitems.item_price = (
        PROJECT(orderitems)
        {MAX(item_price)}
    )
    AND   orderitems.prod_id = products.prod_id
{products.prod_name}

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найкоротшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT DISTINCT
    cust_name AS "long_name"
FROM
    customers
WHERE
    length(TRIM(customers.cust_name) ) IN (
        SELECT
            MIN(length(TRIM(customers.cust_name) ) )
        FROM
            customers
    );

/*---------------------------------------------------------------------------
c. 
Вивести ім’я та пошту покупця, як єдине поле client_name, для тих покупців, що не мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
    TRIM(cust_name)
    || ' '
    || TRIM(cust_email) AS "client_name"
FROM
    customers
WHERE
    customers.cust_id NOT IN (
        SELECT
            cust_id
        FROM
            orders
    );

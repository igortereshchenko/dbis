-- LABORATORY WORK 1
-- BY Kollehina_Kateryna
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER kollehina identified by kollehina
default tablespace "USERS"
temporary tablespace "TEMP";

ALter user kollehina quota 100M  on USERS;

grant "Connect" to kollehina ;
grant Create any table to kollehina;
 
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

/*==============================================================*/
/* Table: human                                                 */
/*==============================================================*/
create table human 
(
   human_id             NUMBER(10)           not null,
   human_name           VARCHAR2(40)         not null,
   human_surname        VARCHAR2(40)         not null,
   human_birthday       DATE                 not null,
   constraint PK_HUMAN primary key (human_id)
);
alter table human
	add constraint human_id_check check(regexp_like(human_id,'^\d{10}$'));
alter table human
	add constraint human_name_check check(regexp_like(human_name, '^[A-Z]{1,1}[a-z]{0,39}$'));
alter table human
	add constraint human_surname_check check(regexp_like(human_surname, '^[A-Z]{1,1}[a-z]{0,39}$'));
alter table human
	add constraint human_birthday_check check(regexp_like(human_birthday,'^([1-9]|[12][0-9]|[31]|[30]).([A-Z]{3}).[1-2][0-9]{3}$'));

INSERT INTO human(human_id,human_name,human_surname,human_birthday) 
   VALUES ('2343444321','katya','kollehina',TO_DATE('2013-05-30', 'yyyy-mm-dd'));
INSERT INTO human(human_id,human_name,human_surname,human_birthday)  
   VALUES ('2312343444','vlad','radov',TO_DATE('2000-05-20', 'yyyy-mm-dd'));
INSERT INTO human(human_id,human_name,human_surname,human_birthday) 
   VALUES ('1232343444','petya','petrashyk',TO_DATE('2010-03-10', 'yyyy-mm-dd'));
INSERT INTO human(human_id,human_name,human_surname,human_birthday)  
   VALUES ('1432343444','lena','vasko',TO_DATE('2010-05-30', 'yyyy-mm-dd'));


/*==============================================================*/
/* Table: song                                                  */
/*==============================================================*/
create table song 
(
   song_id              NUMBER(10)           not null,
   song_name            VARCHAR2(40)         not null,
   song_genre           VARCHAR2(40)         not null,
   song_rating          VARCHAR2(10)         not null,
   song_duration        TIME                 not null,
   constraint PK_SONG primary key (song_id)
);
alter table song
	add constraint song_id_check check(regexp_like(song_id,'^\d{10}$'));
alter table song
	add constraint song_name_check check(regexp_like(song_name, '^[A-Z]{1,1}[a-z]{0,39}$'));
alter table song
	add constraint song_genre_check check(regexp_like(song_genre, '^(jazz|pop|hip-hop|classic|rock)$'));
alter table song
	add constraint song_rating_check check(regexp_like(song_rating,'^\d{10}$'));
alter table song
	add constraint song_duration_check check(regexp_like(song_duration,'^\d{1,5}$'));

INSERT INTO song(song_id,song_name,song_genre,song_rating,song_duration) 
   VALUES ('1234444321',' Never Be The Same','pop','2345','3.44');
INSERT INTO song(song_id,song_name,song_genre,song_rating,song_duration)
   VALUES ('2563444321','sunny','jazz','1245','2.35');
INSERT INTO song(song_id,song_name,song_genre,song_rating,song_duration)
   VALUES ('1143444321','yellow submarine','rock', '145','2.3');
INSERT INTO song(song_id,song_name,song_genre,song_rating,song_duration)
   VALUES ('1043444321','Its my life','rock', '745','3.43');
/*==============================================================*/
/* Table: human_sings_song                                    */
/*==============================================================*/
create table human_sings_song 
(
   song_id              NUMBER(10)           not null,
   human_id             NUMBER(10)           not null,
   song_sing_date           DATE                 not null,
   constraint PK_HUMAN_SINGS_SONG primary key (song_id, human_id, song_sing_date)
);
alter table human_sings_song
	add constraint song_sing_date_check check(regexp_like(song_sing_date,'^([1-9]|[12][0-9]|[31]|[30]).([A-Z]{3}).[1-2][0-9]{3}$'));
INSERT INTO human_sings_song(song_id,human_id,song_sing_date) 
   VALUES ('4543444321','1033333454',TO_DATE('1998-08-20', 'yyyy-mm-dd'));
INSERT INTO human_sings_song(song_id,human_id,song_birth)
   VALUES ('1833444321','2334533454',TO_DATE('2011-05-23', 'yyyy-mm-dd'));
INSERT INTO human_sings_song(song_id,human_id,song_birth)
   VALUES ('1321444321','7263333454',TO_DATE('2010-11-20', 'yyyy-mm-dd'));
INSERT INTO human_sings_song(song_id,human_id,song_birth)
   VALUES ('0043444321','5412343444',TO_DATE('2007-12-20', 'yyyy-mm-dd'));
/*==============================================================*/
/* Index: human_sings_song2_FK                              */
/*==============================================================*/
create index human_sings_song2_FK on human_sings_song (
   human_id ASC
);

/*==============================================================*/
/* Index: human_sings_song_FK                                 */
/*==============================================================*/
create index human_sings_song_FK on human_sings_song (
   song_id ASC
);

alter table human_sings_song
   add constraint FK_HUMAN_SING_SONG foreign key (song_id)
      references song (song_id);

alter table human_sings_song
   add constraint FK_HUMAN_SING_SONG2 foreign key (human_id)
      references human (human_id);
/*==============================================================*/
/* Table: Human_wrote_song                                  */
/*==============================================================*/
create table Human_wrote_song
(
   song_id              NUMBER(10)           not null,
   human_id             NUMBER(10)           not null,
   song_birth       DATE                 not null,
   constraint PK_HUMAN_WROTE_SONG primary key (song_id, human_id, song_birth)
);
 
alter table Human_wrote_song
	add constraint song_birth_check check(regexp_like(song_birth,'^([1-9]|[12][0-9]|[31]|[30]).([A-Z]{3}).[1-2][0-9]{3}$'));
INSERT INTO Human_wrote_song(song_id,human_id,song_birth) 
   VALUES ('2343444321','0033333454',TO_DATE('1990-08-20', 'yyyy-mm-dd'));
INSERT INTO Human_wrote_song(song_id,human_id,song_birth)
   VALUES ('1763444321','2334533454',TO_DATE('2001-05-23', 'yyyy-mm-dd'));
INSERT INTO Human_wrote_song(song_id,human_id,song_birth)
   VALUES ('1343444321','2333333454',TO_DATE('2000-05-20', 'yyyy-mm-dd'));
INSERT INTO Human_wrote_song(song_id,human_id,song_birth)
   VALUES ('1043444321','1432343444',TO_DATE('2002-12-20', 'yyyy-mm-dd'));
/*==============================================================*/
/* Index: Human_wrote_song2_FK                                */
/*==============================================================*/
create index Human_wrote_song2_FK on Human_wrote_song (
   human_id ASC
);

/*==============================================================*/
/* Index: Human_wrote_song_FK                                */
/*==============================================================*/
create index Human_wrote_song_FK on Human_wrote_song (
   song_id ASC
);

alter table Human_wrote_song
   add constraint FK_HUMAN_WROTE_SONG2 foreign key (song_id)
      references song (song_id);

alter table Human_wrote_song
   add constraint FK_HUMAN_WROTE_SONG foreign key (human_id)
      references human (human_id);

3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць,
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT.
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити:
—-------------------------------------------------------------------------*/
—Код відповідь:

GRANT INSERT ANY TABLE kollehina
GRANT SELECT ANY TABLE kollehina
3.a.
Скільки проданого найдорожчого товару?
Виконати завдання в SQL.
4 бали
—-------------------------------------------------------------------------/
SELECT
    SUM(orderitems.quantity)
FROM
    orderitems
WHERE
    orderitems.item_price IN (
        SELECT
            MAX(orderitems.item_price)
        FROM
            orderitems
    );
    /---------------------------------------------------------------------------
3.a.
Скільки проданого найдорожчого товару?
Виконати завдання в SQL.
4 бали
—-------------------------------------------------------------------------/
SELECT
    SUM(quantity)
FROM
    Orderitems
WHERE
    item_price =(
        SELECT
            MAX(item_price)
        FROM
            Orderitems
    );

/---------------------------------------------------------------------------
3.b.
Який PROD_ID товару, з найкоротшою назвою?
Виконати завдання в SQL.
4 бали
—-------------------------------------------------------------------------/
SELECT
    prod_id
FROM
    Products
WHERE
    length(TRIM(prod_name) ) = (
        SELECT
            MIN(length(TRIM(prod_name) ) )
        FROM
            Products
    );
/*---------------------------------------------------------------------------
3 c.
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда.
4 бали

A = Project (Vendors) { Upper(vend_name)}
B =  Project (Vendors Times Products Where Vendors.vend_id = Products.vend_id) {Upper(vendors.vend_name)}
Answer = Project (A MINUS B) {RENAME(Upper(vend_name), vendor_name)}

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

create table Humans 
(
   human_name           VARCHAR2(40)         not null,
   human_age            NUMBER               not null,
   human_email          VARCHAR2(35),
   human_id             NUMBER               not null,
   constraint PK_HUMANS primary key (human_id)
);

CREATE SEQUENCE humans_seq
  START WITH 1
  INCREMENT BY 1;
  
Alter Table Humans ADD CONSTRAINT human_name_check CHECK (REGEXP_LIKE(human_name, '^[A-Z]{1,1}[a-z]{0,39}$'));
Alter Table Humans ADD CONSTRAINT human_age_check CHECK (REGEXP_LIKE(human_age, '^[/d]){3}$'));
Alter Table Humans ADD CONSTRAINT email_unique UNIQUE (human_email);

INSERT INTO Humans(human_name,human_age,human_email,human_id) VALUES ('Dmitriy','20','d1ma_nikolaev@ukr.net',humans_seq.nextval);
INSERT INTO Humans(human_name,human_age,human_email,human_id) VALUES ('Sergey','30','sergiy123@ukr.net',humans_seq.nextval);
INSERT INTO Humans(human_name,human_age,human_email,human_id) VALUES ('Anatoliy','44','tolyan@gmail.com',humans_seq.nextval);
INSERT INTO Humans(human_name,human_age,human_email,human_id) VALUES ('Vasiliy','20','vasya@gmail.com',humans_seq.nextval);
                                                                      
                                                                     
                                                                      
create table Songs 
(
   song_name            VARCHAR2(40)         not null,
   compositor_id        NUMBER,
   song_length          FLOAT                not null,
   song_genre           VARCHAR2(40),
   song_lyrics          VARCHAR2(800),
   constraint PK_SONGS primary key (song_name)
);

Alter Table Songs ADD CONSTRAINT song_name_check CHECK (REGEXP_LIKE(song_name, '^[A-Z]{1,1}[a-z]{0,39}$'));
Alter Table Songs ADD CONSTRAINT song_length_check CHECK (REGEXP_LIKE(song_length, '^[/d]){2}$'));
Alter Table Songs ADD CONSTRAINT song_genre CHECK (REGEXP_LIKE(song_genre, '^[A-Z]{1,1}[a-z]{0,39}$'));
Alter Table Songs ADD CONSTRAINT song_lyrics CHECK (REGEXP_LIKE(song_lyrics, '^[A-Z]{1,1}[a-z]{0,799}$'));

INSERT INTO Songs(song_name, compositor_id, song_length,song_genre,song_lyrics) VALUES ('Radioactive', (SELECT compositor_id FROM Compositors
                                                                                        Where compositor_name='Imagine Dragons'),'2','Indie Rock','Insert lyrics here ');
INSERT INTO Songs(song_name, compositor_id, song_length,song_genre,song_lyrics) VALUES ('Ace of Spades', (SELECT compositor_id FROM Compositors
                                                                                        Where compositor_name='Motorhead'),'2','Metal','Insert lyrics here ');
INSERT INTO Songs(song_name, compositor_id, song_length,song_genre,song_lyrics) VALUES ('Another Brick in the Wall', (SELECT compositor_id FROM Compositors
                                                                                        Where compositor_name='Pink_Floyd'),'2','Rock','Insert lyrics here ');
INSERT INTO Songs(song_name, compositor_id, song_length,song_genre,song_lyrics) VALUES ('Iron Man', (SELECT compositor_id FROM Compositors
                                                                                        Where compositor_name='Black Sabbath'),'2','Metal','Insert lyrics here ');


alter table Songs
   add constraint FK_SONGS_COMPOSITO_COMPOSIT foreign key (compositor_id)
      references Compositor (compositor_id);
create table HUMAN_SING_SONG 
(
   song_name            VARCHAR2(40)         not null,
   human_id             NUMBER               not null,
   constraint PK_HUMAN_SING_SONG primary key (song_name, human_id)
);


alter table HUMAN_SING_SONG
   add constraint FK_HUMAN_SI_HUMAN_SIN_SONGS foreign key (song_name)
      references Songs (song_name);

alter table HUMAN_SING_SONG
   add constraint FK_HUMAN_SI_HUMAN_SIN_HUMANS foreign key (human_id)
      references Humans (human_id);
create table Compositor 
(
   compositor_id        NUMBER               not null,
   compositor_name      VARCHAR2(40)       not null,
   compositor_age       NUMBER               not null,
   compositor_written_songs NUMBER,
   constraint PK_COMPOSITOR primary key (compositor_id)
);

CREATE SEQUENCE compositor_seq
  START WITH 1
  INCREMENT BY 1;
  
Alter Table Compositor ADD CONSTRAINT compos_name_check CHECK (REGEXP_LIKE(compositor_name, '^[A-Z]{1,1}[a-z]{0,39}$'));
Alter Table Compositor ADD CONSTRAINT compos_age_check CHECK (REGEXP_LIKE(compositor_age, '^[/d]){3}$'));
Alter Table Compositor ADD CONSTRAINT compos_songs_check CHECK(REGEXP_LIKE(compositor_written_songs, '^[/d]){4}$'));

INSERT INTO Compositor(compositor_id, compositor_name, compositor_age, compositor_written_songs) VALUES (compositor_seq.nextval,'Motorhead','30','50');
INSERT INTO Compositor(compositor_id, compositor_name, compositor_age, compositor_written_songs) VALUES (compositor_seq.nextval,'Black Sabbath','50','70');
INSERT INTO Compositor(compositor_id, compositor_name, compositor_age, compositor_written_songs) VALUES (compositor_seq.nextval,'Imagine Dragons','10','20');
create table Scene 
(
   scene_adress         VARCHAR2(50)         not null,
   scene_seat_places    NUMBER               not null,
   constraint PK_SCENE primary key (scene_adress)
);
Alter Table Scene ADD CONSTRAINT scene_adress_unique UNIQUE (scene_adress);
Alter Table Scene ADD CONSTRAINT scene_seat_places_check CHECK (REGEXP_LIKE(scene_seat_places, '^[/d]){5}$'));


INSERT INTO Scene(scene_adress, scene_seat_places) VALUES ('Salutna 12B','500');
INSERT INTO Scene(scene_adress, scene_seat_places) VALUES ('Marshala Grechka 8','100');
INSERT INTO Scene(scene_adress, scene_seat_places) VALUES ('Kotova 13','1000');
INSERT INTO Scene(scene_adress, scene_seat_places) VALUES ('Vilgelma Pika 21','2500');

create table HUMAN_PERFORMANCE_SCENE 
(
   scene_adress         VARCHAR2(50)         not null,
   human_id             NUMBER               not null,
   constraint PK_HUMAN_PERFORMANCE_SCENE primary key (scene_adress, human_id)
);

alter table HUMAN_PERFORMANCE_SCENE
   add constraint FK_HUMAN_PE_HUMAN_PER_SCENE foreign key (scene_adress)
      references Scene (scene_adress);

alter table HUMAN_PERFORMANCE_SCENE
   add constraint FK_HUMAN_PE_HUMAN_PER_HUMANS foreign key (human_id)
      references Humans (human_id);












  
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

-- LABORATORY WORK 1
-- BY Kollehina_Kateryna
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER kollehina identified by kollehina
default tablespace "USERS",
temporary tablespace "TEMP";

ALter user kollehina 100M quota on USERS;

grant user kollehina "Connect";
grant Create any table to kollehina;
 
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
Create table human(
human_name varchar(20) not null
);
Alter table human
add constraint human_pk primary key(human_name);
 
 Create table song(
song_name varchar(20) not null
);
Alter table song
add constraint song_pk primary key(song_name);

Create table number_song(
human_name_fk varchar(20) not null
song_name_fk varchar(20) not null
number_song integer not null
);

Alter table number_song
add constraint human_name_pk primary  key(human_name_fk);
Alter table number_song
add constraint song_name_pk primary  key(song_name_fk) ;
Alter table number_song
add constraint human_name_fk foreign  key(human_name_pk)references (human_name);
Alter table number_song
add constraint song_name_fk foreign  key(song_name_pk)references (song_name);

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

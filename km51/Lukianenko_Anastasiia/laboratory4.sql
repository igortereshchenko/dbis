--Написати триггер, що при зміні назви плейлиста видаляє всю музику з нього.

CREATE OR REPLACE TRIGGER delete_music
AFTER UPDATE OF PLAYLIST_NAME ON PLAYLIST
BEGIN
    DELETE FROM PLAYLIST
    WHERE PLAYLIST_NAME = :new.PLAYLIST_NAME;
END;

--Написати триггер, що при додаванні користувача додає йому дефолтний контакт

CREATE OR REPLACE TRIGGER new_contact
AFTER INSERT ON USERS
BEGIN
    INSERT INTO USER_CONTACTS(Email_Fk, CONTACT_EMAIL, CONTACT_NAME, DATE_ADDED)
    VALUES(:new.email, 'default@gmail.com', 'default', '10/10/2018');
END;

--Написати курсор, параметр якого жанр музики. Виводить в консоль список всіх користувачів, які слухають даний жанр.

set serveroutput on;

declare  
cursor cursor_genre (in_genre music.genre%type) is
select distinct
    email_fk
from music left join playlist on music.music_name = playlist.music_name_fk and Music.Author = Playlist.Author_Fk
where genre = in_genre;
write_email playlist.email_fk%type;
begin
    open cursor_genre('pop');
    loop 
    fetch cursor_genre into write_email;
        if (cursor_genre %FOUND) then
            DBMS_OUTPUT.PUT_LINE(trim(write_email) || ' ');
        else exit;
    end if;
end loop;
close cursor_genre;
end;

-- LABORATORY WORK 4
-- BY Herasko_Andrii
--Запрет добавления второго автора песни

create or replace trigger oneauthor
before insert on author
FOR EACH ROW
declare 
count_author number;
exist_author EXCEPTION;

begin
select count(song_title||song_release_year) into count_author
from author
where song_title=:new.song_title
and song_release_year=:new.song_release_year;

if count_author>0 then
--ROLLBACK;
RAISE exist_author;
end if;

EXCEPTION
when exist_author then
    raise_application_error('-20555',' Author is exist ');
end;


--Запрет удаления автора если у его пести автор только он
create or replace trigger delete_person 
before delete on person
for EACH ROW
declare 
count_person number;
one_author exception;
begin 


    select count(person_id_number) into count_person
    from author join (select song_title as s_t, song_release_year as s_r_y
    from author 
    group by song_title, song_release_year
    having count(person_id_number) = 1) 
    on s_t = author.song_title and s_r_y = author.song_release_year
    where person_id_number = :old.person_id_number ;

    if count_person >0 then raise one_author;
    end if;

    exception 
    when one_author then
    raise_application_error('-20876','cvxcvxc');
end;




-- Курсор с параметром выводит все песни и авторов песен с альбома

declare

cursor album_info(album song.song_album%type) is
select author.song_title, (person_name||' '||person_surname) as author
from person join author
on person.person_id_number = author.person_id_number
join song
on song.song_title = author.song_title and song.song_release_year = author.song_release_year
where song.song_album = album;

album song.song_album%type;
al_info album_info%rowtype;
begin
album := 'Back';
open album_info(album);
loop
fetch album_info into al_info;
exit when album_info%notfound;
dbms_output.put_line(al_info.song_title||' | ' ||al_info.author);
end loop;


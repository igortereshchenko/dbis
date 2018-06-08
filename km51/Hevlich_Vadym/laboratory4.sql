-- LABORATORY WORK 4
-- BY Hevlich_Vadym
-- Автор не може співати свої пісні
CREATE OR REPLACE TRIGGER disallow_sing_own_songs 
BEFORE CREATE OR UPDATE OR INSERT ON singer 
FOR EACH ROW 
DECLARE 
	songs_count number;
BEGIN 
	select song.count(song_title || song_release_year) in songs_count
	from author join person on person.person_id_number = author.person_id_number
	join song on song.song_title = author.song_title and song.song_release_year = author.song_release_year
	where author.person_id_number = NEW.person_id_number;

	if songs_count > 0 then
		raise_application_error('-20555','Author cannot sing own songs');
	end if;
END;

-- Видалити пісні при зміні імені автора
CREATE OR REPLACE TRIGGER remove_songs_on_author_name_change 
BEFORE UPDATE ON author 
FOR EACH ROW 

DECLARE 
	song_title text;
	song_release_year number;
BEGIN
	SELECT INTO song_title, song_release_year FROM author
	WHERE author_pk = NEW.author_pk;

	if OLD.author_name <> NEW.author_name then
		DELETE FROM song
		WHERE author.song_title=NEW.song_title, song_release_year=NEW.song_release_year;
	end if;
END;

-- Отримати назву альбому, вивести імена авторів і співаків пісень цього альбому
declare cursor song_related_info(c_song_title song.title%type) is
	select author.song_title, person_name as related_person
		from person join author
		on person.person_id_number = author.person_id_number
		join singer
		on person.person_id_number = singer.person_id_number
		join song
		on (song.song_title = author.song_title and song.song_release_year = author.song_release_year)
			or (song.song_title = singer.song_title and song.song_release_year = singer.song_release_year)
		where song.song_name = c_song_title;

	title song.title%type;
	related_person_data related_person%rowtype;

begin
	title := 'Test';
	open related_person_data(title);
		loop
			fetch related_person into related_person_data;
			exit when related_person%notfound;
			dbms_output.put_line(related_person.person_name);
		end loop;
end;

-- LABORATORY WORK 4
-- BY Kharytonchyk_Oleksandr
-- При изменении имени человека удалять все написанные ним песни.

set serveroutput on

CREATE OR REPLACE TRIGGER deleting_of_written_songs
BEFORE UPDATE OF human_name ON Human
for EACH ROW
DECLARE
id_to_delete human.human_identific_number%type;
BEGIN
 SELECT human_identific_number into id_to_delete
 FROM Human
 WHERE human_name = :old.human_name;
 
 DELETE FROM human_writes_song
 WHERE human_writes_song.human_identific_number = id_to_delete;
END;



-- Не дает изменить название альбома, если он не пустой (в нем есть песни).

CREATE OR REPLACE TRIGGER rename_of_album
before UPDATE OF song_album ON Song
for each row
DECLARE
count_song number;
not_empty_album exception;
BEGIN
SELECT COUNT(song_title) into count_song
 FROM SONG
 WHERE song_album = :old.song_album;

 IF count_song > 0 THEN
     raise not_empty_album;
 END IF;
    exception
    when not_empty_album then
    raise_application_error('-20787', 'Can not rename album name, because it is not empty');
END;



-- Параметром курсора является имя человека. Курсор выводит в консоль 
-- все написанные ним песни, которые он пел.

DECLARE
CURSOR human_cur(v_human_name human.human_name%type) IS 
 SELECT  human_writes_song.song_title
 FROM Human JOIN human_writes_song
 ON Human.human_identific_number = human_writes_song.human_identific_number
 JOIN human_sings_song
 ON human_writes_song.human_identific_number = human_sings_song.human_identific_number 
 WHERE (Human.human_name = v_human_name)
 AND (human_writes_song.song_title = human_sings_song.song_title);

 human_rec human_cur%ROWTYPE;
 v_name human.human_name%type;
BEGIN
 v_name := 'Malcolm';
 OPEN human_cur(v_name);
 LOOP 
  FETCH human_cur INTO human_rec;
  EXIT WHEN human_cur%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(human_rec.song_title);
 END LOOP;
CLOSE human_cur;
END;

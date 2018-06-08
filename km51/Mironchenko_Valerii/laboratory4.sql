-- LABORATORY WORK 4
-- BY Mironchenko_Valerii
-------------------------------------------------------------------------
------- тригер: при изменении имени певца удаляет всех его друзей -------
-------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER singerNameUpdate 
    AFTER UPDATE OF singer_name ON singers
    FOR EACH ROW
BEGIN

    DELETE FROM singer_friends
    WHERE
        singer_id_fk =:new.singer_id; 

END singerNameUpdate ;


-------------------------------------------------------------------------
----- тригер: при добавлении певца меняет темп песни на "default" -------
-------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER addSongTheme 
    AFTER INSERT ON singers
    FOR EACH ROW

BEGIN

    songs.song_theme = 'default';
    WHERE singers.singer_id = :new.id;

END addSongTheme;

-----------------------------------------------------------------------------------
--  курсор: с параметром - жанр песни, вывести в консоль певцов, которые ее поют --
-----------------------------------------------------------------------------------

 DECLARE 
     songGenre  songs.song_genre%type;
 
 CURSOR COMP(song_g  songs.song_genre%type) 
     IS 
 SELECT DISTINCT singer_name
 FROM singer_singing_the_song
 WHERE song_genre = song_g;
 
 singer_rec singer%rowtype;
 
 BEGIN
      songGenre := 'deathcore';
      OPEN singer(songGenre);
      LOOP  
         FETCH singer INTO singer_rec;
         EXIT WHEN singer%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE (singer_rec.song_genre); 
      END LOOP;
      CLOSE singer; 
  END;

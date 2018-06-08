-- LABORATORY WORK 4
-- BY Kollehina_Kateryna
---При зміні human_id видаляються всі написані ним пісні
CREATE OR REPLACE TRIGGER delete_human_song_after_update AFTER
    UPDATE OF human_id ON human
    FOR EACH ROW
BEGIN
    DELETE FROM human_wrote_song
    WHERE
        human_id =:old.human_id;  
END ;
---- курсор: параметр- жанр пісні; виводиться в консоль інформація про людину,котра її написала.
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE myProc(v_song_genre song.song_genre%TYPE) AS
DECLARE
    CURSOR human_info (
        v_song_genre song.song_genre%TYPE
    ) IS SELECT
        human_id,
        human_name,
        human_surname,
        human_birthday
         FROM
        human
        JOIN human_wrote_song ON human_wrote_song.human_id_fk = human.human_id
        JOIN song ON human_wrote_song.song_id_fk = song.song_id
         WHERE
           song.song_genre = v_song_genre;

    human_rec   human_info%rowtype;
BEGIN
    OPEN human_info('pop');
    LOOP
        FETCH human_info INTO human_rec;
        dbms_output.put_line(human_rec.human_id|| ' '||human_rec.human_name|| ' '
            || human_rec.human_surname|| ' '|| human_rec.human_birthday);         
        EXIT WHEN human_info%notfound;
    END LOOP;
    CLOSE human_info;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Sorry! There isn't such singer');
END;

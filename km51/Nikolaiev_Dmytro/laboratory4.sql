-- LABORATORY WORK 4
-- BY Nikolaiev_Dmytro

set SERVEROUTPUT on;
create or replace trigger comupdate
before update of COMPOSITOR_NAME ON compositor
for each row
BEGIN
DELETE FROM SONGS WHERE compositor_id=:old.compositor_id;
END;
/

create or replace trigger addhuman
before insert on humans
for each row
begin
INSERT  into HUMAN_PERFORMANCE_SCENE (human_performance_scene.scene_adress,human_performance_scene.human_id)
VALUES ('defaultScene',:new.human_id);
end;

DECLARE

cursor mycursor(song_genre in songs.song_genre%type) IS
SELECT humans.human_name, compositor.compositor_name from humans join human_sing_song on humans.human_id=human_sing_song.human_id
join songs on songs.song_name=human_sing_song.SONG_NAME
join compositor on songs.compositor_id=compositor.compositor_id
where song.song_genre=song_genre;

rowvar mycursor%rowtype;

begin
open mycursor;
for rowvar in mycursor('Metal') loop
dmbs_output.put_line(rowvar);
end loop;
close mycursor;
end;

### 1) 

CREATE TRIGGER add_person 
  AFTER INSERT ON Person
  DECLARE
    song_id Song.id%TYPE,
    current_timestamp TIMESTAMP
  BEGIN
    SELECT id INTO song_id FROM Song LIMIT 1;
    SELECT CURRENT_TIMESTAMP INTO current_timestamp FROM DUAL
    
    INSERT INTO Dance(song, person, date) VALUES (sond_id, :new.id, current_timestamp)
  END add_person;
 

### 2) 
CREATE TRIGGER update_song
  AFTER UPDATE OF title ON Song
  FOR EACH ROW
  DECLARE
    id Song.id%TYPE
  BEGIN
    id = :new.id
    DELETE FROM Dance WHERE sond_id=id;
  END update_song;
  

### 3)
CURSOR dance_info (song_id IN Sond.id%TYPE)
  IS
    SELECT Dance.song_id, Dance.person_id
    FROM
      Dance
    WHERE
      Dance.song_id = song_id;

-- LABORATORY WORK 4
/*---------------------------------------------------------------------------
1.При створенні profiles до неї додається movies та reviews.
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE  OR  REPLACE  TRIGGER profiles_trigger
AFTER INSERT  ON profiles
FOR EACH ROW
DECLARE profile_username profile_trigger.profile_trigger_username %TYPE ; 
BEGIN   profile_username  := :new.profile_trigger_username;
INSERT INTO watched_movies( profile_id_fk, review_id_fk,movie_id_fk ) SELECT profile_id AS profile_id_fk, :new.profile_trigger_username as profile_username from reviews;
    END;

	
/*---------------------------------------------------------------------------
2. Тригер, який при зміні фільму - видаляє його відгуки.
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE  OR  REPLACE TRIGGER movie_update
BEFORE UPDATE ON movie
FOR EACH ROW
DECLARE
movie_id_ movie.movie_id%TYPE;
BEGIN
movie_name_ :=:new.movie_id;
UPDATE FROM watched_movies WHERE movie_id_=movie_id_fk;
END movie_update;
CREATE  OR  REPLACE TRIGGER watched_movies_delete
BEFORE DELETE ON watched_movies
FOR EACH ROW
DECLARE
review_id watched_movies.review_id_fk%TYPE;
BEGIN
review_id_ :=:old.review_id_fk;
DELETE FROM TICKETS WHERE review_id_=review_id_fk;
END watched_movies_delete;

/*---------------------------------------------------------------------------
3. Курсор, який виводить ключі людини та її відгуків по назві фільму.
---------------------------------------------------------------------------*/
--Код відповідь:
CREATE  OR  REPLACE CURSOR get_profiles_and_reviews_by_movie_cursor(movie movies. movie_name%type)
IS  
    SELECT
        profile_id, watched_movies.review_id_fk
    FROM watched_movies
    JOIN movies ON movies. movie_name=watched_movies. movie_id_fk
    JOIN profiles ON watched_movies.profile_id_fk=profiles.profile_id
    JOIN watched_movies ON watched_movies.profile_id_fk=profiles.profile_id
    JOIN watched_movies ON watched_movies.review_id_fk=watched_movies.profile_id_f
    GROUP BY profile_id having  movies. movie_name=movie;
-- BY Kolobaieva_Kateryna

-- LABORATORY WORK 4
-- BY Kurshakov_Mykhailo

--При зміні імені person видалити інформацію про музику під яку він танцює
CREATE OR REPLACE TRIGGER person_name_change BEFORE
    UPDATE OF person_name ON person
    FOR EACH ROW
DECLARE
    nick_for_delete_info   person.nick_name%TYPE :=:old.nick_name;
BEGIN
    DELETE FROM "person dancing"
    WHERE
        "person dancing".nick_name = nick_for_delete_info;

END person_name_change;

--При зміні жанра музики видалити всю інформацію про музику
CREATE OR REPLACE TRIGGER music_genre_change BEFORE
    UPDATE OF music_genre ON music
    FOR EACH ROW
BEGIN
    DELETE FROM "person dancing"
    WHERE
        music_title =:old.music_title;

    DELETE FROM musicinfo
    WHERE
        music_author2 IN (
            SELECT
                music_author2
            FROM
                "info about music"
            WHERE
                music_title =:old.music_title
        );

    DELETE FROM "info about music"
    WHERE
        music_title =:old.music_title;

END music_genre_change;

--Для жанру музики вивести в консоль інформацію про person і музику під яку танцює
SET SERVEROUTPUT ON;

DECLARE
    CURSOR my_cur (
        genre music.music_genre%TYPE
    ) IS SELECT
        TRIM(music.music_genre) AS genre,
        TRIM(music.music_title) AS title,
        TRIM(person.nick_name) AS nick_name,
        TRIM(person.person_name) AS person_name,
        TRIM(person.person_surname) AS person_surname,
        TRIM(person.birth_year_fk) AS birth_date
         FROM
        music
        JOIN "person dancing" ON music.music_title = "person dancing".music_title
        JOIN person ON person.nick_name = "person dancing".nick_name
         WHERE
        music.music_genre = genre;

    my_rec   my_cur%rowtype;
BEGIN
    OPEN my_cur('Alternative');
    LOOP
        FETCH my_cur INTO my_rec;
        EXIT WHEN my_cur%notfound;
        dbms_output.put_line(' Title '
        || my_rec.title
        || ' Nick name '
        || my_rec.nick_name
        || ' Person name '
        || my_rec.person_name
        || ' Person surname '
        || my_rec.person_surname
        || ' Birth date '
        || my_rec.birth_date);

    END LOOP;

    CLOSE my_cur;
END;

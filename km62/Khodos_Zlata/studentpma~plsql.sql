SET AUTOPRINT ON

DECLARE
    TYPE namesarray IS
        VARRAY ( 5 ) OF VARCHAR2(50);
    personid      person.person_id%TYPE := &person_idfk;
    lecturename   lecture.lecture_name%TYPE := &lecture_name_input;
BEGIN
    SELECT
        note_marker.note_name INTO namesarray
    FROM
        person
        JOIN marker ON person.person_id = marker.person_id
        JOIN note_marker ON marker.marker_id = note_marker.marker_id
                            AND marker.material_id = note_marker.material_id
                            AND marker.person_id = note_marker.person_id
        JOIN material ON marker.material_id = material.material_id
        JOIN lecture ON lecture.material_id = material.material_id
    WHERE
        person.person_id = personid
        AND   lecture.lecture_name = lecturename;

END;
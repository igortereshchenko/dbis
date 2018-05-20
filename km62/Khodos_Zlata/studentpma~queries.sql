SELECT
    lecture_name AS "lecture name",
    COUNT(note_marker.note_name) AS "count note"
FROM
    lecture
    JOIN material ON lecture.material_id = material.material_id
    JOIN marker ON marker.material_id = material.material_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                        AND marker.person_id = note_marker.person_id
GROUP BY
    lecture_name;


SELECT
    person.person_id AS "person id",
    COUNT(note_marker.note_name) AS "count notes"
FROM
    person
    JOIN marker ON person.person_id = marker.person_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                        AND marker.person_id = note_marker.person_id
GROUP BY
    person.person_id;

SELECT
    person.person_id AS "person id",
    COUNT(lecture.lecture_name) AS "count lecture"
FROM
    person
    JOIN marker ON person.person_id = marker.person_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                        AND marker.person_id = note_marker.person_id
    JOIN material ON marker.material_id = material.material_id
    JOIN lecture ON lecture.material_id = material.material_id
GROUP BY
    person.person_id;

SELECT info.person_id, info.markers_date, count(info.count_date) 
FROM (
SELECT
    person.person_id, min(marker_date) markers_date, count(marker_date) count_date
FROM
    person
    JOIN marker ON person.person_id = marker.person_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                            AND marker.person_id = note_marker.person_id
group by
person.person_id, note_name
)info
group by info.person_id, info.markers_date;

    
CREATE OR REPLACE VIEW user_notes AS
    SELECT
        info."personid",
        info."notename",
        LISTAGG(info."substring",
        '|| ') WITHIN GROUP(
        ORDER BY
            info."personid"
        ) "Notes"
    FROM
        (
            SELECT DISTINCT
                person.person_id "personid",
                note_marker.note_name "notename",
                substr(TO_CHAR(material.material_text),marker.marker_start_point,marker.marker_finish_point - marker.marker_start_point + 1) "substring"
            FROM
                person
                JOIN marker ON person.person_id = marker.person_id
                JOIN note_marker ON marker.marker_id = note_marker.marker_id
                                    AND marker.material_id = note_marker.material_id
                                    AND marker.person_id = note_marker.person_id
                JOIN material ON marker.material_id = material.material_id
                JOIN lecture ON lecture.material_id = material.material_id
        ) info
    GROUP BY
        info."personid",
        info."notename";

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

    
CREATE VIEW user_notes 
AS 
    SELECT DISTINCT person.person_id, note_marker.note_name, marker.marker_start_point, marker_finish_point
    FROM person
    JOIN marker ON person.person_id = marker.person_id
    JOIN note_marker ON marker.marker_id = note_marker.marker_id
                        AND marker.material_id = note_marker.material_id
                        AND marker.person_id = note_marker.person_id
    JOIN material ON marker.material_id = material.material_id
    JOIN lecture ON lecture.material_id = material.material_id
    ORDER BY person.person_id, note_marker.note_name
;
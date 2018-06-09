create view exercise_comment as 
select DISTINCT exercise.exercise_number, comments.comment_id
from exercise join exercise_answer on exercise.exercise_number = exercise_answer.exercise_number
              join student on exercise_answer.student_id = student.student_id
              join person on student.person_id = person.person_id
              join marker on person.person_id = marker.person_id
              join comments on marker.marker_id = comments.marker_id
group by exercise.exercise_number, comments.comment_id
order by exercise.exercise_number;



select exercise.exercise_number , count(comments.comment_id)
from exercise join exercise_answer on exercise.exercise_number = exercise_answer.exercise_number
              join student on exercise_answer.student_id = student.student_id
              join person on student.person_id = person.person_id
              join marker on person.person_id = marker.person_id
              join comments on marker.marker_id = comments.marker_id
group by exercise.exercise_number;   




select person.person_id, count(comments.comment_id)
from person join marker on person.person_id = marker.person_id
            join comments on marker.marker_id = comments.comment_id
group by person.person_id;




select person.person_id, count(comments.comment_id), exercise.exercise_number
from exercise join exercise_answer on exercise.exercise_number = exercise_answer.exercise_number
              join student on exercise_answer.student_id = student.student_id
              join person on student.person_id = person.person_id
              join marker on person.person_id = marker.person_id
              join comments on marker.marker_id = comments.marker_id
group by person.person_id, exercise.exercise_number;

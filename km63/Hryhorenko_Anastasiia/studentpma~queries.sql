create view student_exercise_mark as
select DISTINCT student.student_id as student_id, 
                TO_CHAR(exercise.exercise_solution) as answer, 
                TO_CHAR(exercise_answer.student_solution) as student_answer,
                max(exercise.exercise_mark) as max_mark,
                exercise_answer.student_solution_mark as student_mark
from student join exercise_answer on student.student_id = exercise_answer.student_id
             join exercise on exercise_answer.exercise_number = exercise.exercise_number
group by student.student_id, 
         TO_CHAR(exercise.exercise_solution), 
         TO_CHAR(exercise_answer.student_solution), 
         exercise_answer.student_solution_mark;



select student.student_id, EXERCISE_ANSWER.STUDENT_SOLUTION_MARK
from student join exercise_answer on student.student_id = exercise_answer.student_id
group by student.STUDENT_ID, EXERCISE_ANSWER.STUDENT_SOLUTION_MARK;


select exercise.exercise_number, material.material_id
from material join exercise on material.material_id = exercise.material_id
group by exercise.exercise_number, material.material_id;


select student.student_id, count(exercise_answer.exercise_answer_id) as "exercise_done", 
    (select count(exercise_answer.exercise_answer_id) as "exercise_not_done" from exercise_answer 
        minus select DISTINCT count(exercise_answer.exercise_answer_id) as "exercise_not_done" 
        from exercise_answer join student on  exercise_answer.student_id = student.student_id) as "exercise_not_done"
from exercise_answer join student on  exercise_answer.student_id = student.student_id
group by student.student_id
order by student.student_id;

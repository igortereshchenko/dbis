-- LABORATORY WORK 4

-- 1. Тригер, який при видаленні викладача видаляє усі роботи, що він перевіряв
CREATE TRIGGER delete_tasks
BEFORE DELETE on Teacher
  BEGIN
    DELETE FROM studentYieldsWork WHERE work_id IN (SELECT work_id FROM work WHERE teacher_id = :old.id);
    DELETE FROM work where teacher_id = :old.id;
  END;

-- 2. Тригер, який при додаванні нового студента одразу видає йому роботу
CREATE TRIGGER add_work_to_student
  AFTER INSERT ON Student
    BEGIN
      INSERT INTO studentYieldsWork(work_id, student_id) SELECT work_id AS work_id, :new.id as student_id from work;
    END;

-- 3. Курсор, який за іменем викладача виводить імена усіх студентів, роботи яких провіряв викладач
CURSOR show_stutends_cursor (teacher_name IN VARCHAR)
IS
  SELECT DISTINCT Student.name  
  FROM studentYieldsWork
  JOIN Student ON studentYieldsWork.student_id = Student.id
  JOIN Work ON studentYieldsWork.work_id = Work.work_id 
  JOIN Teacher ON Teacher.id = Work.teacher_id
  WHERE Teacher.name = teacher_name;

-- BY Kupar_Kristina

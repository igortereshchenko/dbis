-- LABORATORY WORK 4
-- BY Ushatska_Vasylyna
1. Створити тригер, котрий при створені нового студента додає йому новий зошит


CREATE OR REPLACE TRIGGER create_student_trigger AFTER
    INSERT ON Students
    FOR EACH ROW
BEGIN
    INSERT INTO notebook (
       notebook_id,
        notebook_name,
       student_id,
        subject_id
      ) VALUES (
        1223456778,
        'mynotebook',
        2334556667,
         2344555677
    );

END;

    2. Тригер, котрий при зміні назви предмету видаляє всі зошити, де був цей предмет 

CREATE OR REPLACE TRIGGER update_subject AFTER
    UPDATE OF subject_name ON subject
    FOR EACH ROW
BEGIN
    DELETE FROM notebooks
    WHERE
        subject_subject_name =:old.subject_name;

END;
   3. Створити курсор параметер котрого це ім'я власника який в консоль виводить всі його комп'ютери та з яких деталей вони складаються  

   
DECLARE
    subject_name   subject.subject_name%TYPE;
    CURSOR student_notes (
        curr_subject_name   subject.subject_name%TYPE
    ) IS SELECT
        students.stud_name,
        count(notebook.note_id)
        FROM
        students
        JOIN notebooks ON students.stud_id=notebook.stud_id
        JOIN subjects ON notebooks.subject_id = subjects.subject_id
        WHERE
        subjects.subject_name=curr_subject_name ;

BEGIN
    subject_name := 'Math';
    FOR stud_name_notes_quantity IN student_notes(subject_name) LOOP
        dbms_output.put_line(stud_name_notes_quantity.subject_name
        || ' -> '
        ||stud_name_notes_quantity.stud_name
        || ' -> '
        ||stud_name_notes_quantity.count(notebook.note_id));
    END LOOP;

END;

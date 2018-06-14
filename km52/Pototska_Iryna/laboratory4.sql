-- LABORATORY WORK 4
-- BY Pototska_Iryna

1. Триггер, который при добавлении нового языка программирования ставит его актуальную дату создания 
2. Триггер, при изменении названия страны удаляются все студенты , которые там живут 
3. Курсор; параметр - язык программирования 
Выводит информацию о всех студентах , которые его изучают и где они живут

1. CREATE OR REPLACE TRIGGER actual_date_of_birthday
AFTER INSERT ON programming_language
FOR EACH ROW
DECLARE
BEGIN
UPDATE programming_language SET language_birh = GETDATE()
WHERE programming_language.language_id = new.language_id
END;


2. CREATE OR REPLACE TRIGGER delete_students
AFTER UPDATE OF student_country ON STUDENT
    FOR EACH ROW
BEGIN
    DELETE FROM STUDENT
    WHERE
        student_country =:old.student_country; 
END;


3. CREATE PROCEDURE students_info(IN language_name varchar)
DECLARE
  CURSOR c1
  IS
    SELECT Student.student_name, Student.student_country 
    FROM programming_language
    JOIN STUDENT on programming_language.language_id=STUDENT.language_id;
BEGIN
  FOR record in c1 LOOP
    dbms_output.putline(record.student_name);
    dbms_output.putline(record.student_country);
  END LOOP;
END;


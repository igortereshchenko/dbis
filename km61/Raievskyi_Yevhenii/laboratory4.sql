-- TASK 1: При изненении названия страны, операторы в данной стране удаляются
--(При изменении страны у телефонного номера, он удаляется у владельца (студента))

CREATE OR REPLACE TRIGGER number_country_changed
AFTER UPDATE OF phone_country ON numbers
FOR EACH ROW
BEGIN
    DELETE FROM students_numbers WHERE phone_number_fk = :old.phone_number;
END;

-- TASK 2: При добавлении оператора, ему добавляется любой студент

CREATE OR REPLACE TRIGGER add_default_number
AFTER INSERT ON operators
FOR EACH ROW
DECLARE    
    phone_n numbers.phone_number%TYPE := 0;
    stud_id students.stud_id%TYPE := 0;
BEGIN
        SELECT MIN(numbers.phone_number) + 1 INTO phone_n FROM numbers WHERE numbers.phone_number + 1 NOT IN (SELECT numbers.phone_number FROM numbers) ORDER BY phone_number;
        INSERT INTO numbers VALUES(phone_n, 'Test', NULL);
        
        SELECT MAX(students.stud_id) + 1 INTO stud_id FROM students;
        INSERT INTO students VALUES(stud_id, 'Test', 'Test', NULL);
        
        INSERT INTO students_numbers VALUES(stud_id, phone_n, :new.operator_id, CURRENT_TIMESTAMP);
END;

-- TASK 3: Cursor, параметр - имя студента. Вывести названия операторов, которыми он пользовался

CURSOR student_operators_cur(student VARCHAR2) IS
        SELECT operators.operator_name
        FROM 
            operators INNER JOIN students_numbers ON operators.operator_id = students_numbers.operator_id_fk
            INNER JOIN students ON students.stud_id = students_numbers.stud_id_fk
        WHERE students.stud_name = student;

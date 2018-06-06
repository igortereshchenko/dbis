-- LABORATORY WORK 4
-- BY Kysla_Olha
-------------------------------------------------------------------------
-- при зміні ім'я студента видаляються сві його телефони
-------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER del_ph_aft_update AFTER
    UPDATE OF stud_name ON students
    FOR EACH ROW
BEGIN
    DELETE FROM students_has_phones
    WHERE
        stud_id_fk =:new.stud_id; -- в даному випадку немає різниці new чи old так як  id не змінюється 

END del_ph_aft_update;

UPDATE students
    SET
        stud_name = 'new_stud_name'
WHERE
    students.stud_id = '2';
-------------------------------------------------------------------------
--при додаванні нового студента додається дефолтний номер телефону 
-------------------------------------------------------------------------

CREATE SEQUENCE seq_phone_id START WITH 10 INCREMENT BY 1
/

CREATE SEQUENCE p_number START WITH 1111111 INCREMENT BY 1
/

CREATE OR REPLACE TRIGGER add_defphone AFTER
    INSERT ON students
    FOR EACH ROW
DECLARE
    v_oper_code   operators.oper_code%TYPE;
BEGIN
    SELECT
        operators.oper_code
    INTO
        v_oper_code
    FROM
        operators
    WHERE
        oper_code = '057'; -- вважаємо дефолтним оператором

    INSERT INTO phones (
        phone_id,
        phone_type
    ) VALUES (
        seq_phone_id.NEXTVAL,
        'new123'
    );

    INSERT INTO students_has_phones (
        phone_id_fk,
        stud_id_fk,
        stud_phone_date
    ) VALUES (
        seq_phone_id.CURRVAL,
        :new.stud_id,
        SYSDATE
    );

    INSERT INTO phone_number (
        oper_code_fk,
        phone_id_fk,
        phone_number_date,
        phone_number
    ) VALUES (
        v_oper_code,
        seq_phone_id.CURRVAL,
        SYSDATE,
        p_number.NEXTVAL
    );

END add_defphone;

INSERT INTO students (
    stud_id,
    stud_name,
    stud_surname
) VALUES (
    '11',
    'new_stud_with_phone',
    'surname'
);

-----------------------------------------------------------------------------
--використати курсор з параметром = назва оператору 
--виводить імена студентів та їх номера телефонів 
-----------------------------------------------------------------------------

SET SERVEROUTPUT ON

DECLARE
    CURSOR stud_and_phone_numbers (
        v_oper_name operators.oper_name%TYPE
    ) IS SELECT
        students.stud_name,
        concat(operators.oper_code,phone_number.phone_number) AS full_number
         FROM
        operators
        JOIN phone_number ON phone_number.oper_code_fk = operators.oper_code
        JOIN phones ON phone_number.phone_id_fk = phones.phone_id
        JOIN students_has_phones ON students_has_phones.phone_id_fk = phones.phone_id
        JOIN students ON students.stud_id = students_has_phones.stud_id_fk
         WHERE
        operators.oper_name = v_oper_name;

    v_row   stud_and_phone_numbers%rowtype;
BEGIN
    OPEN stud_and_phone_numbers('life');
    LOOP
        FETCH stud_and_phone_numbers INTO v_row;
        IF
            ( stud_and_phone_numbers%found )
        THEN
            dbms_output.put_line(v_row.stud_name
            || ' '
            || v_row.full_number);
        END IF;

        EXIT WHEN stud_and_phone_numbers%notfound;
    END LOOP;

    CLOSE stud_and_phone_numbers;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('student does not have phone number with this operators');
END;

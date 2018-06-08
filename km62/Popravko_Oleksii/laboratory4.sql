-- LABORATORY WORK 4
-- BY Popravko_Oleksii
--1st Task--------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER delete_softname AFTER
    UPDATE OF software_name ON software
    FOR EACH ROW
DECLARE
    soft_name   software.software_name%TYPE;
    soft_id     computer_software.software_fk%TYPE;
BEGIN
    soft_name :=:new.soft_name;
    soft_id :=:new.soft_id;
    DELETE FROM computer_software WHERE
        software_fk = soft_id;

END;
------------------------------------------------------------------------------------------------------------
--2nd Task--------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER upd_comp AFTER
    INSERT ON hardware
    FOR EACH ROW
DECLARE
    comp_fk   computer_hardware.computer_fk%TYPE;
    hard_fk   hardware.hardware_id%TYPE;
BEGIN
    comp_fk :=:new.comp_fk;
    hard_fk :=:new.hard_fk;
    UPDATE computer_hardware
    SET
      computer_fk = comp_fk
    WHERE
      hardware_fk = hard_fk;
END;

------------------------------------------------------------------------------------------------------------
--3d Task--------------------------------------------------------------------------------------------------

DECLARE
    soft_name_data   software.software_name%TYPE;
    hard_name_data   hardware.hardware_name%TYPE;
    CURSOR computer_parts_cursor (
        computer_name_filter computer.computer_name%TYPE
    ) IS SELECT
        software_name,
        hardware_name
         FROM
        software
        NATURAL JOIN computer_software
        NATURAL JOIN computer
        NATURAL JOIN computer_hardware
        NATURAL JOIN hardware
         WHERE
        computer_name = computer_name_filter;
BEGIN
OPEN computer_part_cursor('Macbook pro'); 
LOOP 
    FETCH computer_part_cursor INTO soft_name_data,hard_name_data; 
    IF(computer_part_cursor%found) THEN
        dbms_output.put_line ( 'Software name:' TRIM(soft_name_data)|| 
        ' Hardware name: '|| TRIM(hard_name_data));
    ELSE
        dbms_output.put_line('This Computer was not founded');
    END LOOP;
CLOSE computer_part_cursor;    
END;

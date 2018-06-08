-- LABORATORY WORK 4
-- BY Haleta_Maksym
--1) Створити триггер, який при додаванні нового комп'ютера ставить йому білий колір
CREATE OR REPLACE TRIGGER set_white_color_trigger
  BEFORE INSERT ON Computer
  FOR EACH ROW
BEGIN
  :new.color := 'White';
END set_white_color_trigger;

--2) Створити триггер, який при видаленні комп'ютера видаляє усе його апаратне забезпечення
CREATE OR REPLACE TRIGGER delete_hardware_trigger
  BEFORE DELETE ON Computer
  FOR EACH ROW
DECLARE
  computerId %Computer.computer_id%TYPE;
BEGIN
  computerId := :old.computer_id;
  DELETE FROM Hardware
  WHERE Hardware.computer_id = computerId;
END delete_hardware_trigger;

--3) Створити курсор з параметром ім'я програміста, що виводить в консоль назву програмного продукту програміста
SET SERVEROUTPUT ON;

DECLARE
  programName Software.name%TYPE;
  CURSOR software_name_cursor(programmerName Programmer.name%TYPE);
  IS
    SELECT
      Software.name
    FROM
      Programmer JOIN Software
      ON Programmer.programmer_id = Software.programmer_id
    WHERE
      Programmer.name = programmerName;

BEGIN
  OPEN software_name_cursor('David');
  LOOP
    FETCH software_name_cursor INTO programName;
    IF (software_name_cursor %FOUND) THEN
      DBMS_OUTPUT.put_line('Program name: ' || programName);
    ELSE
      EXIT;
    END IF;
  END LOOP;
  
  CLOSE software_name_cursor;
END;

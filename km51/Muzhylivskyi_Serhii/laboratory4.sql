-- LABORATORY WORK 4
-- BY Muzhylivskyi_Serhii
CREATE OR REPLACE TRIGGER myTriggerIsTheBestTriggerInTheWorld
  AFTER UPDATE OF NAME
  ON OS
  FOR EACH ROW
  BEGIN
    DELETE FROM PRODUCER
    WHERE os_id = :OLD.os_id;
  END;

CREATE OR REPLACE TRIGGER myTriggerIsSecondTheBestTriggerInTheWorld
  BEFORE UPDATE
  ON PROCESSOR
  DECLARE
    counter NUMBER;
      MOTHERBOARD_EXISTING_EXCEPTION EXCEPTION;
  BEGIN
    SELECT COUNT(MOTHERBOARD_ID)
    FROM COMPUTER
      JOIN HARDWARE ON COMPUTER.HARDWARE_ID = HARDWARE.HARDWARE_ID
      JOIN MOTHERBOARD M on HARDWARE.MOTHERBOARD_ID = M.SERIAL_NUMBER
    WHERE COMPUTER_ID = 2;
    IF counter > 0
    THEN RAISE MOTHERBOARD_EXISTING_EXCEPTION;
    END IF;
  END;

CREATE OR REPLACE PROCEDURE myProc(comp_id COMPUTER.COMPUTER_ID%type) AS
  DECLARE 
  CURSOR comp_cur(comp_id COMPUTER.COMPUTER_ID%type)
  IS
    SELECT
      processor.name proc,
      motherboard.name mother,
      hard_disk.name disk
    FROM COMPUTER
      JOIN HARDWARE ON COMPUTER.HARDWARE_ID = HARDWARE.HARDWARE_ID
      JOIN PROCESSOR ON PROCESSOR_ID = PROCESSOR.serial_number
      JOIN MOTHERBOARD ON MOTHERBOARD_ID = MOTHERBOARD.serial_number
      JOIN HARD_DISK ON HARD_DISK_ID = HARD_DISK.serial_number
    WHERE COMPUTER_ID = comp_id;
    comp_rec comp_cur%ROWTYPE;
  BEGIN
    FOR comp_rec IN comp_cur
      LOOP
      dbms_output.put_line(comp_rec.proc || ' ' || comp_rec.mother || ' ' || comp_rec.disk );
    end loop;
  END;


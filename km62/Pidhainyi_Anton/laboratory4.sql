-- LABORATORY WORK 4
-- BY Pidhainyi_Anton
-----------------------------------1-----------------------------------
CREATE OR REPLACE TRIGGER del_soft
    AFTER UPDATE OF comp_name ON computers
    FOR EACH ROW
DECLARE
    compName COMPUTERS.COMP_NAME%TYPE;
    compID COMPUTERS.COMP_ID%TYPE;
BEGIN
    compName:=:NEW.comp_name;
    compID:=:NEW.comp_id;
    DELETE FROM COMP_HAS_SOFTWARE WHERE comp_id=compID;
END;
-----------------------------------------------------------------------


-----------------------------------2-----------------------------------
CREATE OR REPLACE TRIGGER add_hard
    AFTER INSERT ON computers
    FOR EACH ROW
DECLARE
    compID COMPUTERS.COMP_ID%TYPE;
BEGIN
    compID:=:NEW.comp_id;
    INSERT INTO COMP_HAS_HARDWARE(comp_id,hard_id) VALUES (compID,'H02');
    INSERT INTO COMP_HAS_HARDWARE(comp_id,hard_id) VALUES (compID,'H04');
END;
-----------------------------------------------------------------------




-----------------------------------3-----------------------------------
DECLARE

CURSOR hard_soft_names(compName COMPUTERS.COMP_NAME%TYPE) IS
    SELECT hard_name, soft_name FROM (((COMPUTERS JOIN COMP_HAS_SOFTWARE ON COMPUTERS.COMP_ID=COMP_HAS_SOFTWARE.COMP_ID)
        JOIN SOFTWARE ON SOFTWARE.SOFT_ID=COMP_HAS_SOFTWARE.SOFT_ID)
            JOIN COMP_HAS_HARDWARE ON COMPUTERS.COMP_ID=COMP_HAS_HARDWARE.COMP_ID)
                JOIN HARDWARE ON HARDWARE.HARD_ID=COMP_HAS_HARDWARE.HARD_ID
                    WHERE comp_name=compName;
                    
BEGIN
    FOR el IN hard_soft_names('Asus x550') LOOP
        DBMS_OUTPUT.PUT_LINE (TRIM(el.hard_name)||' '||TRIM(el.soft_name));
    END LOOP;
END;

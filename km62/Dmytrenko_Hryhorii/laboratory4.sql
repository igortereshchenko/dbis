-- LABORATORY WORK 4
-- BY Dmytrenko_Hryhorii
-- #1 При имзменении имени человека, удаляет его телефон
--------------------------------------------------------------------
CREATE OR REPLACE TRIGGER delete_phones 
    AFTER UPDATE OF HUMAN_NAME ON HUMAN
    FOR EACH ROW 
        BEGIN
            DELETE FROM HUMAN_HAS_PHONE
                WHERE HUMAN_HAS_PHONE.HUMAN_ID = :OLD.HUMAN_ID;
        END;
--------------------------------------------------------------------


-- #2 При добавлении человека добавляет ему телефон
--------------------------------------------------------------------
CREATE OR REPLACE TRIGGER add_phones
    AFTER INSERT ON HUMAN
    FOR EACH ROW
    WHEN (NEW.HUMAN_ID > 0)
        BEGIN
            INSERT INTO PHONE_TYPE 
            VALUES ('430005', 'Pixel 3', '2018', 'Google', 'USA');
        END;
--------------------------------------------------------------------        


-- #3 Курсор. Параметр - тип телефона, возвращает - имя человека, количество телефонов.
---------------------------------------------------------------------
    CURSOR SOME_CURSOR (PHONE_TYPE_NAME IN varchar2) 
    IS
    SELECT HUMAN_NAME, COUNT(PHONE_ID)
    FROM HUMAN JOIN ON HUMAN_HAS_PHONE
        WHERE HUMAN.HUMAN_ID = HUMAN_HAS_PHONE.HUMAN_ID
    GROUP BY HUMAN_NAME;

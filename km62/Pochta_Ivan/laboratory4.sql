-- LABORATORY WORK 4
-- BY Pochta_Ivan
/*При видаленні потягу - видаляються його квитки*/
create or replace TRIGGER train_delete
BEFORE DELETE ON TRAINS
FOR EACH ROW
DECLARE
train_id_ TRAINS.train_id%TYPE;
BEGIN
train_id_ :=:old.train_id;
DELETE FROM TRAIN_HAS_TICKET WHERE train_id_=train_fk;
END train_delete;
create or replace TRIGGER train_has_ticket_delete_action
BEFORE DELETE ON TRAIN_HAS_TICKET
FOR EACH ROW
DECLARE
ticket_id_ TRAIN_HAS_TICKET.TICKET_FK%TYPE;
BEGIN
ticket_id_ :=:old.ticket_fk;
DELETE FROM TICKETS WHERE ticket_id_=ticket_id;
END train_has_ticket_delete;
/*Зміна назви станції можлива, тільки якшо через неї не їде жодного потягу*/
create or replace TRIGGER stations_name_update_action
BEFORE UPDATE OF station_name ON STATIONS
FOR EACH ROW
DECLARE
name_ STATIONS.station_name%TYPE;
count_ int;
BEGIN
name_ :=:old.station_name;
SELECT COUNT(*) INTO count_ FROM TRAIN_HAS_STATION WHERE STATION_FK=name_;
if (count_>0) then
    :new.station_name := :old.station_name;
    DBMS_OUTPUT.PUT_LINE('you can not do it until trains going through this stations');
end if;
END stations_name_update_action;
/*курсор, що виводить ключі потягів та студентів на них по назві станції */
CURSOR get_trains_and_student_by_station_cursor(station STATIONS.STATION_NAME%type)
IS  
    SELECT
        train_id, STUDENT_BUY_TICKET.student_fk
    FROM TRAIN_HAS_STATION
    JOIN STATIONS ON STATIONS.STATION_NAME=TRAIN_HAS_STATION.STATION_FK
    JOIN TRAINS ON TRAIN_HAS_STATION.TRAIN_FK=TRAINS.TRAIN_ID
    JOIN TRAIN_HAS_TICKET ON TRAIN_HAS_TICKET.TRAIN_FK=TRAINS.TRAIN_ID
    JOIN STUDENT_BUY_TICKET ON STUDENT_BUY_TICKET.STUDENT_FK=TRAIN_HAS_TICKET.TICKET_FK
    GROUP BY TRAIN_ID having STATIONS.STATION_NAME=station;

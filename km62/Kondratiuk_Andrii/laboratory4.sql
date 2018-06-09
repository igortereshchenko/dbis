-- LABORATORY WORK 4
-- BY Kondratiuk_Andrii
-- 1.При зміненні train_id видаляються всі квитки до цього потягу
CREATE OR REPLACE TRIGGER train_id_changes
BEFORE UPDATE OF traind_id ON TRAINS
FOR EACH ROW
DECLARE
  v_ticket_id trains.ticket_fk%TYPE;
BEGIN
  v_ticket_id := :old.ticket_fk;
  DELETE FROM TRAIN_HAS_TICKET WHERE v_ticket_id = ticket_fk;
END train_id_changes;

-- 2.При додаванні станціїї, додається потяг, що їде через цю станцію
CREATE OR REPLACE TRIGGER add_station
BEFORE INSERT OF station_id ON STATIONS
FOR EACH ROW
DECLARE
  v_train_h_fk train_has_station.train_h_fk%TYPE &v_train_h_fk;
  v_station stations.station_id%TYPE;
BEGIN
  v_station := :new.station_id;
  INSERT INTO train_has_station (train_h_fk, station_fk)
  VALUES(v_train_h_fk, v_station);
END add_station;

-- 3. Створити курсос з аргументом station_id, що виводить кількість квитків,
--    що проходять через цю станцію та номера цих потягів
SET SERVEROUTPUT ON
DECLARE
    CURSOR list_of_trains (
        station_id stations.station_id%TYPE
    ) IS SELECT
        trains.train_id,
        train_has_station.train_h_fk
         FROM
        trains
        NATURAL JOIN trains_has_station
        NATURAL JOIN stations
        GROUP BY trains.train_id
        WHERE stations.station_id = train_has_station.station_fk
      BEGIN
          OPEN list_of_trains (station_id);
          LOOP
              dbms_output.put_line(trains.train_id || train_has_station.train_h_fk)
          END LOOP;
      END list_of_trains;

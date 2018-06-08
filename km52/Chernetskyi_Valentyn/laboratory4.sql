-- LABORATORY WORK 4
-- BY Chernetskyi_Valentyn

1  Триггер. При добавлении кол-ва мест в отеле - добавляется или удаляется турист
2. Триггер. При добавлении туриста добавляется ему отпуск.
3. Курсор. Параметр - название отеля. Выводит кол-во отелей и информацию про всех туристов, которые там проживают.

1. CREATE TRIGGER place_count_updated
AFTER UPDATE ON Hotel
BEGIN
IF old.free_place!=new.free_place Then
INSERT INTO Tourist (first_name, last_name, hotel_id) VALUES ("Nes", "Tourist", new.hotel_id);
END IF
END


2. CREATE TRIGGER add_vocation_for_tourist
AFTER CREATE ON Tourist
BEGIN
INSERT INTO Vocation (country, city, start, end) VALUES ("UA", "Kyiv", TO_DATE('2018/07/09', 'yyyy/mm/dd'), TO_DATE('2018/07/10', 'yyyy/mm/dd'));
END


3. CREATE PROCEDURE get_tourist_info(IN hotel_name varchar)
DECLARE
  hotel_count number;
  CURSOR c1
  IS
    SELECT Tourist.first_name, Tourist.last_name 
    FROM Hotel JOIN Tourist on Hotel.hotel_id=Tourist.hotel_id WHERE Hotel.name=hotel_name;
BEGIN
  SELECT count(hotel_id) INTO hotel_count 
    FROM Hotel WHERE Hotel.name=hotel_name;
  dbms_output.putline('Кол-во отелей -' hotel_count)
  FOR record in c1 LOOP
    dbms_output.putline(record.first_name)
    dbms_output.putline(record.last_name)
  END LOOP
END

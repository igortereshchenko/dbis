CREATE TRIGGER hotel_created
AFTER CREATE ON Hotel
BEGIN
INSERT INTO STAFF (country, city, name, hotel_id, description) VALUES ("UA", "BC", "Manangment", new.hotel_id, "Manangment");
END

CREATE TRIGGER raiting_changed
AFTER UPDATE ON Hotel
BEGIN
IF old.rating>new.rating Then
	DELETE FROM Tourist
		WHERE Tourist.hotel_id=new.hotel_id;
END IF
END

CREATE PROCEDURE get_staff_ingo(IN hotel_name varchar)
DECLARE
	staff_count number;
	CURSOR c1
	IS
	  SELECT STAFF.country, STAFF.city, STAFF.description 
	  FROM Hotel JOIN STAFF on Hotel.hotel_id=STAFF.hotel_id WHERE Hotel.name=hotel_name;
BEGIN
	SELECT count(STAFF.name) INTO staff_count 
	  FROM Hotel JOIN STAFF on Hotel.hotel_id=STAFF.hotel_id WHERE Hotel.name=hotel_name;
	dbms_output.putline(staff_count)
	FOR record in c1 LOOP
		dbms_output.putline(record.country)
		dbms_output.putline(record.city)
		dbms_output.putline(record.name)
		dbms_output.putline(record.description)
	END LOOP
END

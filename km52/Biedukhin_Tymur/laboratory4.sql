-- LABORATORY WORK 4
-- BY Biedukhin_Tymur
DECLARE 
    default_serial_number varchar(50) := 'beautiful';
    default_model varchar(50) := 'nice';
    default_is_working bool := true;
/*-------------------------------------
Обьявление курсора: Выводит количество хостелов на улице 
---------------------------------------*/

CURSOR street_counter(wanted_street hostels.street$TYPE) IS
SELECT COUNT(*)
FROM hostels
WHERE hostels.street = wanted_street;

/*-------------------------------------
Обьявление курсора: Выводит номера и имена студентов, что живут на указанной улице 
---------------------------------------*/

CURSOR street_dispatcher(wanted_street hostels.street$TYPE) IS
SELECT student_name, student_phone
FROM students JOIN rooms 
ON students.room_id = rooms.room_id JOIN hostels 
ON rooms.hostel_id = hostels.hostel_id
WHERE hostel.street = wanted.street

/*-------------------------------------
Тригер: При изменении номера комнаты выселяются все студенты 
---------------------------------------*/

CREATE OR REPLACE TRIGGER students_away
AFTER UPDATE OF room_number 
ON rooms
FOR EACH ROW 
BEGIN
    UPDATE students
    SET room_number = NULL
    WHERE room_number = :old.room_number;
END;

/*-------------------------------------
Тригер: При создании студента ему дается компьютер 
---------------------------------------*/

CREATE OR REPLACE TRIGGER lucky_giveaway
AFTER INSERT ON students
FOR EACH ROW 
BEGIN
    INSERT INTO computers (serial_number, _model, is_working)
    VALUES (default_serial_number, default_model, default_is_working);
    UPDATE students
    SET computer_serial_number := default_serial_number
    WHERE student_id = :new.student_id;
    default_serial_number := default_serial_number || '!';
END;

END;

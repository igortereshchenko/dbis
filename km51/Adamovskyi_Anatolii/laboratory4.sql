-- LABORATORY WORK 4
-- BY Adamovskyi_Anatolii

/*
    1. Створити тригер котрий при створені нового власника добавляє йому новий комп'ютер
*/

CREATE OR REPLACE TRIGGER create_owner_trigger AFTER
    INSERT ON owner
    FOR EACH ROW
BEGIN
    INSERT INTO computer (
        mac_address,
        comp_name,
        owner_owner_passport
    ) VALUES (
        'aa-bb-cc-dd-ee',
        'anatoliy',
        :new.owner_passport
    );

END;
/

/*
    2. Тригер котрий при зміні серійного номера апаратного забезпечення видаляє цю деталь з компютерів
*/

CREATE OR REPLACE TRIGGER update_hardware AFTER
    UPDATE OF serial_number ON hardware
    FOR EACH ROW
BEGIN
    DELETE FROM comp_hard_fk
    WHERE
        hardware_party_number =:old.party_number
        AND   hardware_serial_number =:old.serial_number;

END;
/

/*
    3. Створити курсор параметер котрого це ім'я власника який в консоль виводить всі його комп'ютери та з яких деталей вони складаються  
*/
    
DECLARE
    own_name   owner.owner_name%TYPE;
    CURSOR owner_computer_hardware (
        curr_owner_name owner.owner_name%TYPE
    ) IS SELECT
        owner.owner_name,
        computer.comp_name,
        hardware.aparat_name
         FROM
        owner
        JOIN computer ON owner.owner_passport = computer.owner_owner_passport
        JOIN comp_hard_fk ON computer.mac_address = comp_hard_fk.computer_mac_address
        JOIN hardware ON hardware.party_number = comp_hard_fk.hardware_party_number
                         AND hardware.serial_number = comp_hard_fk.hardware_serial_number
         WHERE
        owner.owner_name = curr_owner_name;

BEGIN
    own_name := 'Mike';
    FOR owner_name_comp_row IN owner_computer_hardware(own_name) LOOP
        dbms_output.put_line(owner_name_comp_row.owner_name
        || ' -> '
        || owner_name_comp_row.comp_name
        || ' -> '
        || owner_name_comp_row.aparat_name);
    END LOOP;

END;
/

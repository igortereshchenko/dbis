-- LABORATORY WORK 4
-- BY Kholin_Nikita

-- 1. Write a trigger that deletes card_records after card is deleted.

CREATE OR REPLACE TRIGGER manual_card_cascade
AFTER DELETE
   ON cards
   FOR EACH ROW
DECLARE

BEGIN
  delete from card_records
  where card_id = :old.card_id
END;

-- 2. Write a trigger that does not allow to change person's birthday if they have a card. 

CREATE OR REPLACE TRIGGER trigger_name
BEFORE UPDATE
   ON people
   FOR EACH ROW
DECLARE
  person_card_count number;
BEGIN
  select count(*)
  into person_card_count
  from cards
  where person_id = :old.id

  if person_card_count > 0 then
    :new.birthdate := :old..birthdate
  end if;
END;

-- 3. A procedure that takes a date as an input and prints notes, person name and doctor name and via a coursor with parameter.

PROCEDURE print_doctor_visits(in_visit_date IN date)
IS
  CURSOR c_visits (visit_date IN varchar2) IS
    SELECT 
      card_records.visited_at,
      people.first_name || ' ' || people.last_name as person_name,
      doctor.first_name || ' ' || doctor.last_name as doctor_name,
      card_records.notes
    FROM people
      inner join cards on cards.person_id = people.id
      inner join card_records on card_records.card_id = cards.id
      inner join doctors on doctors.id = card_recrods.doctor_id
    WHERE trunc(card_records.visited_at) = trunc(visit_date);
    
  v_visit_date date;
  v_person_name varchar2;
  v_doctor_name varchar2;
  v_notes varchar2;
BEGIN
  OPEN c_visits(in_visit_date);

  LOOP
    FETCH c_visits INTO v_visit_date, v_person_name, v_doctor_name, v_notes;
    EXIT WHEN employee_id_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_person_name || ' visited ' || v_doctor_name || ' and doctor wrote ' || v_notes); 
  END LOOP;

  CLOSE c_visits;
END;

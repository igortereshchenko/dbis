-- LABORATORY WORK 4
-- BY Bobyr_Anastasiia


-- 1. Створити тригер, що при додаванні людини створює нову медичну картку та призначає їй лікаря.

CREATE OR REPLACE TRIGGER insert_human_mc
        AFTER INSERT ON Human
         FOR EACH ROW
DECLARE
         new_card_id medicalcard.card_id %type;
         new_date doctorpatient."date" %type;
         default_doctor_id human.human_id %type;
BEGIN
select (max(card_id) + 1) into new_card_id from medicalcard;
select sysdate into new_date from dual;
select min(human_id) into default_doctor_id from humanjob where job_name = 'Doctor';

insert into medicalcard (human_id, card_id) values (:new.human_id, new_card_id);
insert into doctorpatient (human_id_pt, human_id_doc, card_id, "date") values (:new.human_id, default_doctor_id, new_card_id, new_date);

END insert_human_mc;



-- 2. Створити тригер, що при видаленні хвороби очищає всі записи з медичної картки, де записана дана хвороба.
CREATE OR REPLACE TRIGGER delete_illness
        BEFORE DELETE ON Illness
         FOR EACH ROW
DECLARE
        deleted_ill illness.illness_name%type;
        type NumberVarray is varray(100) of NUMERIC(10);
        ill_ids NumberVarray;
        it int;
BEGIN
deleted_ill := :old.illness_name;

select ill_sympt_id bulk collect into ill_ids from illnesssymptoms where illnesssymptoms.illness_name = deleted_ill;

for it in 1..ill_ids.count loop
delete from recordss where recordss.ill_sympt_id = ill_ids(it);
delete from illnesssymptoms where illnesssymptoms.ill_sympt_id = ill_ids(it);
end loop;

END delete_illness;




-- 3. Курсор з параметром: симптом. Вивести кількість хворих з даним симптомом, інформацію про картку, 
-- де зазначений даний симптом та який лікар його діагностував.

declare  
cursor cursor_pt_count (symptom symptoms.symptom_name%type) is 

select count(distinct medicalcard.human_id) as "pt_count"
from symptoms join illnesssymptoms on illnesssymptoms.symptom_name = symptoms.symptom_name 
        join recordss on illnesssymptoms.ill_sympt_id = recordss.ill_sympt_id 
        join medicalcard on recordss.card_id = medicalcard.card_id 
        join doctorpatient on doctorpatient.card_id = medicalcard.card_id 
        join human on doctorpatient.human_id_doc = human.human_id
where symptoms.symptom_name = symptom;

cursor cusror_card_doc_info (symptom symptoms.symptom_name%type) is
select 
       distinct medicalcard.card_id, medicalcard.human_id, human.human_name, human.human_surname
from illnesssymptoms  
        join recordss on illnesssymptoms.ill_sympt_id = recordss.ill_sympt_id 
        join medicalcard on recordss.card_id = medicalcard.card_id 
        join doctorpatient on doctorpatient.card_id = medicalcard.card_id 
        join human on doctorpatient.human_id_doc = human.human_id
where illnesssymptoms.symptom_name = symptom;

sympt_to_find symptoms.symptom_name%type := 'sneezing';
pt_count number := 0;
cardid medicalcard.card_id%type;
humanid medicalcard.human_id%type;
doctorname human.human_name%type;
doctorsurname human.human_surname%type;
         
begin

open cursor_pt_count (sympt_to_find);
fetch cursor_pt_count into pt_count;
if (cursor_pt_count %FOUND) then
DBMS_OUTPUT.PUT_LINE('Count of patients with symptom ' || sympt_to_find || ': ' || pt_count);
end if;
close cursor_pt_count;

open cusror_card_doc_info (sympt_to_find);

DBMS_OUTPUT.PUT_LINE('Information about cards of patients with symptom ' || sympt_to_find || ' and doctors who diagnozed it.');
loop 
    fetch cusror_card_doc_info into cardid, humanid, doctorname, doctorsurname;
        if (cusror_card_doc_info %FOUND) then
            DBMS_OUTPUT.PUT_LINE('CARD INFO: Card id is ' || cardid || ', human id is ' || humanid || '. DOCTOR: ' || doctorname || ' ' || doctorsurname);
        else exit;
    end if;
end loop;
end;






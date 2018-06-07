-- LABORATORY WORK 4
-- BY Vozniak_Anastasiia

Create Sequence num_id
Start with 1007
Increment by 1;

Create or Replace TRIGGER new_card
After insert into Patient

Declare
new_name patient.patient_name%type;
new_surname patient.patient_surname%type;
new_phone patient.patient_phone%type;

Begin

SELECT :new.patient_name into new_name,
:new.patient_surname into new_surname,
:new.patient_phone into new_phone
FROM Patient;

Insert into patientcard (card_id,doctor_license, patient_name, patient_surname, patient_phone)
values(num_id.nextval,'5555', new_name, new_surname, new_phone);

end new_card;

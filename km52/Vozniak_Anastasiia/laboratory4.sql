-- LABORATORY WORK 4
-- BY Vozniak_Anastasiia

CREATE SEQUENCE num_id START WITH 1007 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER new_card AFTER
    INSERT ON patient
DECLARE
    new_name      patient.patient_name%TYPE;
    new_surname   patient.patient_surname%TYPE;
    new_phone     patient.patient_phone%TYPE;
BEGIN
    SELECT
        patient_name,
        patient_surname,
        patient_phone
    INTO
        new_name,new_surname,new_phone
    FROM
        patient
    WHERE
        patient_name =:new.patient_name
        AND   patient_surname =:new.patient_surname
        AND   patient_phone =:new.patient_phone;

    INSERT INTO patientcard (
        card_id,
        doctor_license,
        patient_name,
        patient_surname,
        patient_phone
    ) VALUES (
        num_id.NEXTVAL,
        '5555',
        new_name,
        new_surname,
        new_phone
    );

END new_card;


CREATE OR REPLACE TRIGGER delete_symptom AFTER
    UPDATE OF name ON ill
    FOR EACH ROW
BEGIN
    DELETE FROM illsymptoms;

END delete_symptom;

create or replace procedure info_patient (name_ill patientcard.ill_name%type) is
dECLARE
	
    
	CURSOR patient_info(illname patientcard.ill_name%type) IS
		SELECT patient_name,patient_surname, patient_phone,doctor_license FROM patientcard
		WHERE ill_name = illname;
	info patient_info%ROWTYPE;
    doc_name doctors.name%type;
    doc_surname doctors.surname%type;

BEGIN
	
	OPEN patient_info(name_ill);
	FETCH patient_info INTO info;
    
    select doctors.name into doc_name,
doctors.surname into doc_surname
FROM
    doctors right
    JOIN patientcard ON patientcard.license = doctors.lisence
    where doctors.lisence =
    info.doctors_license;
    LOOP
        dbms_output.put_line('Patient: '
        || info.patient_name
        || ' '
        || info.patient_surname
        || ' Phone: '
        || info.patient_phone
        || ' Doctor: '
        || doc_name
        || ' '
        || doc_surname);

        FETCH patient_info INTO info;
        EXIT WHEN patient_info%notfound;
    END LOOP;

    CLOSE patient_info;
end
info_patient;

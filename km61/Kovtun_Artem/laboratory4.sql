-- LABORATORY WORK 4
-- BY Kovtun_Artem


(1) Створити курсор, що по марці машини виводить всіх людей, що коли-небудь мали таку да де вони проживають

SET SERVEROUTPUT ON;

DECLARE 
CURSOR brand_cursor(car_brand CARS.CAR_BRAND%TYPE)
IS
    SELECT DISTINCT TRIM(CITIZENS.CITIZEN_FIRST_NAME) || ' ' || TRIM(CITIZENS.CITIZEN_SECOND_NAME) AS CITIZEN_NAME,
                    HOUSES.HOUSE_ID
                        FROM CARS  JOIN CITIZENCAR ON CARS.CAR_ID = CITIZENCAR.CAR_ID_FK
                                              JOIN CITIZENS ON CITIZENCAR.CITIZEN_ID_FK = CITIZENS.CITIZEN_ID
                                              JOIN CITIZENHOUSE ON CITIZENS.CITIZEN_ID = CITIZENHOUSE.CITIZEN_ID_FK
                                              JOIN HOUSES ON CITIZENHOUSE.HOUSE_ID_FK = HOUSES.HOUSE_ID
                                                       WHERE CARS.CAR_BRAND = car_brand;
            
BEGIN 
    FOR citizen in brand_cursor('Aston Martin')
        LOOP
            DBMS_OUTPUT.PUT_LINE(citizen.citizen_name || ' ' || citizen.house_id);
        END LOOP;
END;


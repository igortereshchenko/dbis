-- LABORATORY WORK 4
-- BY Kozyriev_Anton

-- 1. Створити триггер: при зміні cust_name всі номера змінюються на +00(000)000-00-00

CREATE OR REPLACE TRIGGER change_cust_name
    AFTER INSERT OR UPDATE ON Customer
    FOR EACH ROW  
DECLARE
    v_cust_name Customer.cust_name%TYPE := :new.cust_name;
BEGIN
    UPDATE Customer SET RESERVED_PHONE_NUMBER = '+00(000)000-00-00'
    WHERE cust_name = v_cust_name;
END;

-- 2. Створити триггер: при додавані вендора, йому додається телефон

CREATE OR REPLACE TRIGGER add_vendor
    AFTER INSERT ON Vendor
DECLARE
    v_vend_id Vendor.vend_id%TYPE := :new.Vendor.vend_id;
    c_default_p_s PHONE.PHONE_SERIAL%TYPE := 'AA111';
    c_default_b_s PHONE.BRAND_SERIAL%TYPE := 'AA111';
    c_default_r_f PHONE.RESERVED_PHONE_NUMBER%TYPE := '+00(000)000-00-00';
    c_default_p_m PHONE.RESERVED_PHONE_NUMBER%TYPE := 'Empty Model';
BEGIN
    INSERT INTO Phone(phone_serial, brand_serial, reserved_phone_number, phone_model, phone_price, vend_id)
    VALUES (c_default_p_s, c_default_b_s, c_default_r_f, c_default_p_m, 0, v_vend_id);
END;

-- 3. Створити курсор: параметр - модель телефону, вихідні дані - усі власники моделі

SET SERVEROUTPUT ON
DECLARE
    CURSOR owners_by_model(param_phone_model PHONE.PHONE_MODEL%TYPE)
    IS
        SELECT Customer.cust_name
        FROM Phone JOIN Customer
        ON PHONE.RESERVED_PHONE_NUMBER = CUSTOMER.RESERVED_PHONE_NUMBER
        WHERE PHONE.PHONE_MODEL = param_phone_model;
        
    v_phone_number PHONE.PHONE_MODEL%TYPE := &v_phone_number;
    v_cust_name Customer.cust_name%TYPE;
BEGIN  
    OPEN owners_by_model(v_phone_number);
    
    DBMS_OUTPUT.PUT_LINE('+------------------------+');
    LOOP
        FETCH owners_by_model INTO v_cust_name;
        
        IF (owners_by_model%FOUND) THEN
            DBMS_OUTPUT.PUT_LINE('Model ' || v_phone_number || ' own(s) ' || v_cust_name);
        
        ELSE
            DBMS_OUTPUT.PUT_LINE('+------------------------+');
            EXIT;
        
        END IF;
    END LOOP; 
END;

-- LABORATORY WORK 4
-- BY Berenchuk_Olha

/*1. При зміні імені видаляються телефони що пов'язані з даною людиною*/

CREATE OR REPLACE TRIGGER delete_ph
BEFORE UPDATE OF human_name
on Human
FOR EACH ROW
BEGIN
DELETE FROM Human_what_buy_Mobile
WHERE human_name =: old.human_name;
END;

--------------------------------------------------------
/*2. При додаванні магазин телефон, то одразу з'являються аксесуари в магазині*/

CREATE OR REPLACE TRIGGER add_mobile
AFTER INSERT ON Mobile
FOR EACH ROW
BEGIN
INSERT INTO Mobile_shop(acces_name,acces_id) values
('chehol','10101');
end;

--------------------------------------------------------
/*3. Параметр: ім'я магазину
    Ім'я людей, що купують телефон.*/
DECLARE 

CURSOR human_name
IS SELECT Human_name FROM Human_what_buy_mobile
WHERE Mobile_brand_fk = 'Nokia270';
END;

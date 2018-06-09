-- LABORATORY WORK 4
-- BY Koltsov_Dmytro
1) Триггер что при изменении языка OS удаляет все установленные программы.
create or replace TRIGGER language
    BEFORE UPDATE OF language ON OS_WINDOWS
    FOR EACH ROW
DECLARE

BEGIN
    DELETE FROM SOFT_IS_INCTALL 
    where EXISTS
        (SELECT SOFT_IS_INCTALL.VERSION 
        FROM OS_WINDOWS, SOFT_IS_INCTALL
        WHERE 
            OS_WINDOWS.LANGUAGE = :old.LANGUAGE
            and
            OS_WINDOWS.VERSION = SOFT_IS_INCTALL.VERSION);

END E_dal;


2) Триггер что при изменении объема пмяти меняет версию OS.
create or replace TRIGGER memory
    AFTER UPDATE OF MEMORY ON SOFTWARE
    FOR EACH ROW
DECLARE
    ver OS_WINDOWS.VERSION%type;
BEGIN
    ver := '0.0.2';
    UPDATE OS_WINDOWS
    set VERSION = ver;
    UPDATE OS_IS_INSTULL
    set VERSION = ver;
    UPDATE OS_IS_INSTULL
    set VERSION = ver;
END E_dal;


3) Написать курсор параметр модель выводит весь установленыйй софт
DECLARE
    nama SOFT_IS_INCTALL.NAME%TYPE;

CURSOR MODELE(MOD СOMPUTER.MODEL%TYPE)
is
SELECT SOFT_IS_INCTALL.NAME
FROM
    СOMPUTER LEFT NATURAL JOIN OS_IS_INSTULL
    LEFT NATURAL JOIN OS_WINDOWS
    LEFT NATURAL JOIN SOFT_IS_INCTALL
WHERE
    MODEL = 1001;
    
BEGIN
OPEN MODELE (1003);
LOOP 
    FETCH MODELE INTO nama;
        if(MODELE%FOUND) then 
            DBMS_OUTPUT.PUT_LINE(nama);
        else
            exit;
        END if;
END LOOP;
CLOSE MODELE;
end;

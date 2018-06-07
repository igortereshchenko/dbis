/*
Курсор с параметром - название программы, который выводит в консоль id компьютера 
--где установлена программа и количество железа в данном компьютере:
*/
SET SERVEROUTPUT ON
declare
id COMPUTER.COMPUTER_ID%type;
hardware_count int;
cursor computers(name in PROGRAMS.PROGRAM_NAME%type)
is select computer_id, count(hardware_id) as hardware_count
from programs
    left join installed_program using(program_id)
    left join computer using(computer_id)
    left join has_hardware using(computer_id)
group by computer_id, program_name
having program_name = name;
begin
    open computers('ORACLE');
    loop
        fetch computers into id, hardware_count;
        if (computers%found) then
        DBMS_OUTPUT.put_line('id: ' || id || 'hardware: '  || hardware_count);
        else
            exit;
        end if;
    end loop;
    close computers;
end;

/*
Триггер который при изменении названия программы удаляет ее из компьютера:
*/
create or replace trigger change_name
after update on programs
for each row
declare
begin
if :old.program_name != :new.program_name then
    delete from INSTALLED_PROGRAM
    where program_id = :new.program_id;
end if;
end;

/*
Триггер который при создании компьютера добавляет ему 1 железо:
*/
create or replace trigger create_comp
after insert on computer_id
for each row
declare
new_hardware_id HAS_HARDWARE.HARDWARE_ID%type;
begin
    select hardware_id into new_hardware_id from hardware where rownum = 1;
    insert into HAS_HARDWARE(computer_id, hardware_id)
    values (:new.computer_id, new_hardware_id);
end;


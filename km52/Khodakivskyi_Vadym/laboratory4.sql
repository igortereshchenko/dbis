-- LABORATORY WORK 4
-- BY Khodakivskyi_Vadym
-- тригер при додаванні школи додає 3 класи
CREATE OR REPLACE TRIGGER ins_classroom
AFTER INSERT ON SCHOOL 
for EACH ROW 
declare
max_class NUMBER;
begin
    SELECT max(class_number) into max_class
    from CLASSROOM;
    for i in 1..3 loop
    insert into CLASSROOM(CLASS_NUMBER,school_number, adress, class_volume, class_floor) 
    VALUES (max_class + i, :new.school_number, :new.adress, NULL, NULL);
    end loop;
END ins_classroom;

-- тригер не дає видалити стілець, якщо є хоча б 1 стіл
create view chairview as select * from chair;

create or replace trigger stop_delete
INSTEAD of delete ON Chairview
for each row
declare
count_table Number;
begin
select count(*) into count_table
from "Table" 
where CLASS_NUMBER = :old.class_number;
if count_table = 0 then
delete from CHAIR
where chair_id = :old.chair_id;
end if;
end stop_delete;

-- курсор(адреса), виводить на в консоль школу, кількість класів, стільців, столів
set serveroutput on;
declare
sch_num school.school_number%type;
count_class Number;
count_chair number;
count_table number;

cursor school_cursor(address school.adress%Type)
is 
select school.school_number, count(classroom.class_number), count(chair.chair_id), count("Table".table_id)
from 
school left join classroom on school.school_number = classroom.SCHOOL_NUMBER and school.adress = classroom.adress
left join "Table" on classroom.CLASS_NUMBER = "Table".class_number
left join chair on classroom.CLASS_NUMBER = chair.class_number
where school.adress = address
group by school.SCHOOL_NUMBER;

begin 

open school_cursor('Ruginska 30/32');
 fetch school_cursor into sch_num, count_class, count_chair, count_table;
 DBMS_OUTPUT.PUT_LINE(sch_num ||' '|| count_class ||' '|| count_chair ||' '|| count_table);
close school_cursor;
end;

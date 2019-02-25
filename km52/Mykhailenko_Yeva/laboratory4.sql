-- LABORATORY WORK 4
-- BY Mykhailenko_Yeva
-- 1. Тригер, котрий при зміні розмірів кімнати видаляє всі столи і стільці із неї.

create or replace trigger room_size_update
after update
of room_size
on classroom
declare
begin
update classroom
set :new.number_chairs := 0;
:new.number_desks := 0
end;

-- 2. Тригер, що забороняє видалення стільця, при наявності стола у кімнаті.

create or replace trigger chair_deleting
before delete
on chairs
for each row
begin
if (select number_desks into numdesk
from classroom join chairs on
classroom.room_id = chairs.room_id
where :old.chair_id != :new.chair_id)!=0
then 
raise_application_error(-20000, 'Cannot delete chair. There is a table in the room')
end if
end;

-- 3. Курсор з параметром (розмір кімнати), що виводить всю інформацію про стільці у ній

cursor room_size_chair_info
( class_size classroom.room_size%TYPE)
return chairs%ROWTYPE
is select *
from chairs
where
classroom.room_size = class_size;

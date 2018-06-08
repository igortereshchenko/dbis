-- LABORATORY WORK 4
-- BY Dreiev_Ihor
-- 1. Тригер що при видаленні кімнати видаляє студентів що в ній проживають

create or replace trigger task_1 
before delete on room
for each row
declare
  null;
begin
delete from student
where student.room_id = :old.id
and hostel_id = :old.hostel_id;
end;


-- 2. Тригер що при додаванні готелю створює в ньому 1 дефолт кімнату
create or replace trigger task_2 
after insert on hostel 
for each row
begin
insert into room
values(1, :new.id);

end;

-- 3. Курсор(адреса) виводить назви готелів з даною адресою та вказує к-сть людей в ньому
cursor(addr in hostel.address%TYPE) is
select hostel.name, count(*) 
from hostel join student on hostel.id = student.hostel_id
where hotel.address = addr
group by hostel.name;

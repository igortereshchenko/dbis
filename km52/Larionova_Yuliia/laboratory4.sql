-- LABORATORY WORK 4
-- BY Larionova_Yuliia

--1. Написать триггер, который при добавлении classroom добавляет 10 chairs.
create trigger add_chair
after insert 
    on classrooms
    for each row
declare
begin
    for i in 1..10
        loop
            insert into chairs (CHAIRS.SERIAL_NUMBER, CHAIRS.CLASSROOM_NUMBER, CHAIRS.BUILDING_ADRESS) 
            values (to_char(i), :new.classroom_number, :new.building_adress);
        end loop;
end;


--2. Написать триггер, который запрещает изменять колличество этажей в здании, которое имеет classroom.
create or replace trigger floor_number
before update
   on buildings
   for each row
declare
  existence_classrooms number;
begin
  select count(*)
  into existence_classrooms
  from classrooms
  where building_adress = :old.building_adress

  if existence_classrooms > 0 then
    :new.number_of_floors := :old.number_of_floors
  end if;
end;

--3. Написать курсор, который имеет параметр - адрес здания и выводит в консоль 
--   серийный номер стульев, для всех классов в этом здании.
SET SERVEROUTPUT ON
declare 
    ch_serial_number chairs.serial_number%type;
    cursor ch_number(adress chairs.building_adress%type) is
        select serial_number from chairs
        where building_adress = adress;
begin
    DBMS_OUTPUT.enable;
    open ch_number('Ave Victory, 37');
    loop
        fetch ch_number into ch_serial_number;
        exit when ch_number%notfound;
        dbms_output.put_line('Serial numbers is: '|| ch_serial_number);
    end loop;
    close ch_number;
end;

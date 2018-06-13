-- LABORATORY WORK 4
-- BY Buchynska_Kateryna

-----------------------1--------------------
Create trigger trig_name
after insert on House 
for each row 

Declare room_num Room.rom_number%type,
house_num Room.house_num%type

Begin 
room_num :=: new Room.rom_number,
house_num :=: new Room.house_num
insert into Room(house_number, room_number)  Values (house_num, room_num) 

 end trig_name;
--------------------------------2--------------------------
Create trigger trig_name1
after update on House 
for each row 

declare 
    house_str House.street%type

begin 
    house_str :=: new House.street
    delete from house
    where House.street = house_str

end trig_name1;     
---------------------------------------3---------------------------

    create test_cursor(str_name House.street)
    is 
    select House.street, House.number_, house.number_ofFloors, House.number_of_entrances, count (Room.room_number) from House join rooms
    on House.room_nuber = Room.room_number
    where 
        House.street = Room.house_street
        ----------------------------
    

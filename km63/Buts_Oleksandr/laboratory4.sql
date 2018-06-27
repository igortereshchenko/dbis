-- LABORATORY WORK 4
-- BY Buts_Oleksandr
##
create trigger t
before update on house
for each row
declare
x=house.SQ_house%TYPE
y=house.idh%type
begin
x=:old house.SQ_house
select idh into y from house
where SQ_house=x
insert into flat(house_idh) values(y) 
end
##
create trigger d
before insert on humans
for each row
declare 
x=humans.house_idh%type
y=house.count_of_flats%type
begin
x=:new humans.house_idh
y=:old house.count_of_flats
insert into flat(house_idh) values(x)
update house
set count_of_flats=y+1
where idh=x
end
##
declare
l house.SQ_house%type
create cursor X(a house.SQ_house%type)
is select idh,count_flats
from house 
where house.SQ_name=a
begin
for i in X(l) LOOP
dbms_output.output_line(i.idh||" "||i.count_of_flats)
end loop
end

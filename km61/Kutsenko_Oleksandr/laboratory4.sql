-- LABORATORY WORK 4
-- BY Kutsenko_Oleksandr

/*-----------------------
1. Написати тригер , що при зміні країни видаляє людей що в ній живуть.
------------------------*/
Create or replace trigger delete_people after update of country_name on country 
declare
begin
delete from temporaryh-c where country_name=:old.country_name
end;
/*-----------------------
2. Написати тригер , що при додаванні нової людини створює їй новий номер телефону.
------------------------*/
Create or replace trigger new_phonenum after insert on human 
declare
phone_id phone.phone_id%type;
phone_number phone.phone_number%type;
operator_id phone.operator_id%type;
begin
insert into phone (phone_id,phone_number,operator_id) 
values (phone_id,phone_number,operator_id)
insert into temporaryh_p (human_id,phone_id) values (:new.human_id,phone_id);
end;
/*-----------------------
3. Написати курсор з параметром (назва оператора) вивести ім'я людей які користуються цим оператором.
------------------------*/
declare 
create cursor operators_cust (operator_name) as select human_name from human join phone join operator on human.human_ip=phone.human_id 
where operator_id in (select operator_id from operator where operator.operator_name=operator_name) ;
begin
for human_name in operators_cust(operator_name)
loop
dbms_output.put_line (human_name)
end loop;
end;

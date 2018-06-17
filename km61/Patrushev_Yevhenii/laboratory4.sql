-- LABORATORY WORK 4
-- BY Patrushev_Yevhenii

-- trigger при обновлении дня рождения у человека менять ему прописку на default
create or replace trigger update_human
after update on human
for each row
declare
    default_house_id number(3) := 1;
begin
    if (:old.birhday != :new.birthday) then
        update registration_address set house_id_fk = default_house_id
        where (ident_code_fk = :new.ident_code);
    end if;
end;


-- trigger при добавлении нового человека добавлять ему машину 
create or replace trigger insert_human
after insert on human
for each row 
declare 
    last_number number(3);
begin
    /* generate last number*/
    select max(auto_number) into last_number
    from PERSONAL_AUTO;
    
    insert into PERSONAL_AUTO(auto_number, mark, model, ident_code_fk, registration_start_date) 
    values (last_number + 1, 'ep54', 'BMW', :new.ident_code, date.sysdate);
end;


-- cursor с параметром street который выводит имена людей прописаных на этой улице
declare
name_user human.first_name%type;
cursor search_names(street house.street%type)
is
    select human.first_name
    from human join registration_address
    on human.ident_code = registration_address.ident_code_fk
    join HOUSE
    on house.house_id = registration_address.house_id_fk
    where house.street = street;
    
begin
    open search_names('Obolon');
    loop
        fetch search_names into name_user;
        if (search_names%found) then
            dbms_output.put_line('name :' || name_user);
        else
            exit;
        end if;
    end loop;
    close search_name;
end;

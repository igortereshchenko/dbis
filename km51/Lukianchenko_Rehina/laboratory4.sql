-- LABORATORY WORK 4
-- BY Lukianchenko_Rehina
-- При изминении MAC адресса, удалять hardware со всех таблиц

create or replace trigger changeMACadress
AFTER UPDATE of computer_mac_adress on computer
FOR EACH ROW
declare
cpuc  varchar2(20);
psuc  varchar2(20);
BEGIN
select cpu.cpu_code, psu.psu_code into cpuc, psuc
from computer_has_hardware
    join hardware
    on computer_has_hardware.cpu_code = hardware.cpu_code and computer_has_hardware.psu_code = hardware.psu_code
    join cpu 
    on hardware.cpu_code = cpu.cpu_code
    join psu
    on hardware.psu_code = psu.psu_code
    where computer_has_hardware.computer_code = :old.computer_code;
   
    delete from computer_has_hardware
    where (cpu_code = cpuc) or (psu_code = psuc);

    delete from hardware
    where (cpu_code = cpuc) or (psu_code = psuc);

    delete from cpu
    where cpu_code = cpuc ;

    delete from psu
    where psu_code=psuc;

END;


---При изминении версии ОС, удалять ОС с ПК
create or replace trigger changeOSversion
BEFORE UPDATE of os_version on software
FOR EACH ROW
BEGIN
delete from computer_has_software
where operation_system = :old.operation_system 
and os_version = :old.os_version;
end;


--Вывести через курсор с параметром модель CPU  все ПК на которых стоит CPU

 
 declare 
 cpu_m  cpu.cpu_model%type;
 
 cursor comp(cpu_model_name  cpu.cpu_model%type) is 
 select distinct computer_code
 from computer_has_hardware
 where cpu_code = cpu_model_name;
 
 comp_rec comp%rowtype;
 
 begin
 cpu_m := 'DF8976JFD84';
 open  comp(cpu_m);
 loop
   
   fetch comp into comp_rec;
   EXIT WHEN comp%NOTFOUND;
   dbms_output.put_line (comp_rec.computer_code ); 

  end loop;
 CLOSE comp; 
 end;
 

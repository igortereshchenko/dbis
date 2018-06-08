-- LABORATORY WORK 4
-- BY Kharchenko_Kateryna
/*При зміні назви країни добавляти новий оператор*/
CREATE OR REPLACE TRIGGER num1 
BEFORE UPDATE ON Countries.country_name
FOR EACH ROW
DECLARE 
newoperator CHAR(30);
countr CHAR(30);
BEGIN 
newoperator := old.Countries.country_name ||'mob ';
Insert into Operators
Values (newoperator);
Insert into Countries_has_operators
Values (newoperator, new.Countries.country_name , '000');
IF Countries_has_operators = old.Countries.country_name then 
Countries_has_operators := new.Countries.country_name
end if;
end num1;

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
IF phoneNumbers.country_name = old.Countries.country_name then 
phoneNumbers.country_name := new.Countries.country_name
end if;

end num2;
/*При додаванні нового студента йому додаеться дефолтній оператор*/
CREATE OR REPLACE TRIGGER num2 
BEFORE UPDATE ON Students.student_name
FOR EACH ROW
DECLARE 
newphon NUMBER(20);
cod CHAR(20);
BEGIN 
SELECT MaX(phoneNumber) + 1 into newphon
FROM phoneNumbers;
SELECT student_IDCardNumber into cod
FROM phoneNumbers
WHERE Students.student_name = old.Students.student_name;
Insert into phoneNumbers
Values (new.Students.student_name, cod, 'Oper ', 'Cuba', newphon , '2010');
IF phoneNumbers.student_name = old.Students.student_name then 
phoneNumbers.student_name := new.Students.student_name
end if;
end num2;

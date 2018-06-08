-- LABORATORY WORK 4
-- BY Ostapenko_Kostiantyn
--при изменении имени студента удаляются его блокноты
create or replace trigger changeStudent
before update of name on student 
for EACH ROW
declare
count_notebook number;
nb_code notebook.notebook_code%type;
begin

select count(notebook_code) into count_notebook
from students_have_notebooks
where email = :old.email;

for I IN 1..count_notebook LOOP
    
select notebook_code into nb_code
from students_have_notebooks
where email = :old.email
and rownum=1;

delete from students_have_notebooks
where notebook_code = nb_code;
delete from notebook
where notebook_code = nb_code;

  END LOOP;
  end;
  
  
  -- при добавлении блокнота для студента, добавляется новый студент
  
  create or replace trigger addNewNotebook
before insert on students_have_notebooks
for each row
begin

insert into student (email) values(:new.email);
insert into notebook (notebook_code,notebook_name) values(:new.notebook_code,:new.notebook_name);

end;


-- Курсор(имя блокнота) выводит всех студентов которые работали с блокнотом

set serveroutput on 
declare
cursor students_cur(nb_name notebook.notebook_name%type) is
select (student.name||' '||student.surname) as student
from student join students_have_notebooks
on student.email = students_have_notebooks.email
where students_have_notebooks.notebook_name = nb_name;

stud  students_cur%rowtype;
nb_name notebook.notebook_name%type;
begin
nb_name :='love';

for stud in students_cur(nb_name)
loop
dbms_output.put_line( stud.student);
end loop;
end;

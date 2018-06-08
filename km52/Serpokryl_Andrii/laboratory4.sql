-- LABORATORY WORK 4
-- BY Serpokryl_Andrii
/* тригер який при видаленні Dept видаляє всі Group для цього Dept */
create or replace trigger dept_group_del_trg
  after delete on Departments
  for each row
  
  declare
   a departments_has_groups.group_name%type;
   b departments_has_groups.group_year%type;
   begin
   
   select departments_has_groups.group_name into a
   from departments_has_groups
   where departments_has_groups.department_name = :old.department_name and
      departments_has_groups.department_code = :old.department_code
    
   select departments_has_groups.group_year into b
   from departments_has_groups
   where departments_has_groups.department_name = :old.department_name and
      departments_has_groups.department_code = :old.department_code
      
   delete from Group
   where group_name = a and
         group_year = b
end;

/*при зміні назви факультету створ новий департм з назвою новго факультету */
create or replace trigger new_faculty_new_dept_trg
        after update of faculty_name on faculty
        for each row
        declare
         c department.depatment_code%type
        begin
          select department.depatment_code into c
          from department 
          where department.faculty_name = :old.faculty_name
          
          insert into department(department_name, department_code)
            values(:new.faculty_name, c)
 end;      


/* курсор з параметром назва універ вивводить кі-ть департмнетів */ 
cursor univer_group (univer_name university.university_name%type) is
      return number 
      is
      dept_count number;
      begin
      select count(distinct department.department_name) into dept_count
        from university 
        join faculty on
        university.university_name = faculty.university_name 
        join department on
        faculty.faculty_name = department.faculty_name
        where university.university_name = univer_name
        group by department.department_name, department.department_code;
       return dept_count
   end;
  

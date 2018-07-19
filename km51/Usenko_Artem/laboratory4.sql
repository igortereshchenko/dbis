-- LABORATORY WORK 4
-- BY Usenko_Artem

--Триггер при добавление програмиста ставить ему стандартный язык (например C++)
create or replace Trigger addDefaultLanguage AFTER Insert 
                                             On Programist
                                             FOR EACH ROW

Declare

defaultLanguage Varchar(3) :=  'C++';

languageId  Language.language_id%type;

id Number;

prog_id Programist.programist_id%type;

Begin

id := programist_language_seq.NextVal;

prog_id := :new.programist_id;

Select (Language_id) into languageId From Language where Language_name = defaultLanguage;

INSERT INTO PROGRAMIST_LANGUAGE (PROGRAMIST_LANGUAGE_ID, PROGRAMIST_ID, LANGUAGE_ID, PROGRAMIST_LANGUAGE_EXP) VALUES (id, prog_id, languageId, '0');

End addDefaultLanguage;


--Триггер при изменение или удаление языка програмирования удалять програмистов которые учили его 

create or replace Trigger DeleteUser BEFORE Update OR DELETE
                                             On Language
                                             FOR EACH ROW

Declare

languageId  Language.language_id%type;

prog_id PROGRAMIST_LANGUAGE.programist_id%type;

CURSOR getProgramist(languageId PROGRAMIST_LANGUAGE.LANGUAGE_ID%type) IS
        SELECT programist_id FROM PROGRAMIST_LANGUAGE 
            where LANGUAGE_ID = languageId
            GROUP BY programist_id;

Begin

Open getProgramist(:old.language_id);

LOOP

 FETCH getProgramist INTO prog_id;

 EXIT WHEN getProgramist%NotFound;
 
 DELETE FROM PROGRAMIST_LANGUAGE WHERE PROGRAMIST_ID = prog_id;
 
 DELETE FROM PROGRAMIST_JOB WHERE PROGRAMIST_ID = prog_id;
    
 DELETE FROM PROGRAMIST WHERE PROGRAMIST_ID = prog_id;
    
END LOOP;
 
 CLOSE getProgramist;

End DeleteUser;

--Вывести с помощью курсора название проектов где используеться заданый язык програмирования и прграмистов которые там работают

Declare

languageId  Language.language_id%type;

findLanguage Varchar(3) := 'C++';

prog_id PROGRAMIST_LANGUAGE.programist_id%type;

CURSOR getProgramistJob(findLanguageId Language.LANGUAGE_ID%type) IS
       SELECT Programist_JOB.PROJECT_NAME, Programist_JOB.PROJECT_VERISON FROM 
                PROGRAMIST_LANGUAGE INNER JOIN Programist On PROGRAMIST_LANGUAGE.PROGRAMIST_ID = PROGRAMIST.programist_id AND
                                                             PROGRAMIST_LANGUAGE.LANGUAGE_ID = findLanguageId
                 INNER JOIN Programist_JOB ON PROGRAMIST.programist_id = Programist_JOB.PROGRAMIST_ID
                 GROUP BY Programist_JOB.PROJECT_NAME, Programist_JOB.PROJECT_VERISON;

CURSOR getProgramist(projectName PROGRAMIST_JOB.project_name%type) IS
  SELECT Programist.programist_first_name, Programist.PROGRAMIST_LAST_NAME FROM 
                PROGRAMIST_LANGUAGE INNER JOIN Programist On PROGRAMIST_LANGUAGE.PROGRAMIST_ID = PROGRAMIST.programist_id
                 INNER JOIN Programist_JOB ON PROGRAMIST.programist_id = Programist_JOB.PROGRAMIST_ID AND Programist_JOB.PROJECT_NAME=projectName
                 GROUP BY Programist.programist_first_name, Programist.PROGRAMIST_LAST_NAME;


projectRow getProgramistJob%ROWTYPE;

programistRow getProgramist%ROWTYPE;

Begin

SELECT LANGUAGE_ID INTO languageId FROM LANGUAGE WHERE LANGUAGE_NAME = findLanguage;

Open getProgramistJob(languageId);

LOOP

 FETCH getProgramistJob INTO projectRow;

 EXIT WHEN getProgramistJob%NotFound;

 OPEN getProgramist(projectRow.project_name);   

 dbms_output.put_line('Project :  '  ||
                       trim(projectRow.project_name) || ' ' || projectRow.PROJECT_VERISON); 

 LOOP
  FETCH getProgramist INTO programistRow;

  EXIT WHEN getProgramist%NotFound;
     
 dbms_output.put_line( trim(programistRow.programist_first_name) 
                            || ' ' ||
                       trim(programistRow.programist_last_name));
     
 END LOOP;
Close getProgramist;
 
END LOOP;
 
 CLOSE getProgramistJob;

End;


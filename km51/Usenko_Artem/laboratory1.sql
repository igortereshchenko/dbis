/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може:
робити вибірки з таблиць та видалення даних
4 бали

---------------------------------------------------------------------------*/
Create user usenko IDENTIFIED by usenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER usenko QUOTA 100M on "USERS";


GRANT "CONNECT" to usenko;
GRANT SELECT any TABLE to usenko;
GRANT DROP any TABLE to usenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі
створювати окремо від таблиць використовуючи команди ALTER TABLE.
Програмісти програмують на мові C++
4 бали

---------------------------------------------------------------------------*/

DROP TABLE PROGRAMIST;
DROP TABLE Language;
DROP TABLE Programist_Language;
DROP TABLE Programist_Job;

CREATE TABLE Programist
(
  programist_id NUMBER not null,
  programist_first_name VARCHAR(40) not null,
  programist_last_name VARCHAR(40) not null,
  programist_level VARCHAR(15) not null
);


CREATE SEQUENCE programist_seq
  START WITH 1
  INCREMENT BY 1;
  

Alter TABLE Programist ADD CONSTRAINT programist_pk PRIMARY KEY (programist_id);
Alter Table Programist ADD CONSTRAINT programist_level_check CHECK (REGEXP_LIKE(programist_level, '^(junior|middle|senior|traniee)$'));
Alter Table Programist ADD CONSTRAINT programist_first_name_check CHECK (REGEXP_LIKE(programist_first_name, '^[A-Z]{1,1}[a-z]{0,39}$'));
Alter Table Programist ADD CONSTRAINT programist_last_check CHECK (REGEXP_LIKE(programist_last_name, '^[A-Z]{1,1}[a-z]{0,39}$'));
Alter Table Programist ADD CONSTRAINT constraint_programist_unique UNIQUE (programist_first_name,programist_last_name);


INSERT INTO Programist(programist_id,programist_first_name,programist_last_name,programist_level) VALUES (programist_seq.nextval,'artem','usenko','junior');
INSERT INTO Programist(programist_id,programist_first_name,programist_last_name,programist_level) VALUES (programist_seq.nextval,'vadim','vadim','junior');
INSERT INTO Programist(programist_id,programist_first_name,programist_last_name,programist_level) VALUES (programist_seq.nextval,'petya','petya','middle');
INSERT INTO Programist(programist_id,programist_first_name,programist_last_name,programist_level) VALUES (programist_seq.nextval,'vasya','vasya','middle');
INSERT INTO Programist(programist_id,programist_first_name,programist_last_name,programist_level) VALUES (programist_seq.nextval,'artur','artur','senior');

CREATE TABLE Language
(
  language_id NUMBER not null,
  language_name VARCHAR(40) not null,
  language_version VARCHAR(10) not null,
  language_interface_type VARCHAR(15) not null
);


CREATE SEQUENCE language_seq
  START WITH 1
  INCREMENT BY 1;
  
Alter TABLE language ADD CONSTRAINT language_pk PRIMARY KEY (language_id);
Alter Table language ADD CONSTRAINT language_interface_type_check CHECK (REGEXP_LIKE(language_interface_type, '^(compiled|interpreted)$'));
Alter Table language ADD CONSTRAINT language_name_check CHECK (REGEXP_LIKE(language_name, '^[a-z|+|#]{0,39}$'));
Alter Table language ADD CONSTRAINT language_version_check CHECK (REGEXP_LIKE(language_version, '^((\d+\.)?(\d+\.)?(\*|\d+))$'));
Alter Table language ADD CONSTRAINT constraint_language_unique UNIQUE (language_name,language_version,language_interface_type);


INSERT INTO Language(language_id,language_name,language_version,language_interface_type) VALUES (language_seq.nextval,'C++','1.12','compiled');
INSERT INTO Language(language_id,language_name,language_version,language_interface_type) VALUES (language_seq.nextval,'C#','9','compiled');
INSERT INTO Language(language_id,language_name,language_version,language_interface_type) VALUES (language_seq.nextval,'Pascal','2.32','compiled');
INSERT INTO Language(language_id,language_name,language_version,language_interface_type) VALUES (language_seq.nextval,'Java','8.162','interpreted');
INSERT INTO Language(language_id,language_name,language_version,language_interface_type) VALUES (language_seq.nextval,'Kotlin','1.30','interpreted');

CREATE TABLE Programist_Language 
(
programist_language_id NUMBER not null,
programist_id NUMBER not null,
language_id NUMBER not null,
programist_language_exp number(3) not null
);

CREATE SEQUENCE programist_language_seq
  START WITH 1
  INCREMENT BY 1;

ALTER TABLE Programist_Language ADD CONSTRAINT programist_language_pk PRIMARY KEY (programist_language_id);
ALTER TABLE Programist_Language ADD CONSTRAINT pl_programist_fk FOREIGN KEY (programist_id) REFERENCES Programist(programist_id);
ALTER TABLE Programist_Language ADD CONSTRAINT pl_language_fk FOREIGN KEY (language_id) REFERENCES Language(language_id);
Alter Table Programist_Language ADD CONSTRAINT programist_language_unique UNIQUE (programist_id,language_id);

INSERT INTO Programist_Language(programist_language_id,programist_id,language_id,programist_language_exp)
VALUES 
(programist_language_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='artem' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='usenko'),
(Select LANGUAGE.language_id FROM LANGUAGE WHERE lower(trim(LANGUAGE.LANGUAGE_NAME)) = 'kotlin'),
12);

INSERT INTO Programist_Language(programist_language_id,programist_id,language_id,programist_language_exp)
VALUES 
(programist_language_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='vadim' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='vadim'),
(Select LANGUAGE.language_id FROM LANGUAGE WHERE lower(trim(LANGUAGE.LANGUAGE_NAME)) = 'java'),
12);

INSERT INTO Programist_Language(programist_language_id,programist_id,language_id,programist_language_exp)
VALUES 
(programist_language_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='artem' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='usenko'),
(Select LANGUAGE.language_id FROM LANGUAGE WHERE lower(trim(LANGUAGE.LANGUAGE_NAME)) = 'java'),
2);

INSERT INTO Programist_Language(programist_language_id,programist_id,language_id,programist_language_exp)
VALUES 
(programist_language_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='artur' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='artur'),
(Select LANGUAGE.language_id FROM LANGUAGE WHERE lower(trim(LANGUAGE.LANGUAGE_NAME)) = 'java'),
60);

INSERT INTO Programist_Language(programist_language_id,programist_id,language_id,programist_language_exp)
VALUES 
(programist_language_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='artur' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='artur'),
(Select LANGUAGE.language_id FROM LANGUAGE WHERE lower(trim(LANGUAGE.LANGUAGE_NAME)) = 'c++'),
23);


CREATE TABLE Programist_Job
(
programist_job_id NUMBER not null,
programist_id NUMBER not null,
project_name VARCHAR(30) not null,
project_verison VARCHAR(10) not null
);

CREATE SEQUENCE programist_job_seq
  START WITH 1
  INCREMENT BY 1;

ALTER TABLE Programist_Job ADD CONSTRAINT programist_job_pk PRIMARY KEY (programist_job_id);
ALTER TABLE Programist_Job ADD CONSTRAINT pj_programist_fk FOREIGN KEY (programist_id) REFERENCES Programist(programist_id);
Alter Table Programist_Job ADD CONSTRAINT project_verison_check CHECK (REGEXP_LIKE(project_verison, '^((\d+\.)?(\d+\.)?(\*|\d+))$'));
Alter Table Programist_Job ADD CONSTRAINT project_name_check CHECK (REGEXP_LIKE(project_name, '^[A-Z|a-z]{0,39}$'));
Alter Table Programist_Job ADD CONSTRAINT Programist_Job_unique UNIQUE(programist_id,project_name,project_verison);

INSERT INTO Programist_Job(programist_job_id,programist_id,project_name,project_verison)
VALUES 
(programist_job_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='artem' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='usenko'),
'Tetris',
'2.0.0');

INSERT INTO Programist_Job(programist_job_id,programist_id,project_name,project_verison)
VALUES 
(programist_job_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='vadim' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='vadim'),
'Campus',
'0.0.1');


INSERT INTO Programist_Job(programist_job_id,programist_id,project_name,project_verison)
VALUES 
(programist_job_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='artur' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='artur'),
'Campus',
'0.0.1');


INSERT INTO Programist_Job(programist_job_id,programist_id,project_name,project_verison)
VALUES 
(programist_job_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='vadim' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='vadim'),
'Site',
'0.0.1');


INSERT INTO Programist_Job(programist_job_id,programist_id,project_name,project_verison)
VALUES 
(programist_job_seq.nextval,
(Select PROGRAMIST.programist_id From PROGRAMIST Where lower(trim(PROGRAMIST.programist_first_name)) ='vadim' and lower(trim(PROGRAMIST.PROGRAMIST_LAST_NAME)) ='vadim'),
'Site',
'2.0.1');


/*----------------------------
Нужно еще разбить таблицу Programist_Job на 2 таблицы
-------------*/

  
/* ---------------------------------------------------------------------------
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць,
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT.
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити:

---------------------------------------------------------------------------*/


GRANT CREATE any TABLE to usenko;
GRANT SELECT any TABLE to usenko;
GRANT INSERT any TABLE to usenko;
GRANT ALTER any TABLe to usenko;

/*---------------------------------------------------------------------------
3.a.
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в Адгебрі кодда.
4 бали
---------------------------------------------------------------------------*/

SELECT 
    OrderItems.order_num  
      FROM OrderItems 
          WHERE OrderItems.item_price = 
              (SELECT MAX(OrderItems.item_price ) FROM OrderItems);

PROJECT  (OrderItems.order_num)
  WHERE OrderItems.item_price = MAX(OrderItems.ITEM_PRICE)
 

/*---------------------------------------------------------------------------
3.b.
Визначити скільки унікальних імен продавців - назвавши це поле name.
Виконати завдання в SQL.
4 бали

---------------------------------------------------------------------------*/

SELECT
   COUNT(DISTINCT TRIM(vend_name)) as name
FROM VENDORS;


/*---------------------------------------------------------------------------
c.
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його купляли.
Виконати завдання в алгебрі Кодда.
4 бали

---------------------------------------------------------------------------*/

SELECT
  (LOWER (Vendors.vend_name)) as vendor_name
  FROM Vendors 
  WHERE Vendors.vend_id  IN
  (SELECT 
     DISTINCT Products.vend_id    
    FROM Products
      Where  Products.prod_id IN 
      (
        SELECT 
          DISTINCT OrderItems.prod_id
         FROM OrderItems
      )
  );
  
  
  A = PROJECT (OrderItems) {OrderItem.prod_id};
  B = PROJECT (Products WHERE Products.prod_id IN A) {Products.vend_id};
  ANS = PROJECT (Vendors WHERE Vendors.vend_id IN B) {RENAME ((LOWER (Trim(Vendors.vend_name))), vendor_name)};
  
  

Drop table phoneNumbers;
Drop table Countries_has_operators;
Drop table Countries;
Drop table Operators;
Drop table Students;


create table  Countries(
   country_name        CHAR(30)             not null,
   country_phoneCode   NUMBER(8)            not null
);
alter table  Countries 
   add constraint Country_name_chk check (REGEXP_LIKE(country_name, '[A-Z][a-z]{1,8}[:blank:][a-z]{0,9}[:blank:][a-z]{0,9}'));

alter table  Countries 
   add constraint Country_phoneCode_chk check (REGEXP_LIKE(country_phoneCode, '[0-9]{1,8}'));

alter table  Countries 
   add constraint PK_COUNTRIES primary key (country_name);

/*==============================================================*/
/* Table:  Operators                                            */
/*==============================================================*/
create table  Operators  
(
   Operator_name       CHAR(30)             not null
);

alter table Operators
   add constraint Operator_name_chk check (REGEXP_LIKE(Operator_name, '[A-Z][a-z]{1,8}[:blank:]{0,1}[a-z]{0,9}[:blank:]{0,1}[a-z]{0,9}'));

alter table  Operators 
   add constraint PK_OPERATORS primary key (Operator_name);

/*==============================================================*/
/* Table:  Countries_has_operators                              */
/*==============================================================*/
create table  Countries_has_operators  
(
   Operator_name       CHAR(30)             not null,
   country_name        CHAR(30)             not null,
   operator_country_phoneCode  NUMBER(8)            not null
);

alter table  Countries_has_operators
   add constraint Operator_CHO_name_chk check (REGEXP_LIKE(Operator_name, '[A-Z][a-z]{1,8}[:blank:]{0,1}[a-z]{0,9}[:blank:]{0,1}[a-z]{0,9}'));

alter table  Countries_has_operators
   add constraint country_CHO_name_chk check (REGEXP_LIKE(country_name, '[A-Z][a-z]{1,8}[:blank:][a-z]{0,9}[:blank:][a-z]{0,9}'));

alter table  Countries_has_operators
   add constraint operator_CHO_c_phoneCode_chk check (REGEXP_LIKE(operator_country_phoneCode, '[0-9]{1,8}'));

alter table  Countries_has_operators 
   add constraint  PK_COUNTRIES_HAS_OPERATORS  primary key (Operator_name,  country_name);

alter table  Countries_has_operators 
   add constraint FK_COUNTRIE_COUNTRIES_COUNTRIE foreign key (country_name) REFERENCES Countries  (country_name);

alter table  Countries_has_operators 
   add constraint FK_COUNTRIE_OPERATORS_OPERATOR foreign key (Operator_name) REFERENCES  Operators  (Operator_name);


/*==============================================================*/
/* Table:  Students                                             */
/*==============================================================*/
create table  Students  
(
   student_name        CHAR(50)             not null,
   student_IDCardNumber  CHAR(20)             not null
);

alter table  Students
   add constraint student_name_chk check (REGEXP_LIKE(student_name, '[A-Z][a-z]{1,15}'));
   
alter table  Students
   add constraint student_IDCardNumber_chk check  (REGEXP_LIKE(student_IDCardNumber, '[A-Z]{2}[0-9]{1,8}'));

alter table  Students 
   add constraint PK_STUDENTS primary key (student_name,  student_IDCardNumber);

/*==============================================================*/
/* Table:  phoneNumbers                                         */
/*==============================================================*/
create table  phoneNumbers  
(
   student_name        CHAR(50)             not null,
   student_IDCardNumber  CHAR(20)             not null,
   Operator_name       CHAR(30)             not null,
   country_name        CHAR(30)             not null,
   phoneNumber         NUMBER(20)           not null,
   Dateyear            NUMBER(4)            not null
  );
   
alter table  phoneNumbers 
   add constraint student_PN_name_chk check (REGEXP_LIKE(student_name, '[A-Z][a-z]{1,15}'));

alter table  phoneNumbers 
   add constraint student_IDCardNumber_PN_chk check  (REGEXP_LIKE(student_IDCardNumber, '[A-Z]{2}[0-9]{1,8}'));

alter table  phoneNumbers 
   add constraint Operator_name_PN_chk check (REGEXP_LIKE(Operator_name, '[A-Z][a-z]{1,8}[:blank:]{0,1}[a-z]{0,9}[:blank:]{0,1}[a-z]{0,9}'));

alter table  phoneNumbers 
   add constraint country_name_PN_chk check (REGEXP_LIKE(country_name, '[A-Z][a-z]{1,8}[:blank:][a-z]{0,9}[:blank:][a-z]{0,9}'));

alter table  phoneNumbers 
   add constraint phoneNumber_chk check (REGEXP_LIKE(phoneNumber, '[0-9]{1,20}'));
   
alter table  phoneNumbers 
   add constraint Dateyear_chk check (REGEXP_LIKE(Dateyear, '20[0-1]{1}[0-9]{1}'));

alter table  phoneNumbers 
   add constraint PK_PHONENUMBERS primary key (student_name,  student_IDCardNumber,  Operator_name,  country_name,  phoneNumber);
   
alter table  phoneNumbers 
   add constraint FK_PHONENUM_COUNTRIES_COUNTRIE foreign key (Operator_name,  country_name) REFERENCES  Countries_has_operators  (Operator_name,  country_name);

alter table  phoneNumbers 
   add constraint  FK_PHONENUM_STUDENT_H_STUDENTS  foreign key (student_name, student_IDCardNumber) REFERENCES  Students  (student_name,  student_IDCardNumber);

Insert into Countries
Values ('Benin', '229');
Insert into Countries
Values ('Cuba', '53');
Insert into Countries
Values ('Libya', '21');
Insert into Countries
Values ('Tonga', '676');


Insert into Operators
Values ('Mts ');
Insert into Operators
Values ('Life ');
Insert into Operators
Values ('Oper ');


Insert into Countries_has_operators
Values ('Mts ', 'Tonga', '150');
Insert into Countries_has_operators
Values ('Life ', 'Libya', '188');
Insert into Countries_has_operators
Values ('Mts ', 'Cuba', '605');
Insert into Countries_has_operators
Values ('Mts ', 'Benin', '603');
Insert into Countries_has_operators
Values ('Oper ', 'Cuba', '107');
Insert into Countries_has_operators
Values ('Mts ', 'Libya', '151');


Insert into Students
Values ('Vlad', 'NN09');
Insert into Students
Values ('Max', 'ND09');
Insert into Students
Values ('Lely', 'MN77');
Insert into Students
Values ('Mark', 'JT08');
Insert into Students
Values ('Alex', 'LD11');


Insert into phoneNumbers
Values ('Mark', 'JT08', 'Mts ', 'Cuba', '8888', '2006');
Insert into phoneNumbers
Values ('Mark', 'JT08', 'Oper ', 'Cuba', '8234', '2007');
Insert into phoneNumbers
Values ('Mark', 'JT08', 'Oper ', 'Cuba', '8234', '2018');
Insert into phoneNumbers
Values ('Max', 'ND09', 'Life ', 'Libya', '9119', '2015');
Insert into phoneNumbers
Values ('Max', 'ND09', 'Life ', 'Libya', '1109', '2002');
Insert into phoneNumbers
Values ('Max', 'ND09', 'Mts ', 'Libya', '7224', '2003');
Insert into phoneNumbers
Values ('Lely', 'MN77', 'Mts ', 'Tonga', '2221', '2009');
Insert into phoneNumbers
Values ('Vlad', 'NN09', 'Mts ', 'Benin', '2001', '2008');
Insert into phoneNumbers
Values ('Vlad', 'NN09', 'Life ', 'Libya', '3941', '2006');
Insert into phoneNumbers
Values ('Alex', 'LD11', 'Life ', 'Libya', '3910', '2006');
Insert into phoneNumbers
Values ('Alex', 'LD11', 'Oper ', 'Cuba', '7718', '2010');

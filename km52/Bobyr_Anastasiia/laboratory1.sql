-- LABORATORY WORK 1
-- BY Bobyr_Anastasiia

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

Create user Bobyr IDENTIFIED by Bobyr
Default tablespace "USERS"
TEMPORARY tablespace "TEMP"
Quota unlimited on Users;

grant CONNECT to Bobyr;

grant delete any table to Bobyr;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина має лікарняну картку, що містить записи про історію хвороби.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:



grant create any table to Bobyr;
grant alter any table to Bobyr;

/*==============================================================*/
/* Table: Human                                                 */
/*==============================================================*/
create table Human 
(
   human_id             NUMBER(10)           not null,
   human_name           VARCHAR2(20)         not null,
   human_surname        VARCHAR2(20)         not null,
   human_tel_number     CHAR(15)             not null,
   constraint PK_HUMAN primary key (human_id)
);


ALTER TABLE Human
  ADD CONSTRAINT human_tel_number_unique UNIQUE (human_tel_number);
ALTER TABLE Human
ADD CONSTRAINT check_human_id
  CHECK (human_id > 0);  
ALTER TABLE Human
ADD CONSTRAINT check_human_name
  CHECK (REGEXP_LIKE(human_name,'[A-Z][a-z]{1,50}')); 
ALTER TABLE Human
ADD CONSTRAINT check_human_surname
  CHECK (REGEXP_LIKE(human_surname,'[A-Z][a-z]{1,50}')); 
ALTER TABLE Human
ADD CONSTRAINT check_human_tel_number
  CHECK (REGEXP_LIKE(human_tel_number,'[+][380][0-9]{11}'));  
  


/*==============================================================*/
/* Table: Job                                                   */
/*==============================================================*/
create table Job 
(
   job_name           VARCHAR2(100)         not null,
   constraint PK_JOB primary key (job_name)
);

ALTER TABLE Job
ADD CONSTRAINT check_job_name
  CHECK (REGEXP_LIKE(job_name,'[A-Z][a-z]{1,50}')); 



/*==============================================================*/
/* Table: "Human has job"                                */
/*==============================================================*/
create table HumanJob 
(
   human_id             NUMBER(10)           not null,
   job_name           VARCHAR2(100)         not null,
   "date"               DATE                 not null,
   constraint "PK_human_job" primary key (human_id, job_name, "date")
);


ALTER TABLE HumanJob
ADD CONSTRAINT check_hj_job_name
  CHECK (REGEXP_LIKE(job_name,'[A-Z][a-z]{1,50}')); 
  ALTER TABLE HumanJob
ADD CONSTRAINT check_hj_human_id
  CHECK (human_id > 0); 
  
  
/*==============================================================*/
/* Table: MedicalCard                                           */
/*==============================================================*/
create table MedicalCard 
(
   card_id              NUMBER(15)           not null,
   human_id             NUMBER(10),
   constraint PK_MEDICALCARD primary key (card_id)
);

ALTER TABLE MedicalCard
ADD CONSTRAINT check_human_id_mc
  CHECK (human_id > 0);  
ALTER TABLE MedicalCard
ADD CONSTRAINT check_card_id
  CHECK (card_id > 0);


create table DoctorPatient 
(
   human_id_doc             NUMBER(10)           not null,
   human_id_pt             NUMBER(10)           not null,
   card_id              NUMBER(15)           not null,
   "date"               DATE                 not null,
   constraint PK_Doctor_patient primary key (human_id_doc, human_id_pt, "date")
);


ALTER TABLE DoctorPatient
ADD CONSTRAINT check_human_id_doc
  CHECK (human_id_doc > 0);  
  ALTER TABLE DoctorPatient
ADD CONSTRAINT check_human_id_pt
  CHECK (human_id_pt > 0);  
ALTER TABLE DoctorPatient
ADD CONSTRAINT check_card_id_docpt
  CHECK (card_id > 0);


/*==============================================================*/
/* Table: Illness                                               */
/*==============================================================*/
create table Illness 
(
   illness_name         VARCHAR2(50)         not null,
   illness_recovery_days NUMBER(10),
   percentage_of_mortality NUMBER(3),
   constraint PK_ILLNESS primary key (illness_name)
);


ALTER TABLE Illness 
ADD CONSTRAINT check_illness_name
  CHECK (REGEXP_LIKE(illness_name,'(\s?\w+)+')); 
ALTER TABLE Illness 
ADD CONSTRAINT check_illness_recovery_days
  CHECK (illness_recovery_days > 0);
ALTER TABLE Illness 
ADD CONSTRAINT check_percentage_of_mortality
  CHECK (length(percentage_of_mortality) <= 100);   


/*==============================================================*/
/* Table: Symptoms                                              */
/*==============================================================*/
create table Symptoms 
(
   symptom_name         VARCHAR2(100)        not null,
   constraint PK_SYMPTOMS primary key (symptom_name)
);

ALTER TABLE Symptoms 
ADD CONSTRAINT check_symptom_name
  CHECK (REGEXP_LIKE(symptom_name,'(\s?\w+)+')); 
  

/*==============================================================*/
/* Table: Illness_symptoms                               */
/*==============================================================*/
create table IllnessSymptoms 
(
   ill_sympt_id         NUMBER(10)           not null,
   illness_name         VARCHAR2(50)         not null,
   symptom_name         VARCHAR2(100)        not null,
   "date"               DATE                 not null,
   constraint "PK_ILLNESs_SYMPTOMS" primary key (ill_sympt_id)
);

ALTER TABLE IllnessSymptoms
  ADD CONSTRAINT ill_sympt_unique UNIQUE (illness_name, symptom_name);
ALTER TABLE IllnessSymptoms
ADD CONSTRAINT check_ill_name_illnesssympt
  CHECK (REGEXP_LIKE(illness_name,'(\s?\w+)+')); 
ALTER TABLE IllnessSymptoms 
ADD CONSTRAINT check_sympt_name_illnesssympt
  CHECK (REGEXP_LIKE(symptom_name,'(\s?\w+)+')); 
ALTER TABLE IllnessSymptoms 
ADD CONSTRAINT check_date_illnesssympt
  CHECK ("date" > date '2018-01-01');
  



/*==============================================================*/
/* Table: Records                                               */
/*==============================================================*/
create table Recordss 
(
   record_id            NUMBER(20)          not null,
   card_id              NUMBER(15)           not null,
   ill_sympt_id         NUMBER(10)           not null,
   record_date          DATE                 not null,
   constraint PK_RECORDS primary key (card_id, record_id)
);


ALTER TABLE Recordss 
ADD CONSTRAINT check_record_id
  CHECK (record_id > 0);
ALTER TABLE Recordss
ADD CONSTRAINT check_card_id_record
  CHECK (record_id > 0);
ALTER TABLE Recordss 
ADD CONSTRAINT check_ill_sympt_id_record
  CHECK (ill_sympt_id > 0);  
ALTER TABLE Recordss 
ADD CONSTRAINT check_record_date
  CHECK (record_date > date '2018-01-01');






/*======GENERATION OF FOREIGN KEYS (NOT MANUALLY)=======*/
alter table IllnessSymptoms
   add constraint FK_ILLNESS_SYMPT foreign key (illness_name)
      references Illness (illness_name);

alter table IllnessSymptoms
   add constraint FK_SYMPT_ILLNESS foreign key (symptom_name)
      references Symptoms (symptom_name);
      
      
alter table Recordss
   add constraint FK_RECORD_HAS_ILLNESS foreign key (ill_sympt_id)
      references IllnessSymptoms (ill_sympt_id);

alter table Recordss
   add constraint FK_MED_CARD_HAS_REC foreign key (card_id)
      references MedicalCard (card_id);

alter table MedicalCard
   add constraint FK_HUMAN_HAS_MED_CARD foreign key (human_id)
      references Human (human_id);

alter table HumanJob
   add constraint FK_Job_humjob foreign key (job_name)
      references Job (job_name);
      
alter table HumanJob
   add constraint FK_Human_humjob foreign key (human_id)
      references Human (human_id);
      
alter table DoctorPatient
   add constraint FK_DP_id_doc foreign key (human_id_doc)
      references Human (human_id);

ALTER TABLE MedicalCard
  ADD CONSTRAINT human_id_mc_unique UNIQUE (human_id);
  
alter table DoctorPatient
   add constraint FK_DP_id_pt foreign key (human_id_pt)
      references MedicalCard (human_id);      
      
alter table DoctorPatient
   add constraint FK_DP_id_mc foreign key (card_id)
      references MedicalCard (card_id);       

ALTER TABLE DoctorPatient
ADD CONSTRAINT check_if_doctor
  CHECK (human_id_doc in (select HumanJob.human_id from HumanJob where HumanJob.job_name = "Doctor"));

/*======INSERTS=======*/
--Create patients
INSERT INTO Human (human_id, human_name, human_surname, human_tel_number)
VALUES ('1', 'Ivan', 'Ivanov', '+380999999999');
INSERT INTO Human (human_id, human_name, human_surname, human_tel_number)
VALUES ('2', 'Eugene', 'Plarn', '+380999999998');  
INSERT INTO Human (human_id, human_name, human_surname, human_tel_number)
VALUES ('100', 'Lina', 'Derja', '+380631234567');
INSERT INTO Human (human_id, human_name, human_surname, human_tel_number)
VALUES ('4', 'Mariia', 'Petrova', '+380631234467');
INSERT INTO Human (human_id, human_name, human_surname, human_tel_number)
VALUES ('5', 'Sergij', 'Vadoo', '+380631234599');

insert into job values ('Lawyer');
insert into job values ('Farmer');
insert into job values ('Programmer in Oriflame');
insert into job values ('Doctor');

insert into HumanJob(human_id, job_name, "date") 
values ('1', 'Lawyer', TO_DATE('2018-03-07', 'YYYY-MM-DD'));
insert into HumanJob(human_id, job_name, "date") 
values ('2', 'Farmer', TO_DATE('2018-03-15', 'YYYY-MM-DD'));
insert into HumanJob(human_id, job_name, "date") 
values ('100', 'Programmer in Oriflame', TO_DATE('2018-02-25', 'YYYY-MM-DD'));
insert into HumanJob(human_id, job_name, "date") 
values ('4', 'Doctor', TO_DATE('2018-01-15', 'YYYY-MM-DD'));
insert into HumanJob(human_id, job_name, "date") 
values ('5', 'Doctor', TO_DATE('2018-03-05', 'YYYY-MM-DD'));


--Create cards of the existing patients
INSERT INTO MedicalCard (card_id, human_id)
VALUES ('1001', '2');
INSERT INTO MedicalCard (card_id, human_id)
VALUES ('1002', '1'); 
INSERT INTO MedicalCard (card_id, human_id)
VALUES ('1003', '100');  

INSERT INTO DoctorPatient (human_id_pt, human_id_doc, card_id, "date")
VALUES ('1', '4', '1002', TO_DATE('2018-06-01', 'YYYY-MM-DD'));
INSERT INTO DoctorPatient (human_id_pt, human_id_doc, card_id, "date")
VALUES ('2', '5', '1001', TO_DATE('2018-06-02', 'YYYY-MM-DD'));
INSERT INTO DoctorPatient (human_id_pt, human_id_doc, card_id, "date")
VALUES ('100', '4', '1003', TO_DATE('2018-06-03', 'YYYY-MM-DD'));

--Create illnesses
INSERT INTO Illness (illness_name, illness_recovery_days, percentage_of_mortality)
VALUES ('allergy to fruit', '10', '5');
INSERT INTO Illness (illness_name, illness_recovery_days, percentage_of_mortality)
VALUES ('food poisoning', '7', '4');
INSERT INTO Illness (illness_name, illness_recovery_days, percentage_of_mortality)
VALUES ('cold', '14', '2');

--Create symptoms for existing illnesses
INSERT INTO Symptoms (symptom_name)
VALUES ('redness');
INSERT INTO Symptoms (symptom_name)
VALUES ('sneezing');
INSERT INTO Symptoms (symptom_name)
VALUES ('weakness');
INSERT INTO Symptoms (symptom_name)
VALUES ('vomit');

--Assosiate symptoms with illnesses
INSERT INTO IllnessSymptoms (ill_sympt_id, illness_name, symptom_name, "date")
VALUES ('001', 'allergy to fruit', 'redness', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO IllnessSymptoms (ill_sympt_id, illness_name, symptom_name, "date")
VALUES ('002', 'allergy to fruit', 'sneezing', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO IllnessSymptoms (ill_sympt_id, illness_name, symptom_name, "date")
VALUES ('003', 'food poisoning', 'weakness', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO IllnessSymptoms (ill_sympt_id, illness_name, symptom_name, "date")
VALUES ('004', 'food poisoning', 'vomit', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO IllnessSymptoms (ill_sympt_id, illness_name, symptom_name, "date")
VALUES ('005', 'cold', 'sneezing', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO IllnessSymptoms (ill_sympt_id, illness_name, symptom_name, "date")
VALUES ('006', 'cold', 'weakness', TO_DATE('2018-01-05', 'YYYY-MM-DD'));

--Add records of patients' illnesses
INSERT INTO Recordss (record_id, card_id, ill_sympt_id, record_date)
VALUES ('1', '1001', '002', TO_DATE('2018-01-13', 'YYYY-MM-DD'));
INSERT INTO Recordss (record_id, card_id, ill_sympt_id, record_date)
VALUES ('2', '1001', '004', TO_DATE('2018-03-18', 'YYYY-MM-DD'));
INSERT INTO Recordss (record_id, card_id, ill_sympt_id, record_date)
VALUES ('1', '1002', '006', TO_DATE('2018-02-27', ‘YYYY-MM-DD'));
INSERT INTO Recordss (record_id, card_id, ill_sympt_id, record_date) 
VALUES ('2', '1002', '005', TO_DATE('2018-06-08', 'YYYY-MM-DD'))





  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


grant create any table to Bobyr;
grant insert any table to Bobyr;
grant select any table to Bobyr;




/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:



PROJECT (vendors WHERE vendors.vend_id IN (
PROJECT (products WHERE products.prod_id IN (
PROJECT (orderitems WHERE orderitems.item_price IN (
PROJECT (orderitems) 
{max(orderitems.item_price)})
) {orderitems.prod_id})
) {products.vend_id})
) {vendors.vend_name}









/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найдовшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:



select customers.cust_name as "long_name"
from customers 
where len(trim(customers.cust_name)) in
(select max(len(trim(customers.cust_name)))
from customers);









/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
select distinct lower(vend_name) as "vendor_name"
    from VENDORS, PRODUCTS, ORDERITEMS
    where vendors.VEND_ID = products.VEND_ID and PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID ;
    
   

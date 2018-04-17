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
   human_job            VARCHAR2(50),
   human_tel_number     CHAR(15)             not null,
   constraint PK_HUMAN primary key (human_id)
);

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

/*==============================================================*/
/* Table: "Illness has symptoms"                                */
/*==============================================================*/
create table "Illness has symptoms" 
(
   illness_name         VARCHAR2(50)         not null,
   symptom_name         VARCHAR2(100)        not null,
   "date"               DATE                 not null,
   constraint "PK_ILLNESS HAS SYMPTOMS" primary key (illness_name, symptom_name)
);

/*==============================================================*/
/* Index: "Illness has symptoms2_FK"                            */
/*==============================================================*/
create index "Illness has symptoms2_FK" on "Illness has symptoms" (
   symptom_name ASC
);

/*==============================================================*/
/* Index: "Illness has symptoms_FK"                             */
/*==============================================================*/
create index "Illness has symptoms_FK" on "Illness has symptoms" (
   illness_name ASC
);

/*==============================================================*/
/* Table: MedicalCard                                           */
/*==============================================================*/
create table MedicalCard 
(
   card_id              NUMBER(15)           not null,
   human_id             NUMBER(10),
   constraint PK_MEDICALCARD primary key (card_id)
);

/*==============================================================*/
/* Index: "Human has a medical card_FK"                         */
/*==============================================================*/
create index "Human has a medical card_FK" on MedicalCard (
   human_id ASC
);

/*==============================================================*/
/* Table: Records                                               */
/*==============================================================*/
create table Records 
(
   record_id            NUMBER(20)          not null,
   card_id              NUMBER(15)           not null,
   illness_name         VARCHAR2(50)         not null,
   record_date          DATE                 not null,
   constraint PK_RECORDS primary key (card_id, record_id)
);

/*==============================================================*/
/* Index: "Card has records2_FK"                                */
/*==============================================================*/
create index "Card has records2_FK" on Records (
   card_id ASC
);

/*==============================================================*/
/* Index: "Card has records_FK"                                 */
/*==============================================================*/
create index "Card has records_FK" on Records (
   illness_name ASC
);

/*==============================================================*/
/* Table: Symptoms                                              */
/*==============================================================*/
create table Symptoms 
(
   symptom_name         VARCHAR2(100)        not null,
   constraint PK_SYMPTOMS primary key (symptom_name)
);



/*======ADDED MANUALLY=======*/
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
ADD CONSTRAINT check_human_job
  CHECK (REGEXP_LIKE(human_job,'(\s?\w+)+'));   
ALTER TABLE Human
ADD CONSTRAINT check_human_tel_number
  CHECK (REGEXP_LIKE(human_tel_number,'[+][380][0-9]{11}'));   

ALTER TABLE MedicalCard
ADD CONSTRAINT check_human_id_mc
  CHECK (human_id > 0);  
ALTER TABLE MedicalCard
ADD CONSTRAINT check_card_id
  CHECK (card_id > 0);

ALTER TABLE Records 
ADD CONSTRAINT check_record_id
  CHECK (record_id > 0);
ALTER TABLE Records 
ADD CONSTRAINT check_card_id_record
  CHECK (record_id > 0);
ALTER TABLE Records 
ADD CONSTRAINT check_illness_name_record
  CHECK (REGEXP_LIKE(illness_name,'(\s?\w+)+'));  
ALTER TABLE Records 
ADD CONSTRAINT check_record_date
  CHECK (record_date > date '2018-01-01');

ALTER TABLE Illness 
ADD CONSTRAINT check_illness_name
  CHECK (REGEXP_LIKE(illness_name,'(\s?\w+)+')); 
ALTER TABLE Illness 
ADD CONSTRAINT check_illness_recovery_days
  CHECK (illness_recovery_days > 0);
ALTER TABLE Illness 
ADD CONSTRAINT check_percentage_of_mortality
  CHECK (length(percentage_of_mortality) <= 100);   

ALTER TABLE "Illness has symptoms"  
ADD CONSTRAINT check_illness_name_illnesssympt
  CHECK (REGEXP_LIKE(illness_name,'(\s?\w+)+')); 
ALTER TABLE "Illness has symptoms"  
ADD CONSTRAINT check_symptom_name_illnesssympt
  CHECK (REGEXP_LIKE(symptom_name,'(\s?\w+)+')); 
ALTER TABLE "Illness has symptoms"  
ADD CONSTRAINT check_date_illnesssympt
  CHECK ("date" > date '2018-01-01');

ALTER TABLE Symptoms 
ADD CONSTRAINT check_symptom_name
  CHECK (REGEXP_LIKE(symptom_name,'(\s?\w+)+')); 



/*======GENERATION OF FOREIGN KEYS (NOT MANUALLY)=======*/
alter table "Illness has symptoms"
   add constraint FK_ILLNESS_HAS_SYMPT foreign key (illness_name)
      references Illness (illness_name);

alter table "Illness has symptoms"
   add constraint FK_SYMPT_HAS_ILLNESS foreign key (symptom_name)
      references Symptoms (symptom_name);

alter table MedicalCard
   add constraint FK_HUMAN_HAS_MED_CARD foreign key (human_id)
      references Human (human_id);

alter table Records
   add constraint FK_RECORD_HAS_ILLNESS foreign key (illness_name)
      references Illness (illness_name);

alter table Records
   add constraint FK_MED_CARD_HAS_REC foreign key (card_id)
      references MedicalCard (card_id);
      



/*======INSERTS=======*/
--Create patients
INSERT INTO Human (human_id, human_name, human_surname, human_job, human_tel_number)
VALUES ('1', 'Ivan', 'Ivanov', 'Lawyer', '+380999999999');
INSERT INTO Human (human_id, human_name, human_surname, human_job, human_tel_number)
VALUES ('2', 'Eugene', 'Plarn', 'farmer', '+380999999998');  
INSERT INTO Human (human_id, human_name, human_surname, human_job, human_tel_number)
VALUES ('100', 'Lina', 'Derja', 'Programmer in Oriflame', '+380631234567');

--Create cards of the existing patients
INSERT INTO MedicalCard (card_id, human_id)
VALUES ('1001', '2');
INSERT INTO MedicalCard (card_id, human_id)
VALUES ('1002', '1'); 
INSERT INTO MedicalCard (card_id, human_id)
VALUES ('1003', '100');  

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
INSERT INTO "Illness has symptoms" (illness_name, symptom_name, "date")
VALUES ('allergy to fruit', 'redness', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO "Illness has symptoms" (illness_name, symptom_name, "date")
VALUES ('allergy to fruit', 'sneezing', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO "Illness has symptoms" (illness_name, symptom_name, "date")
VALUES ('food poisoning', 'weakness', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO "Illness has symptoms" (illness_name, symptom_name, "date")
VALUES ('food poisoning', 'vomit', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO "Illness has symptoms" (illness_name, symptom_name, "date")
VALUES ('cold', 'sneezing', TO_DATE('2018-01-05', 'YYYY-MM-DD'));
INSERT INTO "Illness has symptoms" (illness_name, symptom_name, "date")
VALUES ('cold', 'weakness', TO_DATE('2018-01-05', 'YYYY-MM-DD'));

--Add records of patients' illnesses
INSERT INTO Records (record_id, card_id, illness_name, record_date)
VALUES ('1', '1001', 'allergy to fruit', TO_DATE('2018-01-13', 'YYYY-MM-DD'));
INSERT INTO Records (record_id, card_id, illness_name, record_date)
VALUES ('2', '1001', 'food poisoning', TO_DATE('2018-03-18', 'YYYY-MM-DD'));
INSERT INTO Records (record_id, card_id, illness_name, record_date)
VALUES ('1', '1002', 'cold', TO_DATE('2018-02-27', 'YYYY-MM-DD'));





  
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
    
   

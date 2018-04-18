-- LABORATORY WORK 1
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER lukianchenko IDENTIFIED BY LUK
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER lukianchenko QUOTA 200M ON USERS;



GRANT "CONNECT" TO lukianchenko;
GRANT SELECT ANY TABLE TO lukianchenko;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
/*==============================================================*/
/* Table: CPU                                                   */
/*==============================================================*/
create table CPU 
(
   cpu_code             VARCHAR2(20)         not null,
   cpu_company          VARCHAR2(15)         not null,
   cpu_seria            VARCHAR2(15)         not null,
   cpu_model            VARCHAR2(15)         not null,
   constraint PK_CPU primary key (cpu_code)
);

alter table CPU
	add constraint cpu_code_check check(regexp_like(cpu_code, '^[A-Z]{2}[0-9]{4}[A-Z0-9]{1,9}$')); 
alter table CPU
	add constraint cpu_company_check check(regexp_like(cpu_company, '^[a-zA-z &.]{1,15}$')); 
alter table CPU
	add constraint cpu_seria_check check(regexp_like(cpu_seria, '^[A-Za-z0-9 ]{1,15}$')); 
alter table CPU
	add constraint cpu_model_check check(regexp_like(cpu_model, '^[A-Z0-9]{1,15}$')); 

/*==============================================================*/
/* Table: Computer                                              */
/*==============================================================*/
create table Computer 
(
   computer_code        VARCHAR2(36)         not null,
   computer_mac_adress  VARCHAR2(14)         not null,
   constraint PK_COMPUTER primary key (computer_code)
);

alter table Computer 
	add constraint computer_code_check check(regexp_like(computer_code, '^[A-Z0-9-]{36}$')); 
alter table Computer 
	add constraint computer_mac_adress_check check(regexp_like(computer_mac_adress, '^([A-Z0-9]{2}-){4}([A-Z0-9]{2})$')); 

/*==============================================================*/
/* Table: Hardware                                              */
/*==============================================================*/
create table Hardware 
(
   psu_code             VARCHAR2(20)         not null,
   cpu_code             VARCHAR2(20)         not null,
   constraint PK_HARDWARE primary key (psu_code, cpu_code)
);

alter table Hardware
	add constraint hardware_psu_code_check check(regexp_like(psu_code, '^[A-Z0-9.-]{10,20}$')); 
alter table Hardware
	add constraint hardware_cpu_code_check check(regexp_like(cpu_code, '^[A-Z]{2}[0-9]{4}[A-Z0-9]{1,9}$')); 

/*==============================================================*/
/* Index: hardware_cpu_FK                                       */
/*==============================================================*/
create index hardware_cpu_FK on Hardware (
   cpu_code ASC
);

/*==============================================================*/
/* Index: hardware_psu_FK                                       */
/*==============================================================*/
create index hardware_psu_FK on Hardware (
   psu_code ASC
);

/*==============================================================*/
/* Table: PSU                                                   */
/*==============================================================*/
create table PSU 
(
   psu_code             VARCHAR2(20)         not null,
   psu_company          VARCHAR2(15)         not null,
   psu_model            VARCHAR2(15)         not null,
   psu_power_model      VARCHAR2(6)          not null,
   constraint PK_PSU primary key (psu_code)
);
alter table PSU
	add constraint psu_code_check check(regexp_like(psu_code, '^[A-Z0-9.-]{10,20}$')); 
alter table PSU
	add constraint psu_company_check check(regexp_like(psu_company, '^[a-zA-z &.]{1,15}$')); 
alter table PSU
	add constraint psu_power_model_check check(regexp_like(psu_power_model, '^[0-9]{3,5}[w]$')); 
alter table PSU
	add constraint psu_model_check check(regexp_like(psu_model, '^[A-Z0-9]{1,15}$')); 


/*==============================================================*/
/* Table: Software                                              */
/*==============================================================*/
create table Software 
(
   operation_system     VARCHAR2(15)         not null,
   os_version           VARCHAR2(15)         not null,
   constraint PK_SOFTWARE primary key (operation_system, os_version)
);

alter table Software
	add constraint operation_system_check check(regexp_like(operation_system, '^[A-Z0-9 ]+$')); 
alter table Software
	add constraint os_version_check check(regexp_like(os_version, '^[a-zA-z0-9 ]+$')); 


/*==============================================================*/
/* Table: computer_has_harware                                  */
/*==============================================================*/
create table computer_has_harware 
(
   build_date           DATE                 not null,
   computer_code        VARCHAR2(36)         not null,
   psu_code             VARCHAR2(20)         not null,
   cpu_code             VARCHAR2(20)         not null,
   constraint PK_COMPUTER_HAS_HARDWARE primary key (psu_code, cpu_code, computer_code, build_date)
);

alter table computer_has_harware 
	add constraint ch_build_date_check check(regexp_like(build_date, '^([1-9]|[12][0-9]|[31]|[30]).([A-Z]{3}).[1-2][0-9]{3}$'));
alter table computer_has_harware 
	add constraint ch_computer_code_check check(regexp_like(computer_code, '^[A-Z0-9-]{36}$')); 
alter table computer_has_harware
	add constraint ch_psu_code_check check(regexp_like(psu_code, '^[A-Z0-9.-]{10,20}$')); 
alter table computer_has_harware
	add constraint ch_cpu_code_check check(regexp_like(cpu_code, '^[A-Z]{2}[0-9]{4}[A-Z0-9]{1,9}$')); 


/*==============================================================*/
/* Index: computer_has_hardware_FK                              */
/*==============================================================*/
create index computer_has_hardware_FK on computer_has_harware (
   computer_code ASC
);

/*==============================================================*/
/* Index: computer_hardware_FK                                  */
/*==============================================================*/
create index computer_hardware_FK on computer_has_harware (
   psu_code ASC,
   cpu_code ASC
);

/*==============================================================*/
/* Table: computer_has_software                                 */
/*==============================================================*/
create table computer_has_software 
(
   computer_code        VARCHAR2(36)         not null,
   operation_system     VARCHAR2(15)         not null,
   os_version           VARCHAR2(15)         not null,
   install_date         DATE                 not null,
   unistall_date        DATE,
   constraint PK_COMPUTER_HAS_SOFTWARE primary key (operation_system, os_version, computer_code,install_date)
);

alter table computer_has_software
	add constraint cs_install_date_check check(regexp_like(install_date, '^([1-9]|[12][0-9]|[31]|[30]).([A-Z]{3}).[1-2][0-9]{3}$'));
alter table computer_has_software 
	add constraint cs_unistall_date_check check(regexp_like(unistall_date, '^([1-9]|[12][0-9]|[31]|[30]).([A-Z]{3}).[1-2][0-9]{3}$'));
alter table computer_has_software 
	add constraint cs_computer_code_check check(regexp_like(computer_code, '^[A-Z0-9-]{36}$')); 
alter table computer_has_software 
	add constraint cs_operation_system_check check(regexp_like(operation_system, '^[A-Z0-9 ]+$')); 
alter table computer_has_software 
	add constraint cs_os_version_check check(regexp_like(os_version, '^[a-zA-z0-9 ]+$'));
alter table computer_has_software 
	add constraint os_date_check check(install_date < unistall_date);  

/*==============================================================*/
/* Index: computer_software_FK                                  */
/*==============================================================*/
create index computer_software_FK on computer_has_software (
   computer_code ASC
);

/*==============================================================*/
/* Index: computer_has_software_FK                              */
/*==============================================================*/
create index computer_has_software_FK on computer_has_software (
   operation_system ASC,
   os_version ASC
);

alter table Hardware
   add constraint fk_hardware_cpu foreign key (cpu_code)
      references CPU (cpu_code)
      on delete cascade;

alter table Hardware
   add constraint fk_hardware_psu foreign key (psu_code)
      references PSU (psu_code)
      on delete cascade;

alter table computer_has_harware
   add constraint fk_computer_hardware foreign key (psu_code, cpu_code)
      references Hardware (psu_code, cpu_code)
      on delete cascade;

alter table computer_has_harware
   add constraint fk_computer_has_hardware foreign key (computer_code)
      references Computer (computer_code)
      on delete cascade;

alter table computer_has_software
   add constraint fk_computer_has_software foreign key (computer_code)
      references Computer (computer_code)
      on delete cascade;

alter table computer_has_software
   add constraint fk_computer_software foreign key (operation_system, os_version)
      references Software (operation_system, os_version)
      on delete cascade;

INSERT INTO COMPUTER(computer_code,computer_mac_adress)
VALUES('8468AA71-7916-4FDF-A680-E98378BC65C4', 'CD-6F-DS-43-VC');

INSERT INTO COMPUTER(computer_code,computer_mac_adress)
VALUES('8468AA71-7916-4FDF-A680-EFD4TFGF45C4', 'CD-6F-CX-DS-VC');

INSERT INTO COMPUTER(computer_code,computer_mac_adress)
VALUES('8468AA71-7916-4FDF-A680-E9FER4EFD4F4', 'CN-C5-3J-43-VC');

--------------------------------------------------------------------
INSERT INTO CPU(cpu_code,cpu_company,cpu_seria,cpu_model)
VALUES('DF8976JFD84', 'Intel','Core i5','8400');

INSERT INTO CPU(cpu_code,cpu_company,cpu_seria,cpu_model)
VALUES('BX80677G4620', 'Intel','Pentium Gold','G4620');

INSERT INTO CPU(cpu_code,cpu_company,cpu_seria,cpu_model)
VALUES('YD195XA8AEWOF', 'AMD','Ryzen Threadripper','1950X');

-------------------------------------------------------------------
INSERT INTO PSU(psu_code,psu_company,psu_model,psu_power_model)
VALUES('ACPN-VX75AEY.11', 'Aerocool','VX-750','750W');

INSERT INTO PSU(psu_code,psu_company,psu_model,psu_power_model)
VALUES('ACPN-VX76HUY.11', 'Aerocool','VX-700','700W');

INSERT INTO PSU(psu_code,psu_company,psu_model,psu_power_model)
VALUES('GDP-650C', 'Chieftec','A-90 GDP-650C','650W');

--------------------------------------------------------------------
INSERT INTO SOFTWARE(operation_system, os_version)
VALUES('Windows', '7');

INSERT INTO SOFTWARE(operation_system, os_version)
VALUES('Ubuntu', '17');

INSERT INTO SOFTWARE(operation_system, os_version)
VALUES('macOS', 'High Sierra');

--------------------------------------------------------------------
INSERT INTO HARDWARE(psu_code, cpu_code)
VALUES('ACPN-VX75AEY.11', 'BX80677G4620');

INSERT INTO HARDWARE(psu_code, cpu_code)
VALUES('ACPN-VX75AEY.11', 'YD195XA8AEWOF');

INSERT INTO HARDWARE(psu_code, cpu_code)
VALUES('ACPN-VX76HUY.11', 'DF8976JFD84');

---------------------------------------------------------------------
INSERT INTO COMPUTER_HAS_HARDWARE(build_date,computer_code,psu_code, cpu_code)
VALUES('11.MAY.2017','8468AA71-7916-4FDF-A680-EFD4TFGF45C4', 'ACPN-VX76HUY.11', 'DF8976JFD84');

INSERT INTO COMPUTER_HAS_HARDWARE(build_date,computer_code,psu_code, cpu_code)
VALUES('14.MAY.2017','8468AA71-7916-4FDF-A680-E98378BC65C4','ACPN-VX76HUY.11', 'DF8976JFD84');

INSERT INTO COMPUTER_HAS_HARDWARE(build_date,computer_code, psu_code, cpu_code)
VALUES('11.JAN.2017','8468AA71-7916-4FDF-A680-E9FER4EFD4F4''ACPN-VX75AEY.11', 'YD195XA8AEWOF');

----------------------------------------------------------------------

INSERT INTO COMPUTER_HAS_SOFTWARE(computer_code,operation_system, os_version,install_date, unistall_date)
VALUES('8468AA71-7916-4FDF-A680-EFD4TFGF45C4','Ubuntu', '17', '14.JAN.2017','14.MAY.2017');

INSERT INTO COMPUTER_HAS_SOFTWARE(computer_code,operation_system, os_version,install_date, unistall_date)
VALUES('8468AA71-7916-4FDF-A680-E98378BC65C4','macOS', 'High Sierra', '14.JAN.2017',);

INSERT INTO COMPUTER_HAS_SOFTWARE(computer_code,operation_system, os_version,install_date, unistall_date)
VALUES('8468AA71-7916-4FDF-A680-E9FER4EFD4F4', 'Windows', '7', '14.MAY.2017','23.MAY.2017');


















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO lukianchenko;
GRANT INSERT ANY TABLE TO lukianchenko;
GRANT SELECT ANY TABLE TO lukianchenko;





/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT
    order_num
FROM
    orderitems
WHERE
    item_price = (
        SELECT
            MAX(item_price)
        FROM
            orderitems
    );





/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select count(DISTINCT cust_name) as count_name from customers;













/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

 PROJECT (VENDORS TIMES PRODUCTS 
        WHERE PRODUCTS.PROD_ID NOT IN (PROJECT(ORDERITEMS){ORDERITEMS.PROD_ID}) 
        AND  VENDORS.VEND_ID  = PRODUCTS.VEND_ID
    ){ DISTINCT RENAME(LOWER(TRIM(VENDORS.VEND_NAME)), "VENDOR_NAME")}

-- BY Lukianchenko_Rehina

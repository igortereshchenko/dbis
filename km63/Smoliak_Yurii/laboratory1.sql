-- LABORATORY WORK 1
-- BY Smoliak_Yurii
/*1*/
Create User Smoliak identified by Smoliak
Default TableSpace " Users "
Temporary TableSpace "Temp"
Alter User Smoliak Quota 100M on Users
Grant " Connect " to Smoliak ;
Grant Alter Any Table to Smoliak ;

Grant Insert Any Table to Smoliak ; /*3*/

/*2*/
Create TABLE Book (
Book_name char (30) NOT NULL 
) ;
Alter Table Book 
Add Constrain Book_pk Prymary Key Book_name
Create Table Pages (
Pages_num char (30) NOT NULL
);
Alter Table Pages 
Add Constrain Pages_pk Prymary Key Pages_num
Create Table Book_Pages (
Book_name char (30) NOT NULL 
Pages_num char (30) NOT NULL
Pages_text char (30) NOT NULL
) ;
Alter Table Book_Pages 
ADD Constrain Book_name_fk Foreign key Book_name ;
Alter Table Book_Pages
Add Constrain Pages_num_fk Foreign key Pages_num ;
Alter Table Book_Pages
Add Constrain Book_name Prymary key ;








/*3.a*/
Select (prod_price);
from Products
Order by prod_price DESK
LIMIT 1
/*3.b*/
Select (cust_country);
from Customers



/*3.c*/
Select 
Trim (Cust_Country)
|| ''
||Trim (Cust_Email) as client_name 
From Customers 
WHERE orderitems is NULL


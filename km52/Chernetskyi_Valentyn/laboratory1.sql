/*---------------------------------------------------------------------------
1.�������� ����� ����� � ������ � ������� ��������, � ��� ���������� ����:
�������� ��������� ������� �� �������� ����.
4 ����
---------------------------------------------------------------------------*/
--��� �������:
CREATE USER chernetskyi IDENTIFIED D BY chernetskyi DEFAULT TABLESPACE "USERS" TEMPORARY TABLESPACE "TEMP";
  ALTER USER chernetskyi QUOTA 100M ON USERS;
  GRANT "CONNECT" TO chernetskyi;
  GRANT
CREATE ANY TABLE TO chernetskyi;
  GRANT ALTER ANY TABLE TO chernetskyi;
  GRANT
  SELECT ANY TABLE TO chernetskyi;
  /*---------------------------------------------------------------------------
  2. �������� �������, � ���� ��������� ���� �� ����. ������� �� �������� �����
  ���������� ������ �� ������� �������������� ������� ALTER TABLE.
  ������ ���������� ������.
  4 ����
  ---------------------------------------------------------------------------*/
  --��� �������:
  CREATE TABLE HOTELS
    (
      hotel_name VARCHAR2(30) NOT NULL
    );
  ALTER TABLE HOTELS ADD CONSTRAINT hotel_pk PRIMARY KEY (hotel_name);
  CREATE TABLE CLIENTS
    ( client_name VARCHAR2(30) NOT NULL
    );
  ALTER TABLE CLIENTS ADD CONSTRAINT client_pk PRIMARY KEY (client_name);
  /* ---------------------------------------------------------------------------
  3. ������ �������� ����� ������������ (���������� � ����� � 1) ��� ��������� �������,
  �������� ����� � ������� �� ��������� ������ �������������� ������� ALTER/GRANT.
  ����������� ���� ����� �������������� ��� � ���� OracleScript �� �������� ������:
  ---------------------------------------------------------------------------*/
  --��� �������:
  GRANT INSERT ANY TABLE TO chernetskyi;
  /*---------------------------------------------------------------------------
  3.a.
  �� ����� �������, �� �� ����� ����������� �������.
  �������� �������� � ������ �����.
  4 ����
  ---------------------------------------------------------------------------*/
  --��� �������:
  /*---------------------------------------------------------------------------
  3.b.
  ������� ����� ���������� �� ����� ������ � ������ ����������, �� �� �������� ���� � ������ ����������.
  �������� �������� � SQL.
  4 ����
  ---------------------------------------------------------------------------*/
  --��� �������:
  SELECT Orders.ORDER_NUM,
    Products.PROD_NAME,
    
  FROM Orders, Products
  WHERE MIN(Products.PROD_PRICE)
  /*---------------------------------------------------------------------------
  c.
  ������� ����� �� ����� �������, �� ����� ���� client_name � �������� ������, ��� ��� ��������, �� ������� �������� � ������������� � ������ "James".
  �������� �������� � SQL.
  4 ����
  ---------------------------------------------------------------------------*/
  --��� �������:
  
  SELECT 
  TRIM  (cust_country)
    || ', '
    || TRIM  (cust_email) AS "client_name"
  FROM Customers, Vendors
  WHERE VENDORS.VEND_NAME='James';

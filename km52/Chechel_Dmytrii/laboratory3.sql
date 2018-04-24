/*1. �������� PL/SQL ���, �� ���� ���������� ������� � ������ 1000000001, ��� ������� ������� ���� ��������� ���� 4. 
����� ����� ���������  - ord1�.ordn. ���� ��� ��������� ������� ��� ���������� � ������� 20005.
10 ����*/

DECLARE
    ord_count NUMBER(1);
    ord_date orders.order_date%TYPE;
    ins_ord_count NUMBER(1);
    customer_id customers.cust_id%TYPE := 1000000001;
BEGIN
    select count(*) into ord_count from orders where cust_id = customer_id;
    select order_date into ord_date from orders where cust_id = 20005;
    ins_ord_count := 4 - ord_count; 
    IF ord_count < 4 THEN
        FOR ord_id IN 1..ins_ord_count LOOP
            INSERT INTO orders VALUES(ord_id, ord_date, customer_id);
        END LOOP;    
    END IF;
END;

/*2. �������� PL/SQL ���, �� �� ��������� ����� ������������� �������� � ������� ���� ��'� �� �������  ���� ������.
���� �� ������ ����� 10 �������� - ������  = "yes"
���� �� ������ ����� 10 �������� - ������  = "no"
���� �� �� �������� ������� �������� - ������  = "unknown*/

DECLARE
    ord_count NUMBER(1);
    vendor_id vendors.vend_id%TYPE := 1000000001;
    vendor_name vendors.vend_name%TYPE;
    vandor_status CHAR(10);
BEGIN
    select count(*)
    into ord_count
    from ordersitems o 
    inner join products p 
    on o.prod_id = p.prod_id
    where p.vend_id = vendor_id;
    select vend_name into vendor_name from vendors where vendors.vend_id = vendor_id;
    
    vendor_status :=
    CASE  
        WHEN ord_count > 10 THEN
            "yes"
        WHEN ord_count < 10 and ord_count > 0 THEN
            "no"
        WHEN ord_count = 0 THEN
            "unknown"
    END;
    DBMS_OUTPUT.PUT_LINE(vendor_name||vendor_status);
END;


/*3. �������� ������������� �� ����������� ���� � ���� �������:
3.1. ������� ������ ���������� �� ������� �������������, �� ��������� ��� ������ � ����� � ���������.
3.2. ������� ��'� ������������� �� ������� ���� ��������.
6 ����.*/

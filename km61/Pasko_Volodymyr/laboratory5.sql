-- LABORATORY WORK 5
-- BY Pasko_Volodymyr
SET SERVEROUTPUT ON;

--1

CREATE OR REPLACE FUNCTION return_receive (
    int IN v_order_date
) RETURN INT AS
    int   orders_amount;
BEGIN
    SELECT
        COUNT(order_num)
    INTO
        param_date
    FROM
        orders
    WHERE
        orders.order_date = v_order_date;

    RETURN orders_amount;
END return_receive;


--2

CREATE OR REPLACE PROCEDURE rename_customer (
    int IN param_cust_id
) AS
    declare   customers.cust_id%TYPE v_cust_id;
BEGIN
    SELECT
        cust_id
    INTO
        v_cust_id
    FROM
        customers
    WHERE
        customers.cust_id = param_cust_id
        AND   customers.cust_id = orders.cust_id;

    IF
        v_cust_id != NULL
    THEN
        dbms_output.put_line('change name');
    ELSE
        RAISE exception;
    END IF;

END rename_customer;

--3 

CREATE or replace PROCEDURE delete_product (
    int IN param_prod_id
) AS
    declare products.prod_id%TYPE v_prod_id;
begin 
    SELECT
        prod_id
    INTO
        v_prod_id
     FROM
        products
    where products.prod_id = param_prod_id;
    if v_prod_id = Null then
        raise Exception;
    end if;
    

end delete_product;





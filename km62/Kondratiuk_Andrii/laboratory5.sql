-- LABORATORY WORK 5
-- BY Kondratiuk_Andrii

-- 1
CREATE OR REPLACE FUNCTION get_order_count (
    param_order_date orders.order_date%TYPE
) RETURN INT IS
    v_required_order_count   orderitems.order_num%TYPE;
BEGIN
    SELECT
        COUNT(orderitems.order_num)
    INTO
        v_required_order_count
    FROM
        orderitems
        JOIN orders ON orderitems.order_num = orders.order_num
    WHERE
        orders.order_date = param_order_date;

    return(v_required_order_count);
END get_order_count;

--3
CREATE OR REPLACE PROCEDURE delete_useless_products (
    param_prod_name   IN products.prod_name%TYPE
) IS
    v_exist_product INT := 0;
    v_current_product_sales INT := 0;
BEGIN SELECT
    COUNT(products.prod_id)
INTO
    v_exist_product
     FROM
    products
     WHERE
    products.prod_name = param_prod_name; if(v_exist_product = 0) THEN RAISE product_doesnt_exist;
    ELSE
        BEGIN
            SELECT
                COUNT(products.prod_id)
            INTO
                v_current_product_sales
            FROM
                products
                JOIN orderitems ON products.prod_id = orderitems.prod_id
            WHERE
                products.prod_name = param_prod_name;

        END;
if(v_current_product_sales = 0) THEN DELETE row products
WHERE
    products.prod_name = param_prod_name; 
    EXCEPTION WHEN(product_doesnt_exist) THEN dbms_output.put_line('product already sold');
END delete_useless_products;

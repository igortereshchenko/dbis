-- LABORATORY WORK 5
-- BY Adamovskyi_Anatolii
----1 
CREATE OR REPLACE FUNCTION order_sum (
    order_number orderitems.order_num%TYPE
) RETURN NUMBER AS
    my_order_sum  NUMBER;
BEGIN
    SELECT
        SUM(orderitems.item_price * orderitems.quantity) order_sum
    INTO
        my_order_sum
    FROM
        orderitems
    WHERE
        orderitems.order_num = order_number;
    return my_order_sum;
END order_sum;

-- 2
CREATE OR REPLACE PROCEDURE get_key_use_desc (
    product_des   products.prod_des%TYPE,
    product_id    OUT products.prod_id%TYPE
)
    IS
BEGIN
    SELECT
        prod_id
    INTO
        product_id
    FROM
        products
    WHERE
        prod_desc = product_des;

EXCEPTION
    WHEN not_data_found THEN
        RAISE exception;
END get_key_use_desc;


--3
CREATE OR REPLACE PROCEDURE update_quantity (
    order_number   orderitems.order_num%TYPE,
    product_id     products.prod_id,
    new_quanty     orderitems.quantyty%TYPE
) IS 
begin 
    UPDATE orderitems set quantyty = new_quanty
    WHERE
        order_num = order_number
        AND   prod_id = product_id; 
    EXCEPTION
    WHEN not_data_found
        then
            RAISE exception;
    end update_quantity;


-- LABORATORY WORK 4
-- BY Milevska_Olha

1)
CREATE OR REPLACE TRIGGER on_customer_insert
AFTER 
INSERT
ON customers
FOR EACH ROW
DECLARE
    max_id INT;
BEGIN
    SELECT MAX(orders.order_num) INTO max_id FROM orders;
    INSERT INTO orders VALUES(max_id + 1, CURRENT_TIMESTAMP, :new.cust_id);
END;



2)
CREATE OR REPLACE TRIGGER on_price_change
AFTER
UPDATE
OF prod_price
ON products
FOR EACH ROW
BEGIN
    DELETE FROM products WHERE products.prod_id = :old.prod_id;
END;

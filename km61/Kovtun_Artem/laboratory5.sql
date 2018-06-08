-- LABORATORY WORK 5
-- BY Kovtun_Artem

(1) Написати функцію, що повертає кількість замовлень, що містить тільки один продукт у будь-якій кількості, 
    за ключем покупця, що є параметром функції.
    
    
CREATE OR REPLACE FUNCTION order_quantity(customer_key CUSTOMERS.CUST_ID%TYPE) 
RETURN INT 
AS
    quantity int;
BEGIN
    SELECT COUNT(order_num) into quantity FROM (
        SELECT orders.order_num, COUNT(orderitems.prod_id) AS quantity FROM 
            customers JOIN orders ON customers.cust_id = orders.cust_id
                              JOIN orderitems ON orders.order_num = orderitems.order_num WHERE customers.cust_id = customer_key
            GROUP BY orders.order_num) WHERE quantity = 1; 
        RETURN quantity;
END order_quantity;



(2) Написати процедуру, що за назвою існуючого продукту повертає кількість покупців, що його купляли,
    якщо операція не можлива процедура кидає exception.
    

CREATE OR REPLACE PROCEDURE count_customers(product_name IN PRODUCTS.PROD_ID%TYPE, customers_quantity OUT INT) 
IS
    products_quantity INT;
    invalid_product_exception EXCEPTION;
BEGIN
    SELECT COUNT(prod_id) INTO products_quantity FROM products WHERE prod_name = product_name; 
    
    IF (products_quantity = 0) THEN 
        raise invalid_product_exception;
    END IF;
    
    SELECT COUNT(DISTINCT customers.cust_id) into customers_quantity FROM 
    customers JOIN orders ON customers.cust_id = orders.cust_id
                      JOIN orderitems ON orders.order_num = orderitems.order_num
                      JOIN products ON orderitems.prod_id = products.prod_id
    WHERE prod_name = product_name;
     
END count_customers;



(5) Написати процедуру, що додає нове замовлення покупцю, за умови, що на вказану дату нема інших 
    замовлень даного покупця, що містять 3 різних товари у будь-якій кількості. Визначити усі необхідні 
    параметри. Якщо операція не можлива - процедура кидає excpetion.
    
    
CREATE OR REPLACE PROCEDURE create_new_order(customer_id IN CUSTOMERS.CUST_ID%TYPE,
                                             order_date IN ORDERS.ORDER_DATE%TYPE,
                                             order_num IN ORDERS.ORDER_NUM%TYPE) -- SHOULD BE CREATED AUTOMATICALLY BY SEQUENCE
IS
    invalid_orders INT;
    is_customer_exists INT;
    invalid_date_exception EXCEPTION;
    invalid_customer EXCEPTION;
BEGIN
    SELECT COUNT(cust_id) INTO is_customer_exists FROM customers WHERE cust_id = customer_id;
    IF(is_customer_exists = 1) THEN
    
        SELECT COUNT(order_num) INTO invalid_orders FROM
            (SELECT orders.order_num, COUNT(distinct orderitems.prod_id) AS quantity
                FROM customers JOIN orders ON customers.cust_id = orders.cust_id
                                             JOIN orderitems ON orders.order_num = orderitems.order_num
                WHERE customers.cust_id = customer_id  AND orders.order_date = order_date
                GROUP BY orders.order_num) WHERE  quantity = 3;
                
        IF (invalid_orders > 0) THEN
            RAISE invalid_date_exception;
        ELSE 
            INSERT INTO orders (order_num, order_date, cust_id) VALUES (order_num, order_date, customer_id);
        END IF;
        
    ELSE 
        RAISE invalid_customer;
    END IF;
END create_new_order;



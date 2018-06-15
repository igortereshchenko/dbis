-- LABORATORY WORK 5
-- BY Sielskyi_Yevhenii

/* 1 task*/
Create or Replace function count_of_products (order_key in Orders.order_num%TYPE) return number
IS
    counter number;
Begin
    Select Distinct count(prod_id) into counter
    From Orders JOIN Orderitems
            On Orders.order_num = Orderitems.order_num
        Join Products
            On Orderitems.prod_id = Products.prod_id
    Where Orders.order_num = order_key;
    
    return counter;
End count_of_products;

/* 2 task*/

Create or Replace procedure get_product_key (product_name in Products.prod_name%TYPE, product_key out Products.prod_num%TYPE)
IS
    product_name_exception EXCEPTION;
    counter number;
Begin
    Select distinct count(prod_id) into counter
    From Products
    Where Products.prod_name = product_name;
    
    If counter = 1 Then
        Select distinct prod_id into product_key
        From Products
        Where Products.prod_name = product_name;
    ELSE
        Raise product_name_exception;
    END IF;
End;
EXCEPTION
    WHEN product_name_exception THEN
        DBMS_OUTPUT.put_line("Product name not found or there are more than one distinct products with such name");
End get_product_key;

/* 3 task*/

Create or Replace procedure update_product_name (product_name in Products.prod_name%TYPE, new_name in Products.prod_name%TYPE, product_key in Products.prod_num%TYPE)
IS
    product_not_exist_exception EXCEPTION;
    product_child_exception EXCEPTION;
    counter1 number;
    counter number;
Begin
    Select  count(prod_id) into counter1
    From Products
    Where prod_id = product_key;

    Select distinct count(Products.prod_id) into counter
    From Orderitems JOIN Products
            On OrderItems.prod_id = Products.prod_id
    Where Products.prod_id = product_key;
    
    If counter1 = 0 Then
        RAISE product_not_exist_exception; 
    ELSIf counter >= 1 THEN
        Raise product_child_exception;
    ELSE 
        UPDATE TABLE Products 
        Set prod_name = new_name
        Where prod_id = product_key
    END IF;
End;
Exception
    WHEN product_not_exist_exception THEN
        DBMS_OUTPUT.put_line("Product does not exist");
    WHEN product_child_exception THEN
        DBMS_OUTPUT.put_line("Product has been already ordered");
End update_product_name;

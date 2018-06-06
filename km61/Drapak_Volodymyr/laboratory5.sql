-- LABORATORY WORK 5
-- BY Drapak_Volodymyr

/* Написати функцію, що повертає кількість замовлень, що містять тільки один продукт у
будь-якій кількості, за ключем покупця, що є параметр функції */


CREATE OR REPLACE FUNCTION get_specific_orders_count(cid IN Customers.CUST_ID%TYPE)
RETURN NUMBER

IS
    
    v_prod_count NUMBER := 0;
    
BEGIN

    SELECT COUNT(ORDER_NUM)
    INTO v_prod_count
    FROM (
        SELECT ORDER_NUM, COUNT(Orderitems.PROD_ID) as prod_count
        FROM Orders NATURAL JOIN Orderitems
        WHERE CUST_ID = cid
        GROUP BY ORDER_NUM
    )
    WHERE prod_count = 1;
    RETURN v_prod_count;

END;


/* Написати процедуру, що за назвою існуючого продукту повертає кількість покупців,
що його купляли, якщо операція неможлива, процедура кидає exception */


CREATE OR REPLACE PROCEDURE get_prod_cust_count(v_prod_name IN Products.prod_name%TYPE,
                                                    cust_count OUT NUMBER)

IS

    no_such_prod_exception EXCEPTION;
    PLSQL_is_shit NUMBER;
    
BEGIN

    SELECT COUNT(*) INTO PLSQL_is_shit
    FROM Products
    WHERE prod_name = v_prod_name;

    IF SQL%NOTFOUND THEN
        raise no_such_prod_exception;
    END IF;

    SELECT COUNT(DISTINCT cust_id) INTO cust_count
    FROM Orders
    NATURAL JOIN Orderitems
    NATURAL JOIN Products
    WHERE prod_name = v_prod_name;

END;


/* Hаписати процедуру, що додає нове замолвення покупцю, за умови, що на вказану
дату нема інших замовлень даного покупця, що містять 3 різних товари у будь-якій
кількості. Визначити усі необхідні параметри. Якщо операція неможлива,
процедура кидає exception */


CREATE OR REPLACE PROCEDURE add_order(cid IN Customers.cust_id%TYPE,
                                      o_date IN Orders.order_date%TYPE)
                                      
IS
    v_order_num Orders.order_num%TYPE := '20001';
    no_such_cust_id_exception EXCEPTION;
    PLSQL_is_shit NUMBER := 0;
    prod_count NUMBER;
BEGIN

    SELECT COUNT(*) INTO PLSQL_is_shit
    FROM Customers
    WHERE CUST_ID = cid;
    
    IF PLSQL_is_shit = 0 THEN
        raise no_such_cust_id_exception;
    END IF;
    
    SELECT COUNT(*) INTO PLSQL_is_shit
    FROM(
        SELECT order_num
        FROM (
            SELECT order_num, prod_id
            FROM Orders
            NATURAL JOIN Orderitems
            WHERE (cust_id = cid) AND (order_date = o_date)
        )
        GROUP BY order_num
        HAVING COUNT(prod_id) >= 3
    );
    
    IF PLSQL_is_shit = 0 THEN
        INSERT INTO Orders
        VALUES(v_order_num, o_date, cid);
    END IF;
    
END;

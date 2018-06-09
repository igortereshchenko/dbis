-- LABORATORY WORK 3
-- BY Moroziuk_Yevhenii
/*1. Написати PL/SQL код, що по вказаному ключу покупця додає йому замовлення з ключами 111,....111+n, 
щоб сумарна кількість його замовлень була 10. Дати замовлень - дата його першого замовлення.
 10 балів*/



/*2. Написати PL/SQL код, що по вказаному ключу покупця виводить у консоль його ім'я та визначає  його статус.
Якщо він має до 2 замовлень включно - статус  = "common"
інакше він має статус "o status" 4 бали*/
    DECLARE
        cust_id           INT := 0;
        count_of_orders   INT := 0;
    BEGIN
        SELECT
            customers.cust_id
        INTO
            cust_id
        FROM
            customers
        WHERE
            customers.cust_id = cust_id;

        SELECT
            COUNT(DISTINCT orders.order_num)
        INTO
            count_of_orders
        FROM
            customers
        WHERE
            orders.order_num = count_of_orders;

        SELECT
            customers.cust_id,
            COUNT(DISTINCT orders.order_num)
        FROM
            customers
            JOIN orders ON customers.cust_id = orders.cust_id
        GROUP BY
            customers.cust_id;

        IF
            ( count_of_orders ) <= 2
        THEN
            dbsm_output.put_line(cust_id
            || 'common');
        ELSE
            dbsm_output.put_line(cust_id
            || 'o status');
        END IF;

    END;



/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та ім'я постачальника, що співпрацювали.
3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/
CREATE VIEW mAview AS
SELECT
    customers.cust_id,
    vendors.vend_name,
    vendors.vend_id,
    orderitems.quantity
FROM
    customers join orders on
    customers.cust_id = orders.cust_id
    join orderitems on
    orders.ORDER_NUM = orderitems.order_num
    join products on 
    orderitems.prod_id = products.prod_id
    join vendors on
    products.vend_id = vendors.vend_id;
  

SELECT DISTINCT
    cust_id,
    vend_name
FROM mAview;

SELECT DISTINCT
    VEND_ID,
    QUANTITY
FROM mAview;

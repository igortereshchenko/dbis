-- LABORATORY WORK 3
-- BY Kollehina_Kateryna
-- LABORATORY WORK 3
-- BY Kollehina_Kateryna
/*1.  Написати PL/SQL код, що додає продукт постачальнику з ключем BRS01, щоб сумарна кількість його продуктів була 4.
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/

DECLARE
    var_vend_id      vendors.vend_id%TYPE;
    var_prod_id      products.prod_id%TYPE;
    var_prod_name    products.prod_name%TYPE;
    var_prod_price   products.prod_price%TYPE;
    var_count  integer := 0;
    
BEGIN

    var_vend_id := 'BRS01';
    var_prod_id   := 'prod';
    var_prod_name := 'PROD';

FOR i IN 1..var_count 
 Loop
    INSERT INTO products
               (prod_id,
                vend_id,   
                prod_name,
                prod_price )
      VALUES
               ( TRIM(var_prod_id) || i,
                 var_vend_id,
                 TRIM(var_prod_name) || i,
                 var_prod_price   )
      exit when var_count= 4;
 end loop;    
end;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив найдорожчий продукт - статус  = "yes"
Якщо він не купив найдорожчий продукт- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

 
DECLARE
    var_cust_id     customers.cust_id%TYPE;
    var_cust_name   customers.cust_name%TYPE;
    var_price       orderitems.item_price%TYPE;
    max_prod_price integer:=0;
    prod_status varchar(10):= '';
BEGIN
   SELECT  
      cust_id,
      cust_name,
      max(items.item_price)
    INTO   
      var_cust_id,
      var_cust_name 
      max_prod_price
    FROM customers
        JOIN orders ON orders.cust_id = customers.cust_id
        JOIN orderitems ON orders.order_num = orderitems.order_num
        JOIN products ON products.prod_id = orderitems.prod_id
    WHERE
        customers.cust_id = var_cust_id
    GROUP BY
        customers.cust_id,
        customers.cust_name;

    IF
        var_price < max_prod_price
    THEN
        prod_status := 'no';
    ELSIF var_price = max_prod_price  THEN
        prod_status := 'yes';
    ELSE
        prod_status := 'unknown';
    END IF;
 
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести назву продукту та загальну кількість його продаж.
3.2. Яка сумарна кількість товарів була куплена покупцями, що проживають в Америці.
6 балів.*/
CREATE VIEW customers_vendors AS
SELECT customers.cust_id,
       customers.cust_name,
       products.prod_name,
       customers.cust_country
FROM customers
     JOIN orders ON orders.cust_id = customers.cust_id
     JOIN orderitems ON orders.order_num = orderitems.order_num
     JOIN products ON products.prod_id = orderitems.prod_id;
SELECT 
    prod_name,
    prod_id,
    count( distinct order_item) 
    from 
       customers_vendors
       GROUP BY prod_name, prod_id;
SELECT
     count( distinct cust_country) 
     from customers_vendors
       WHERE cust_country = 'USA';

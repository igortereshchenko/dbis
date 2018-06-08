-- LABORATORY WORK 4
-- BY Shumel_Sofiia
/*-----------------------------------------------------------------------
1.Создать тригер, который при вводе Сustomer добавляет пустой заказ.
------------------------------------------------------------------------*/
CREATE OR REPLACE TRIGGER insert_cust
AFTER 
INSERT ON Customers
FOR EACH ROW
BEGIN
INSERT INTO ORDERS(order_name, order_date, cust_id) VALUES('83739', sysdate, Customer.cust_id);
ENG;


/*-----------------------------------------------------------------------------------------
2. Создать тригер, которые не разрешает менять цену продукта, если он еще не продавался.
--------------------------------------------------------------------------------------------*/
CREATE OR REPLACE TRIGGER name
AFTER
UPDATE ON products
BEGIN
	IF (SELECT prod_id.orderitems 
		FROM products LEFT JOIN OrderItems 
		ON prod_id.products = prod_id.orderitems) IS NULL
	THEN
		prod_price = :OLD.prod_plice;
END;



/*-------------------------------------------------------------
3. Создать курсор с параметром cust_name и вывести количество
заказов и названия продуктов в этом заказе.
---------------------------------------------------------------*/
DECLARE 
	CURSOR order_prod(input_name cust_name%TYPE) IS
		SELECT prod_name, COUNT(ORDER_NUM) count_order
		FROM customers NATURAL JOIN orders 
		RIGHT JOIN OrderItems ON order_num.orders = order_num.orderitems
		NATURAL JOIN products
		WHERE cust_name = input_name;
cur_rec order_prod%rowtype;
BEGIN
	IF NOT order_prod%ISOPEN THEN
		OPEN order_prod;
	END IF;
	FETCH order_prod INTO cur_rec;
	WHILE order_prod%FOUND THEN
	LOOP
		dbms_output.put_line(cur_rec.prod_name|| ' ' || cur_rec.count_order);
	END LOOP;
END;

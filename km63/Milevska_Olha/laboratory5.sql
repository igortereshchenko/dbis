-- LABORATORY WORK 5
-- BY Milevska_Olha

create or replace FUNCTION get_cust_id(NUM_O ORDERS.ORDER_NUM%TYPE)

RETURN CHAR
AS
  ID_C ORDERS.CUST_ID%TYPE;
BEGIN
  SELECT CUST_ID
  INTO ID_C
  FROM ORDERS 
  WHERE CUST_ID = ID_C;
RETURN ID_C;
END get_cust_id;

SELECT get_cust_id('20005') FROM DUAL;





create or replace procedure updateProductName (oldProdName in products.prod_name%Type,newProdName in products.prod_name%Type ) 
is 

count1 exception;
order_count number;
    begin 
    
    select count(distinct order_num) into  order_count
    from products join orderitems
    on products.prod_id = orderitems.prod_id
    where products.prod_name = oldProdName;
    
    if (order_count = 1 )then 
      raise  count1 ;
    ELSE
      update products SET prod_name = newProdName
      where prod_name = oldProdName;
    end if;
EXCEPTION
    when no_data_found then 
      RAISE_application_error (-20555, 'No found product');
    when count1 then 
      RAISE_application_error (-20556, 'Order count = 1');

end updateProductName;

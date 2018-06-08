-- LABORATORY WORK 5
-- BY Kharchenko_Kateryna
/*написати функцію, що повертає загальну вартість товарів, за ключем замовлення*/

CREATE FUNCTION function_name
           (orderkey IN ORDERLTEMS.ORDER_NUM%type) 
          RETURN INT
          IS
              Counts numbers(3);
          BEGIN
             SELECT 
             SUM(ITEM_PRICE)  
             FROM ORDERLTEMS
             WHERE ORDERLTEMS.ORDER_NUM = orderkey;
          END function_name;
 
 /*Написати процедуру, що за назвою продукту повертає дату у яке входить та імя
 замовника, що купляв даний продукт. якщо операція не можлива процедура кидаеє 
 exception*/     
 
 CREATE PROCEDURE procedure_name
      (prod IN PRODUCTS.PROD_NAME%type,
       dates OUT ORDERS.ORDER_DATE%type,
       names OUT CUSTOMERS.CUST_NAME%type)
       IS   
       BEGIN
        SELECT
        ORDERS.ORDER_DATE |' '| CUSTOMERS.CUST_NAME 
        FROM CUSTOMER JOIN (
            SELECT PROD_NAME, ORDER_NUM, CUST_ID 
            FROM ORDERS JOIN (
                SELECT PROD_ID, PROD_NAME, ORDER_NUM
                FROM PRODUCTS JOIN ORDERLTEMS AS PRODUCTS.PROD_ID = ORDERLTEMS.PROD_ID
                WHERE PRODUCTS.PROD_NAME = prod)
                AS ORDERS.ORDER_NUM = ORDERLTEMS.ORDER_NUM)
                AS CUSTOMER.CUST_ID = ORDERS.CUST_ID;
       END procedure_name;
       
/*Написати процедуру, що оновлює назву продукт, за умови, що такий продукт єдиний 
з вказаною назвою та продавався. ґВизначити усі необхідні параметри. Якщо продукт 
вже існує - процедура кидає exception*/

-- LABORATORY WORK 5
-- BY Ushatska_Vasylyna
1. 
CREATE FUNCTION item_num
           (O_id in number, item_num IN VARCHAR2 ) 
          RETURN item_num VARCHAR2
          IS
              
          BEGIN
          select COUNT(distint(prod.id))INTO item_num
          from orders
          where ORDER_NUM =O_id
              return item_num
          END ;
          
        2.  
        CREATE PROCEDURE c_name
                 (c_name in VARCHAR2) 
                IS
                    
                BEGIN
                    SELECT  CUST_ID 
                    FROM CUSTOMERS
                    WHERE CUST_NAME=c_NAME
                EXCEPTION  
                WHEN no_data_found
                THEN DBMS_output.line(sorry, try again)
                when other 
                then DBMS_output.line(sorry, ..)
                
                END c_name ;
                
                
                3. 
                CREATE PROCEDURE new_name
                       (P.NAME VARCHAR2
                       NEW.NAME VARCHAR2) ]
                      IS
                          EXCEPTION NOT_EXIST
                          EXCEPTION SOLD
                      BEGIN
                          SELECT PROD_NAME
                          FROM PRODUCTS 
                          WHERE PROD_NAME=P.NAME
                          UPDATE PRODUCTS
                          SET PRODUCTS.PROD_NAME=NEW_NAME
                          RAISE EXCEPTION  SOLD 
                          WHEN PROD_NAME
                          FROM PRODUCTS JOIN ORDERITEMS
                          ON PRODUCT.PROD_ID=ORDERITEM.PROD_ID
                          RAISE EXCEPTION  NOT_EXIST
                          WHEN 
                    EXCEPTION 
                      WHEN SOLD 
                      THEN DBMS_output.line(sorry, ..)
                      WHEN NOT_EXIST
                      THEN 
                          
                     END new_name;
                      
                
                
                
      

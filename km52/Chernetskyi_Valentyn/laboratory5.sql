-- LABORATORY WORK 5
-- BY Chernetskyi_Valentyn
1. CREATE FUNCTION count_products 
          (prod_name in varchar)
          RETURN quantity
          IS
              prod_count quantity
          BEGIN
              SELECT COUNT(DISTINCT prod_id)
              into prod_count
              from products
          RETURN prod_count;
          END count_products;
      
2. CREATE PROCEDURE prod_name_return_prod_id
       ( prod_name in varchar2, prod_id out varchar2)
      IS
          
      BEGIN
          SELECT prod_id
          INTO product_id
          FROM Products
          WHERE prod_id=product_id
          
          RETURN prod_id
          
          EXCEPTION 
          WHEN NO_DATA_FOUND THEN
          dbms_output.put_line('A SELECT PROD_ID INTO did not return any rown')
          
      END;
  
3. CREATE PROCEDURE update_prod_name
       (in_prod_id in varchar2, in_prod_name in varchar2)
      IS
        prod_count number;
      BEGIN
          select count(*)
          into prod_count
          from products
          where prod_id = in_prod_id;
  
          if prod_count = 0 then
          raise_application_error( -20001, 'Products not found' );
          end;
                  
          update products
          set prod_name = input_prod_name
          where prod_name = in_prod_name;
          
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN
          dbms_output.put_line('A SELECT PROD_ID INTO did not return any rown')
          
      END procedure_name;
      

-- LABORATORY WORK 3
-- BY Kysla_Olha
/*1. Написати PL/SQL код, що додає продукт постачальнику з ключем BRS01, щоб сумарна 
кількість його продуктів була 4. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
DECLARE
    v_vend_id      vendors.vend_id%TYPE;
    v_count_prod   NUMBER(20);
    
begin
    v_vend_id := 'BRS01';
    SELECT
        vendors.vend_id,
        COUNT(products.prod_id)
    INTO
        v_vend_id,v_count_prod
    FROM
        vendors left
        JOIN products ON vendors.vend_id = products.vend_id
    WHERE
        vendors.vend_id = v_vend_id
    GROUP BY
        vendors.vend_id;

FOR i IN v_count_prod..4 loop
    INSERT INTO products ( prod_id ) VALUES ( 'prod'
    || i );
    where products.vend_id = v_vend_id end loop
     
end;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив найдорожчий продукт - статус  = "yes"
Якщо він не купив найдорожчий продукт- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

set SERVEROUTPUT on 
declare 
 status varchar(10);
 v_vend_id  VENDORS.VEND_ID%Type;
 V_prod_id  products.prod_id%Type;
 v_vend_name  VENDORS.VEND_name%Type;
 v_prod_price products.prod_price%Type;
 max_prod  products.prod_price%Type;
 
begin
     V_vend_id := 'BRS01';
     
     select distinct max( products.prod_price) into max_prod
     from  products;

     select vendors.vend_name, products.VEND_ID, products.prod_price  into
     v_vend_name, V_prod_id, v_prod_price
     from vendors LEFT join products
     on VENDORS.VEND_ID = products.vend_id 
     where VENDORS.VEND_ID = V_vend_id;
     
    if (V_prod_id is null ) then  
      status := 'unknown';
      elsif v_prod_price = max_prod then  status := 'yes';
      else status := 'no';
    end if;
    
    DBMS_OUTPUT.PUT_LINE(v_vend_name ||status );
end;

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести назву продукту та загальну кількість його продаж.
3.2. Яка сумарна кількість товарів була куплена покупцями, що проживають в Америці.
6 балів.*/
 create view prod_ven as 
 select products full join 








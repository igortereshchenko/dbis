-- LABORATORY WORK 3
-- BY Maliarenko_Illia
/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 1,....n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів = кллюч продукту. Ціна кожного продукту = 1.
Операція виконується, якщо у постачальника є хоча б один продукт. 10 балів*/
set serveroutput on

/*DEFINE
v_vend_id vendors.vend_id%type := "BRS01";
BEGIN
INSERT 
END*/


/*2. Написати PL/SQL код, що по вказаному ключу постачальникавиводить у консоль його ім'я та изначає  його статус.
Якщо він має 0 продуктів - статус  = "poor"
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich" 4 бали*/

DECLARE 
v_vend_name vendors.vend_name%type;
v_vend_id vendors.vend_id%TYPE := 'BRS01';
v_status VARCHAR2(10);
v_prod_count int;

BEGIN
  SELECT vend_name, COUNT(prod_name)
  into v_vend_name, v_prod_count
  FROM products
  RIGHT JOIN vendors USING(vend_id)
  GROUP BY vend_id, vend_name
  HAVING VEND_ID = 'BRS01';
if v_prod_count = 0 then
  v_status:= 'poor'
elsif v_prod_count <= 2 then
  v_status:= 'common'
else v_status:= 'rich'
end if;
SYS.DBMS_OUTPUT.PUT_LINE(v_vend_name ||' '|| v_status)
END;



/*  v_status:= 
    if  then
    elsif then
    else
  DBMS_OUTPUT.PUT_LINE()*/

/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та та ім'я постачальника, що не співпрацювали.
3.2. Вивести ім'я постачальника та загальну кількість проданих ним продуктів 6 балів.*/

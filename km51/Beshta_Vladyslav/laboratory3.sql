-- LABORATORY WORK 3
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

DECLARE
  VendId      CHAR(10):='';
  VendName    CHAR(50):='';
  VendAddress CHAR(50):='';
  VendCity    CHAR(50):='';
  VendState   CHAR(5) :='';
  VendZip     CHAR(10):='';
  VendCountry CHAR(50):='';
  counter1    NUMBER  :=0;
BEGIN
  VendId      :='v';
  VendName    :='Bears R Us';
  VendAddress :='123 Main Street';
  VendCity    :='Bear Town';
  VendState   :='MI';
  VendZip     :='44444';
  VendCountry :='USA';
  SELECT COUNT(vend_id) counter INTO counter1 FROM vendors ;
  FOR i IN counter1..6
  LOOP
    INSERT
    INTO vendors
      (
        vend_id,
        vend_name,
        vend_address,
        vend_city,
        vend_state,
        vend_zip,
        vend_country
      )
      VALUES
      (
        trim(VendId)
        ||i,
        VendName,
        VendAddress,
        VendCity,
        VendState,
        VendZip,
        VendCountry
      );
  END LOOP;
END;





/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив більше 10 продуктів - статус  = "yes"
Якщо він купив менше 10 продуктів - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

DECLARE
  CustId          CHAR(10):='';
  CustName        CHAR(50):='';
  CustCount       Number:=0;
BEGIN
  SELECT customers.cust_id,customers.cust_name, count(distinct orderitems.prod_id) 
  INTO 
  CustId,
  CustName,
  CustCount
  from customers join orders ON
  customers.cust_id=orders.cust_id
  join orderitems
  ON orders.order_num=orderitems.order_num
  group by customers.cust_id,customers.cust_name;
  if CustCount>10 then
  DBMS_OUTPUP.PUT_line('yes');
  else if CustCount=0 then
  DBMS_OUTPUP.PUT_line('no');
  else
  DBMS_OUTPUP.PUT_line('unknown');
  end if;
END;  



/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ім’я покупця та загальну кількість куплениx ним товарів.
3.2. Вивести ім'я постачальника за загальну суму, на яку він продав своїх товарів.
6 балів.*/
CREATE OR REPLACE VIEW info AS 
  SELECT customers.cust_name,orderitems.item_price,orderitems.quantity , vendors.vend_name
  FROM customers
  JOIN orders
  ON customers.cust_id=orders.cust_id
  JOIN orderitems
  ON orders.order_num=orderitems.order_num
  JOIN products
  ON orderitems.prod_id=products.prod_id
  JOIN vendors
  ON products.vend_id=vendors.vend_id;
  
SELECT info.cust_name,sum(info.quantity) suma1
from info
group by info.cust_name;

SELECT info.vend_name, sum(info.quantity*info.item_price) suma2
from info
group by info.vend_name;
-- BY Beshta_Vladyslav

create or replace function ordercount(s_cust_id in Customers.cust_id%type)
  return int
  as
  countprod int;
  begin
    select count(prod_id)
    into countprod from customers left join orders using(cust_id) join orderitems using(order_num)
    group by cust_id
    having cust_id = s_cust_id;
    return countprod;
  end ordercount;
  
create or replace procedure count_cust(pr_name products.prod_name%type)
is
  countcust int;
  checkprod int;
  my_exception exception;
  begin
    select count(*) into checkprod from pdoructs where prod_name = pr_name;
    if checkprod = 0 then raise my_exceprion;
    select count(prod_id)
        into countcust from customers join orders using(cust_id) join orderitems using(order_num) right join products using(prod_id)
        group by prod_id
        having prod_name = pr_name;
        return countprod = s_cust_id;
  end cout_cust;

create or replace procedure addorder(ord_num orderitems.order_num%type, )
  is
  countcust int;
  begin
    select count(prod_id)
        into countcust from customers join orders using(cust_id) join orderitems using(order_num) right join products using(prod_id)
        group by prod_id
        having prod_name = pr_name;
        return countprod = s_cust_id;
  end cout_cust;
end;

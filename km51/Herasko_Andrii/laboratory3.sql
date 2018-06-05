-- LABORATORY WORK 3
-- BY Herasko_Andrii
--2
declare
id_ vendors.vend_id%type;
country vendors.vend_country%type;
count_  number;
status varchar;
begin
  id_ := "BR01";
  select count(*) into count_ from Vendors where
  vend_name = (select vend_name from Vendors where vend_id = id_);
  select vend_country into country from Vendors where vend_id = id_;
  if (count_ > 1) then
    status := "Tak";
  else
    status := "Hi";
  end if;
  dbms_output.put_line(""||country);
end;

--1
declare
  key1 varchar;
  key2 varchar;
  price number;
begin
  key1 := "v";
  key2 := "p";
  select min(prod_price) into price from Products;
  FOR i IN int(10) LOOP
    insert into Vendors (vend_id, vend_name) values (trim(key1)||i, "asfasf");
    insert into Products (prod_id, vend_id, prod_price) values (trim(key2)||i, trim(key1)||i, price);
  end loop;
end;

-- LABORATORY WORK 5
-- BY Koltsov_Dmytro
create or replace FUNCTION coun_null(vend VENDORS.vend_id%type)
RETURN INT
AS
resul INT;
begin
select
count(*) into resul
from
VENDORS left join PRODUCTS on
VENDORS.vend_id = PRODUCTS.vend_id
left join ORDERITEMS on
PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
where VENDORS.vend_id = vend and order_num is null;

return resul;
end coun_null;

create or replace PROCEDURE PR_NAME (prod_name in PRODUCTS.PROD_NAME%type, keye out ORDERITEMS.ORDER_NUM%type)
IS
BEGIN

select
order_num into keye
from
PRODUCTS left join ORDERITEMS on
PRODUCTS.prod_id = ORDERITEMS.PROD_ID
where
PRODUCTS.PROD_NAME = prod_name;
END PR_NAME;

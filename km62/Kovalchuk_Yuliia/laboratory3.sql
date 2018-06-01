-- LABORATORY WORK 3
-- BY Kovalchuk_Yuliia
/*1. Написати PL/SQL код, що по вказаному ключу замовника додає йому замовлення з номерами 1,....n, 
щоб сумарна кількість його замовлень була 10. Дати нових замовлень дорівнюють даті останього замовлення. 
Операція виконується, якщо у замовника є хоча б одне замовлення. 10 балів*/

    declare 
    orderitems.order_id.TYPe
orderitems.order_nam varchar2(20) Not Null
VENDORS.VEND_ID  varchar2(20)
BEGIN
customers.cust_id = "1000000001"
If orderitems.order_nam>1
then
fOR 1...
end if;
Where Count(orderitems.order_nam)=10


a
END;


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та изначає  його статус.
Якщо він має 0 замовлень - статус  = "poor"
Якщо він має до 2 замовлень включно - статус  = "common"
Якщо він має більше 2 замовлень - статус  = "rich" 4 бали*/
    declare 
    customer.cust_name CHAR(10) nOT NULL
vENDORS.VEND_ID CHAR(10) nOT NULL

BEGIN
customers.cust_id = "1000000001"

Loop
IF cAUNT(VENDORS.CUST)=0
THEN CUST_nAME:= 'poor'a
ELSIF 
cAUNT(VENDORS.CUST)<2 AND cAUNT(VENDORS.CUST)>0
THEN CUST_nAME:= 'common'
ELSE
cAUNT(VENDORS.CUST)=>2
THEN CUST_nAME:= 'rich'
end if;
SELECT vENDORS_VEND_NAME FROM VENDORS 

eND;




/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та постачальника, що співпрацювали.
3.2. Вивести ім'я покупця та загальну кількість куплених ним продуктів 6 балів.*/

VIEW VENDO
cUSTOMERS 
joIN cUSTOMERS  
Orders.cust_id=cUSTOMERS.cust_id
joIN Orders  oN
Orederitems.order_num=orders.order_num
joIN Orederitems  oN
Products.prod_id=Orederitems.prod_id
joIN Products  oN
Vndors.vend_id=Products.vend_id

Select dISTINCT (vand_id,CUSTOMERS_ID) From VENDO

SELECT CUSTOMERS_ID, COUNT(PROD_ID) FROM VENDO
WHERE oRDERS.order_num = ordersiytems.order_num



import csv

import cx_Oracle

connection = cx_Oracle.connect("system", "uuuliakov1607199por", "xe")
 
cursor_shop= connection.cursor()
 
cursor_shop.execute("""
SELECT
    TRIM(shop_id) as shop_id,
    TRIM(shop_name) as shop_name,
    TRIM(shopt_location) as shopt_location
FROM
    shop""")
 
 
 
for shop_id, shop_name, shopt_location in cursor_shop:
 
    with open("shop_"+shop_id+".csv", "w", newline="") as file:
        writer = csv.writer(file)
 
        writer.writerow(["ID", shop_id])
        writer.writerow(["Name", shop_name])
        writer.writerow(["Location", shop_locatione])
 
        cursor_phone = connection.cursor()
 
        query = """
                    SELECT
                        *
                    FROM
                         phone
                    WHERE TRIM(shop_id) = :id"""
 
        cursor_phone.execute(query, id = shop_id)
        writer.writerow([])
        writer.writerow(["phone_id", "phone number", "phone price", "phone_marka"])
        for phone_row in cursor_phone:
            writer.writerow(phone_row)
 
cursor_shop.close()

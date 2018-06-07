/*
При стореені Магазину додається замволення
*/
CREATE  TRIGGER create_order 
BEFORE UPDATE  ON shop 
FOR EACH ROW 
BEGIN 
INSERT INTO order (order_nam, order_date, shop_adres)
VALUES 
(:new.order_nam, 
 :new.order_date, 
 :new.shop_adres, 
); 
END; 

/*
При зміні і'мя видаляється замовлення
*/		
CREATE TRIGGER Delete_order
AFTER UPDATE OF shop_name ON Shop 
BEGIN 
DELETE FROM ORDER
 WHERE order_num = olld.order_num;
END;



/*
Курсор параметр адрес магазину виводить і'мя людини, що купили в магазині
*/
declare
  cursor cursor_name is 
      select shop_adres
        from shop join human using(shop_adres)


  rec cursor_name %rowtype;

begin

  for emp_cur. in cursor_name loop

dbms_output.put_line( to_char (emp_cur..shop_adres) || ' ' || emp_cur..hop_adres  );

    if mod(emp_cur.hop_adres,2) = 0 then
      update human set human_indeficat_code= upper(human_indeficat_code) 
       where current of cursor_name 
       dbms_output.put_line(' updated');
    else
      dbms_output.new_line;
    end if;
  end loop;
end;/


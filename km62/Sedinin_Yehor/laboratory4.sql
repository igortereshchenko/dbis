-- LABORATORY WORK 4
-- BY Sedinin_Yehor
/*---------------------------------------------------------------------------
1. TRIGGER change departure_time -> delete all tickets
---------------------------------------------------------------------------*/
CREATE OR REPLACE TRIGGER time_change 
BEFORE UPDATE OF departure_time
ON Train
FOR EACH ROW 
BEGIN 
	IF :old.departure_time != :new.departure_time THEN
   		DELETE FROM Ticket
       	WHERE Ticket.train_id = :old.train_id
   	END IF;
END; 

/*---------------------------------------------------------------------------
2. TRIGGER create new train -> create new ticket
---------------------------------------------------------------------------*/
CREATE OR REPLACE TRIGGER train_creation 
BEFORE INSERT OF train_id
ON Train
FOR EACH ROW 
BEGIN 
	INSERT INTO Ticket (ticket_id, train_id)
	VALUES (next_id, :new.train_id)
END; 

/*---------------------------------------------------------------------------
3. CURSOR(stud_name) output -> which trains and salepoints were used
---------------------------------------------------------------------------*/
DECLARE 
	stud_rec rec_tbl%rowtype;
	CURSOR stud_output (stud_name varchar2) IS
	SELECT salepoint_id, train_id
	FROM Ticket JOIN Student ON Ticket.student_id = Student.student_id
	JOIN Salepoint ON Ticket.salepoint_id = Salepoint.salepoint_id
	JOIN Train ON Ticket.train_id = Train.train_id
	WHERE student_name = stud_name;
BEGIN
	OPEN stud_output;
	FETCH stud_output INTO stud_rec;
		dbms_output.put_line(stud_output.salepoint_id || ' ' || stud_output.train_id);
	CLOSE stud_output;
END;


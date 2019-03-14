-- LABORATORY WORK 1
-- BY Lutsyk_Maksym
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user Lutsyk identified by password;

default tablespace "users";
temporary tablespace 'temp';

alter uses quota 100m on user;

grant 'connect' to Lutsyk;
grant create any table to Lutsyk;
grant delete any table to Lutsyk;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент здає роботу викладачу.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:    (додано 09.05.2018)

CREATE TABLE student( 
Gbook_num VARCHAR(20) NOT NULL,
SFirst_name CHAR(25),
SLast_name CHAR(25)
); 
 
Create table TEACHER(
Contract_num VARCHAR (20) NOT NULL PRIMARY KEY,
TFirst_name CHAR(25),
TLast_name CHAR(25)
);
 
Create table Tasks (
Gbook_num VARCHAR(20) NOT NULL, 
Contract_num VARCHAR (20) NOT NULL,
Task_num INT not null
);

Create table TASK_INFO(
Task_num INT NOT NULL ,
Count_ex int,
PRIMARY KEY (Task_num)
);

ALTER TABLE STUDENT
ADD CONSTRAINT gbook_num_pk PRIMARY KEY(gbook_num); 
ALTER TABLE TEACHER
ADD CONSTRAINT conract_num_pk PRIMARY KEY(Contract_num); 

ALTER TABLE Tasks
    ADD CONSTRAINT gbook_num_fk FOREIGN KEY ( gbook_num )
        REFERENCES student ( gbook_num );
ALTER TABLE Tasks        
    ADD CONSTRAINT conract_num_fk FOREIGN KEY ( Contract_num )
		REFERENCES TEACHER ( Contract_num );
ALTER TABLE Tasks 
	ADD CONSTRAINT Task_num_pk PRIMARY KEY(Task_num);
ALTER TABLE TASK_INFO
    ADD CONSTRAINT Task_num_fk FOREIGN KEY ( Task_num )
        REFERENCES TASK_INFO ( Task_num );

		
ALTER TABLE student ADD CONSTRAINT st_num_check CHECK (LENGTH(Gbook_num)=8);
ALTER TABLE Tasks ADD CONSTRAINT task_num_check CHECK (Task_num>=1 and Task_num<=18);


INSERT INTO Student(Gbook_num, SFirst_name, SLast_name)
VALUES('KB123456', 'Maxim', 'Maximov');
INSERT INTO Student(Gbook_num, SFirst_name, SLast_name)
VALUES('KB123457', 'Anastasia', 'Anastasieva');
INSERT INTO Student(Gbook_num, SFirst_name, SLast_name)
VALUES('KB123458', 'Ivan', 'Ivanov');

INSERT INTO Teacher(Contract_num, TFirst_name, TLast_name)
VALUES('q1234567', 'Smith', 'Smithov');
INSERT INTO teacher(name, rank, id)
VALUES('w1234567', 'Charly', 'Charlovsky');
INSERT INTO teacher(name, rank, id)
VALUES('e1234567', 'Toby', 'Tobyovich');

INSERT INTO Tasks(Gbook_num, Contract_num, task, Task_num)
VALUES('KB123456', 'q1234567', 1);
INSERT INTO work(work_id, subject, task, teacher_id)
VALUES('KB123457','w1234567', 2);
INSERT INTO work(work_id, subject, task, teacher_id)
VALUES('KB123458', 'e1234567', 3);

INSERT INTO TASK_INFO(Task_num, Count_ex )
VALUES(1, 5);
INSERT INTO studentYieldsWork(work_id, student_id)
VALUES(2, 10);
INSERT INTO studentYieldsWork(work_id, student_id)
VALUES(3, 15);

				


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
grant create any table to Lutsyk; 
grant insert any table to Lutsyk; 
grant select any table to Lutsyk; 





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь: (додано 18.04.2018)

SELECT CUST_NAME
FROM Customers,Orders, ORDERITEMS
 WHERE customers.cust_id = orders.cust_id
 AND orders.order_num = orderitems.order_num
AND item_price IN (SELECT MIN(orderitems.item_price) FROM orderitems);

/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:    (додано 18.04.2018)
SELECT     
	CUST_NAME as "client_name"
FROM CUSTOMERS
	WHERE CUST_ID  IN (
                        SELECT CUST_ID  
			FROM ORDERS
            		)
     		and CUST_EMAIL IS NULL;

/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:   (додано 18.04.2018)
                                 
                                 SELECT upper(CUST_NAME) as "customer_name"
FROM CUSTOMERS
WHERE CUSTOMERS.CUST_ID NOT IN (
                         SELECT CUST_ID   
                         FROM ORDERS);


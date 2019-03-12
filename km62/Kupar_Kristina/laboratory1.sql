-- LABORATORY WORK 1
-- BY Kupar_Kristina
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLESPACE "kupar"
DATAFILE 'kupar.dat'
SIZE 20M;

CREATE USER "kupar"
IDENTIFIED BY KUPAR
QUOTA 20M
DEFAULT TABLESPACE "kupar";

GRANT CREATE SESSION TO "kupar";
GRANT CREATE TABLE TO "kupar";
GRANT DROP TABLE TO "kupar";

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент здає роботу викладачу.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE Student
(
  name  CHAR(50) NOT NULL,
  course NUMBER  NULL,
  birthdate DATE NULL,
  id  char(15) NOT NULL
);

CREATE TABLE Teacher
(
  name  char(50)  NOT NULL,
  rank  char(25)  NULL,
  id  char(15)  NOT NULL
);

CREATE TABLE work
(
  work_id  char(15) NOT NULL,
  subject  char (25)  NOT NULL,
  task  char(100)  NOT NULL,
  teacher_id  char(15) NOT NULL
);


CREATE TABLE studentYieldsWork
(
  student_id    char(10)      NOT NULL ,
  work_id    char(10)      NOT NULL  
);


ALTER TABLE teacher ADD CONSTRAINT teach_name_check CHECK(REGEXP_LIKE(name,'[[:alpha:]] [[:space:]]'));
ALTER TABLE student ADD CONSTRAINT st_name_check CHECK(REGEXP_LIKE(name, '[[:alpha:]] [[:space:]]'));
ALTER TABLE student ADD CONSTRAINT courses_check CHECK (course < 7);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);
ALTER TABLE teacher ADD CONSTRAINT PK_teacher PRIMARY KEY (id);
ALTER TABLE work ADD CONSTRAINT PK_work PRIMARY KEY (work_id);
ALTER TABLE studentYieldsWork ADD CONSTRAINT PK_yields PRIMARY KEY (student_id, work_id);

INSERT INTO Student(name, course, birthdate, id)
VALUES('Bogdan', 4, TO_DATE('1997-06-16', 'yyyy-mm-dd'), 'bo450');
INSERT INTO Student(name, course, birthdate, id)
VALUES('Alex', 2, TO_DATE('1999-06-25', 'yyyy-mm-dd'), 'ap328');
INSERT INTO Student(name, course, birthdate, id)
VALUES('Kate', 2, TO_DATE('1998-12-25', 'yyyy-mm-dd'), 'kb670');

INSERT INTO Teacher(name, rank, id)
VALUES('Elena', 'docent', 'et389');
INSERT INTO teacher(name, rank, id)
VALUES('Sergiy', 'sv', 'ss474');
INSERT INTO teacher(name, rank, id)
VALUES('Olga', 'kn', 'op642');

INSERT INTO work(work_id, subject, task, teacher_id)
VALUES('123h', 'bd', '...', 'et389');
INSERT INTO work(work_id, subject, task, teacher_id)
VALUES('123d', 'math', 'aaa', 'ss474');
INSERT INTO work(work_id, subject, task, teacher_id)
VALUES('645f', 'dm', 'bbb', 'km623');

INSERT INTO studentYieldsWork(work_id, student_id)
VALUES('645f', 'ap321');
INSERT INTO studentYieldsWork(work_id, student_id)
VALUES('123d', 'bo456');
INSERT INTO studentYieldsWork(work_id, student_id)
VALUES('123h', 'km903');


  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE TABLE TO "kupar";
GRANT SELECT ANY TABLE TO "kupar";
GRANT ALTER ANY TABLE TO "kupar";






/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:



SELECT DISTINCT CUST_NAME, cust_email FROM customers, ORDERS
  WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID and cust_email is null;
  











/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT DISTINCT upper(CUST_NAME) AS CUSTOMER_NAME FROM customers, ORDERS
  WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID AND orders.order_num NOT IN(SELECT DISTINCT ORDER_NUM FROM orderitems);
  

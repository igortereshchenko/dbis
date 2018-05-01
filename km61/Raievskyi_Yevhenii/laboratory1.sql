CREATE TABLE students
(
    stud_id NUMBER(15) NOT NULL,
    stud_name VARCHAR(50) NOT NULL,
    stud_surname VARCHAR(50) NOT NULL,
    stud_gender VARCHAR(1) NULL
);

ALTER TABLE students
    ADD CONSTRAINT stud_pk PRIMARY KEY (stud_id);

CREATE TABLE operators
(
    operator_id NUMBER(10) NOT NULL,
    operator_name VARCHAR(50) NOT NULL,
    operator_website VARCHAR(50) NULL,
    operator_address VARCHAR(50) NULL
);

ALTER TABLE operators
    ADD CONSTRAINT operator_pk PRIMARY KEY (operator_id);
    
CREATE TABLE numbers
(
    phone_number NUMBER(15, 0) NOT NULL,
    phone_country VARCHAR(50) NOT NULL,
    phone_payment_type VARCHAR(50) NULL
);

ALTER TABLE numbers
    ADD CONSTRAINT numbers_pk PRIMARY KEY (phone_number);
    
CREATE TABLE students_numbers
(
    stud_id_fk NUMBER(15) NOT NULL,
    phone_number_fk NUMBER(15, 0) NOT NULL,
    operator_id_fk NUMBER(10) NOT NULL
);

ALTER TABLE students_numbers
    ADD CONSTRAINT students_numbers_pk PRIMARY KEY (phone_number_fk);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT stud_id_fk FOREIGN KEY (stud_id_fk) REFERENCES students (stud_id);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT phone_number_fk FOREIGN KEY (phone_number_fk) REFERENCES numbers (phone_number);
    
ALTER TABLE students_numbers
    ADD CONSTRAINT operator_id_fk FOREIGN KEY (operator_id_fk) REFERENCES operators (operator_id);
    
INSERT INTO students VALUES (666, 'Eugen', 'R', 'M');
INSERT INTO students VALUES (85612, 'Anna', 'C', 'F');
INSERT INTO students VALUES (50, 'Ortem', 'M', 'M');

ALTER TABLE students ADD CONSTRAINT students_gender_ch CHECK (stud_gender = 'M' OR stud_gender = 'F' OR stud_gender = NULL);

INSERT INTO operators VALUES (1, 'Valw', 'http://valw.com', 'WIawiduhawiudh st.');
INSERT INTO operators VALUES (2, 'Qkfg', NULL, NULL);
INSERT INTO operators VALUES (3, 'Olkaw', NULL, NULL);

INSERT INTO numbers VALUES (380504289133, 'USA', NULL);
INSERT INTO numbers VALUES (380501111111, 'Ukraine', NULL);
INSERT INTO numbers VALUES (380675842368, 'Ethiopia', NULL);
INSERT INTO numbers VALUES (380671212121, 'Ukraine', NULL);
INSERT INTO numbers VALUES (380673333333, 'Ukraine', NULL);
INSERT INTO numbers VALUES (380674444444, 'Ukraine', NULL);

INSERT INTO students_numbers VALUES (666, 380504289133, 1);
INSERT INTO students_numbers VALUES (666, 380501111111, 2);
INSERT INTO students_numbers VALUES (85612, 380675842368, 1);
INSERT INTO students_numbers VALUES (50, 380671212121, 1);
INSERT INTO students_numbers VALUES (50, 380673333333, 3);
INSERT INTO students_numbers VALUES (50, 380674444444, 3);

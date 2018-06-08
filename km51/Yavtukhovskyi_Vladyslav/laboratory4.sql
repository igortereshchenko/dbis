
CREATE OR REPLACE TRIGGER trig_auth1
BEFORE DELETE ON authors
for each row
DECLARE
cursor auth_curs is
SELECT book_id from books_author WHERE books_author.pass_code=:old.pass_code;
auth_temp auth_curs%rowtype;
begin
FOR AUTH_TEMP IN AUTH_CURS LOOP
DELETE FROM book WHERE book.book_id=AUTH_TEMP.book_id;

END LOOP;
DELETE FROM books_author WHERE books_author.pass_code=:old.pass_code;
end;


CREATE OR REPLACE TRIGGER trig_auth2
BEFORE UPDATE ON authors
for each row
DECLARE
count_books number;
BEGIN
SELECT count(*) into count_books from books_author where pass_code=:old.pass_code;
if(count_books>0) then BEGIN
:new.author_first_name:=:old.author_first_name;
END;
END IF;
END;



set serveroutput on;
DECLARE
cursor curs_auth(cname IN authors.author_last_name%type)
is 
SELECT book_id from authors natural join books_author
natural join book
natural join products
WHERE authors.author_last_name=cname;
cuiter curs_auth%rowtype;
bname book.book_name%type;
npages number;
BEGIN
for cuiter in curs_auth('name')  -- there must be author name
loop
SELECT book_name, count(page_number)
INTO bname, npages
FROM books natural join book_has_page_with_rows
WHERE book_id=cuiter.book_id
group by book_name;
dbms_output.put_line(cuiter.book_id || '   ' || bname || '   ' || npages);

END LOOP;

END;



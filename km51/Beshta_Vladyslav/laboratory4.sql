-- LABORATORY WORK 4
-- BY Beshta_Vladyslav

--1)Створити тригер, що при зміні номеру сторінки в 
--таблиці book_page, видаляє таблицю page_row.

CREATE OR REPLACE TRIGGER del_page_row
AFTER UPDATE of PAGE_NUMBER on BOOK_PAGE
FOR EACH ROW
DECLARE
BEGIN  
    delete PAGE_ROW;
END del_page_row;

--2)Створити тригер, при зміні автору книги- змінює 
--колір обкладинки на червоний.

create or replace TRIGGER color_cover
    before UPDATE of book_author,book_id ON BOOK
    FOR EACH ROW
DECLARE
    for_author BOOK.book_author%TYPE;
    FOR_ID BOOK.BOOK_ID%TYPE;
BEGIN  
    FOR_ID:=:new.book_id;
    for_author:=:new.book_author;
    UPDATE cover_book
    SET cover_color = 'Red'
    where book_id=for_id;
END color_cover;

--3)Створити курсор, параметром якого є автор книги,
--що виводить назву книги та кількість сторінок
set serveroutput ON;
DECLARE
    curs_name book.book_name%type;
    curs_count book_page.page_number%type;
    CURSOR book_cursor (BOOK_AUTHOR_FILTER BOOK.BOOK_AUTHOR%type) 
        IS  SELECT BOOK.BOOK_NAME,BOOK_PAGE.PAGE_NUMBER
            FROM BOOK JOIN BOOK_PAGE
            ON BOOK.BOOK_ID=BOOK_PAGE.BOOK_ID
            WHERE BOOK.BOOK_AUTHOR=BOOK_AUTHOR_FILTER;
BEGIN
    OPEN book_cursor ('J.K. Rowling');
LOOP
    FETCH book_cursor into curs_name,curs_count;
        IF (book_cursor %FOUND) THEN
            dbms_output.put_line('Назва книги: ' || curs_name);
            dbms_output.put_line('Кількість сторінок: '|| curs_count);
        ELSE 
            dbms_output.put_line('Книжок даного автора більше немає');
            EXIT;
        END IF;
    END LOOP;
    CLOSE book_cursor;
END;

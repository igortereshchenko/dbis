-- LABORATORY WORK 4
-- BY Kuzina_Anna
------------------------------------------------------------------------
-- при зміні назви книги видаляються всі сторінки
-------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trigg_book AFTER
    UPDATE OF book_name ON books
    FOR EACH ROW
BEGIN
    DELETE FROM books_have_pages
    WHERE
        book_id =:new.book_id; -- в даному випадку немає різниці new чи old так як  id не змінюється 

END;
-------------------------------------------------------------------------
--при додаванні нової книги додається сторінка 
-------------------------------------------------------------------------
INSERT INTO books (
    book_id,
    book_name,
    book__author
) VALUES (
    '11211',
    'NEW_BOOK_NAME',
    'NEW_BOOK__AUTHOR'
);

CREATE OR REPLACE TRIGGER trigg_add AFTER
    INSERT ON books
    FOR EACH ROW
BEGIN
    INSERT INTO pages (
        page_id,
        page_number
    ) VALUES (
        '27',
        '24'
    );

    INSERT INTO pages_have_rows (
        row_id,
        page_id
    ) VALUES (
        '10',
        '27'
    );

    INSERT INTO books_have_pages (
        row_id,
        page_id,
        book_id
    ) VALUES (
        '10',
        '27',
        '11211'
    );

END trigg_add;
-------------------------------------------------------------------------
--використати курсор з параметром = автор
--виводить кількість сторнок, що написав автор  
-------------------------------------------------------------------------
SET SERVEROUTPUT ON

DECLARE
    CURSOR curs_author (
        v_author_name books.book__author%TYPE
    ) IS SELECT
        book__author,
        COUNT(pages.page_id) AS coun_page
         FROM
        pages
        JOIN pages_have_rows ON pages.page_id = pages_have_rows.page_id
        JOIN books_have_pages ON pages_have_rows.page_id = books_have_pages.page_id
                                 AND pages_have_rows.row_id = books_have_pages.row_id
        JOIN books ON books_have_pages.book_id = books.book_id
         WHERE
        books.book__author = v_author_name
         GROUP BY
        book__author;

    v_row   curs_author%rowtype;
BEGIN
    OPEN curs_author('Joanne Rowling');
    LOOP
        FETCH curs_author INTO v_row;
        IF
            ( curs_author%found )
        THEN
        dbms_output.put_line('write '
        ||  v_row.book__author
        || ' '
        || v_row.coun_page
        || ' pages');
        END IF;

        EXIT WHEN curs_author%notfound;
    END LOOP;

    CLOSE curs_author;

END;

-- LABORATORY WORK 4
-- BY Chechel_Dmytrii

CREATE OR REPLACE TRIGGER authorDelete
  INSTEAD OF DELETE ON Authors
DECLARE
  authorsCount Number;
BEGIN
  SELECT count(*) INTO authorsCount FROM Authors;
  IF authorsCount > 1 THEN
    DELETE FROM Authors WHERE id = :new.id;
  END IF;
END authorDelete;

CREATE OR REPLACE TRIGGER booksUpdate
  BEFORE UPDATE ON Authors
BEGIN
  DELETE FROM Books WHERE Books.author_id = :new.id;
END booksUpdate;

CREATE PROCEDURE printAuthorInfo (authorName Author.first_name%TYPE)
  IS
  BEGIN
    FOR record IN (
      SELECT CONCAT(a.first_name, a.last_name) as name, count(DISTINCT book_id) as  bookCount, count (*) as pagesCount
        FROM Authors a
        LEFT JOIN Books b
        LEFT JOIN Pages p
        GROUP BY p.book_id
        WHERE a.first_name = authorName;
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(record.name || ' ' || record.bookCount || ' ' || record.pagesCount);
    END LOOP;
  END printAuthorInfo;



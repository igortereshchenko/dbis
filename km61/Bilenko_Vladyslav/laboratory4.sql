-- LABORATORY WORK 4
-- BY Bilenko_Vladyslav
1. Створити курсор, параметр якого назва книги, який виводк користувачів, які дивилися фільм по книзі.

Declare
Cursor watchers(book_name) as
Select People.name_person
From People NaturalJoin  People_watch_film NaturalJoin. Film NaturalJoin Film_by_book
Where Film_by_book.name_book=book_name

2. Створити тригер, який при створюванні нової книги -- новий фільм по книзі.

create or replace trigger added_book 
after insert on Book
Declare 
Begin
Insert into Film values (new.name_book,Null,0)
Insert into Film_by_book values(0,new.name_book,0,new.name_book,new.author_name)
End added_book;

3. Створити тригер, який при зміні назви фільма, видаляє всі просмотри цього фільму.

Create or replace trigger changed_name 
after update on Film 
Declare
Begin 
  If(new.film_name!=old.film_name) then
   Delete People_watch_film where film_name=new.film_name AND release_year=new.realease_year
EndIf
End changed_name;

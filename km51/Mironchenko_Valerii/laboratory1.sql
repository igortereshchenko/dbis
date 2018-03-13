-- LABORATORY WORK 1
-- BY Mironchenko_Valerii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER valerii IDENTIFIED BY valerii1
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER valerii QUOTA 100M ON USERS;

GRANT "CONNECT" TO valerii;

GRANT CREATE ANY TABLE TO valerii;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE HUMAN(
  human_name VARCHAR2(35) NOT NULL
);
ALTER TABLE HUMAN
  ADD CONSTRAINT human_prk PRIMARY KEY (human_name);
-------------------------------------------------------

CREATE TABLE ACTION(
  action_name VARCHAR2(15) NOT NULL
);
ALTER TABLE  ACTION
  ADD CONSTRAINT action_prk PRIMARY KEY (human_name);  

-------------------------------------------------------
CREATE TABLE SONG_NAME(
  song_name_fk VARCHAR2(30) NOT NULL,
);

ALTER TABLE  SONG_NAME
  ADD CONSTRAINT song_prk PRIMARY KEY (human_name_fk, song_name_fk);  
  
ALTER TABLE  SONG_NAME
  ADD CONSTRAINT song_fk FOREIGN KEY (human_name_fk) REFERENCES HUMAN (human_name);
  
ALTER TABLE  SONG_NAME
  ADD CONSTRAINT song_fk FOREIGN KEY (human_name_fk) REFERENCES SONG (song_name);
  
  

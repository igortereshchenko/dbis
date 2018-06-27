-- LABORATORY WORK 4
-- BY Miliev_Maksym
CREATE or REPLACE TRIGGER delete_news
 BEFORE 
 UPDATE OF fact_date
 ON fb_facts
 BEGIN 
 DELETE FROM fb_news 
 END; 


CREATE or REPLACE TRIGGER news_for_user
before INSERT ON fb_users
DECLARE
new_fact_name facts.fact_name%TYPE, 
new_news_id fb_news.news_id%TYPE
BEGIN 
INSERT INTO user read news
Values(new.user_id, new_fact_name, new_news_id);
END;


  DECLARE
   CURSOR fact_cursor (v_fact_name facts.fact_name%TYPE)
   IS 
   SELECT 
   facts.fact_date,
   user_read_news.user_id
   where fact_name=v_fact_name;

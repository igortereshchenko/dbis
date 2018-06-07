-- LABORATORY WORK 4
-- BY Sielskyi_Yevhenii
/* 1st task */

Create Or Replace Trigger change_classroom_space
    Before update
    Of classroom_space On Classroom 
    For Each Row
Declare
    
Begin
    Update Chair
    Set classroom_number_fk_ch = NULL
    Where classroom_number_fk_ch = :old.classroom_number;
    
    Update Desk
    Set classroom_number_fk_ds = NULL
    Where classroom_number_fk_ds = :old.classroom_number;
    
    Update Blackboard
    Set classroom_number_fk_bb = NULL
    Where classroom_number_fk_bb = :old.classroom_number;
End;

/* 2nd task */

Create Sequence new_blackboard_zip
    Start with 1000000000
    Increment by 1

Create Or Replace Trigger add_default_blackboard 
    After insert
    On Classroom 
    For Each Row
Declare
    
Begin
    Insert into Blackboard (blackboard_zip, classroom_number_fk_bb, blackboard_type, blackboard_color)
    Values (new_blackboard_zip.nextval, :new.classroom_number, 'Default', 'Green');
End;

/* 3rd task */
 
set serveroutput on
Declare
    CURSOR classroom_content_info(subject Classroom.classroom_subject%TYPE) IS
        Select 
            classroom_number,
            classroom_subject as subject,
            desk_zip as zip,
            desk_color as color,
            desk_height as height
        From Classroom Left Join Desk
                On Classroom.classroom_number = Desk.classroom_number_fk_ds
        Where classroom_subject = subject
        
        Union
        
        Select 
            classroom_number,
            classroom_subject as subject,
            chair_zip as zip,
            chair_color as color,
            chair_height as height
        From Classroom Left Join Chair
                On Classroom.classroom_number = Chair.classroom_number_fk_ch
        Where classroom_subject = subject;
    cur_record classroom_content_info%rowtype;
Begin
    If not classroom_content_info%ISOPEN Then
        open classroom_content_info('Chemistry');
    End if;
    Loop 
        Fetch classroom_content_info into cur_record;
        Exit When classroom_content_info%NOTFOUND;
        DBMS_OUTPUT.put_line(cur_record.classroom_number || ' ' || cur_record.subject || ' ' ||
        cur_record.zip || ' ' || cur_record.color || ' ' || cur_record.height);
    End Loop;
    
    close classroom_content_info;
End;

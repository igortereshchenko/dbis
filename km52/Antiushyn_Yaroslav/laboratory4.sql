-- LABORATORY WORK 4
-- BY Antiushyn_Yaroslav
---при изм высоты парты удаляет все стулья которые не подходят под нее

CREATE OR REPLACE TRIGGER task1 AFTER 
UPDATE OF desk_height
ON desk
FOR EACH ROW
DECLARE

BEGIN
UPDATE chair
    SET classroom_chair_fk  = NULL
    WHERE  classroom_chair_fk = :new.classroom_desk_fk
    and chair_height > :new.desk_hight;
End;

---при добавлении новой комнаты добавляет парту и стул

Create Sequence new_desk_id
    Start with 1000000000
    Increment by 1
    
Create Sequence new_chair_id
    Start with 1000000000
    Increment by 1

Create Or Replace Trigger task2
    After insert
    On Classroom 
    For Each Row
Declare
    
Begin
    Insert into desk (desk_id, classroom_desk_fk, desk_material, desk_height, desk_width)
    Values (new_desk_id.nextval, :new.classroom_id, '1', '1', '1');
 
    Insert into chair (chair_id, classroom_chair_fk, chair_material, chair_height, chair_width)
    Values (new_chair_id.nextval, :new.classroom_id, '1', '1', '1');
End;

---при введении материала выводит в консоль инфо про класс в котором есть парта или стул сделанные из этого материала


    Create Or Replace CURSOR task3(dm desk.desk_material%TYPE) 
    IS
    BEGIN
        Select 
            classroom.*,
            chair_id,
             desk_id,
             classroom_chair_fk,
             classroom_desk_fk,
            chair_material,
            desk_material
        From Desk Right Join Classroom
                On Class_id = classroom_desk_fk;
                Left Join Chair
                On Classroom_id = classroom_chair_fk;
        Where desk.desk_matirial = dm or chair.chair_material = dm;
    end task3;

create table Userss 
(
   login                CHAR(15)             not null,
   pass             CHAR(36)             not null,
   picture              BLOB,
   about                CLOB,
   constraint PK_USERSS primary key (login)
);

alter table Userss
  add constraint check_login 
  check (REGEXP_LIKE(login,'([A-Za-z\d]{3,15})')); 
  
alter table Userss
  add constraint check_pass 
  check (REGEXP_LIKE(pass,'([A-Za-z\d]{6,36})')); 

alter table Userss
  add constraint check_about 
  check (REGEXP_LIKE(about,'([\w\s\d])*'));
  
create table Note 
(
   lecture_title        CHAR(70)             not null,
   lecture_author       CHAR(60)             not null,
   lecture_date         DATE                 not null,
   login                CHAR(15)             not null,
   note_number          INTEGER              not null,
   note_date            DATE                 not null,
   constraint PK_NOTE primary key (lecture_title, lecture_author, lecture_date, login, note_number, note_date)
);

alter table Note
  add constraint check_title 
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Note
  add constraint check_author 
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Note
  add constraint check_date 
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Note
  add constraint check_login_note 
  check (REGEXP_LIKE(login,'([A-Za-z\d]{3,15})'));
alter table Note
  add constraint check_note_number 
  check (REGEXP_LIKE(note_number,'(\d+)'));
alter table Note
  add constraint check_note_date 
  check (REGEXP_LIKE(note_date,'((?:\d{2}\.){2}\d{4})'));

alter table Note
   add constraint "FK_NOTE_LECTURE_I_LECTURE" foreign key (lecture_title, lecture_author, lecture_date)
      references Lecture (lecture_title, lecture_author, lecture_date);

alter table Note
   add constraint "FK_NOTE_USERSS_CREA_USER" foreign key (login)
      references Userss (login);

create table Lecture 
(
   lecture_title        CHAR(70)             not null,
   lecture_author       CHAR(60)             not null,
   lecture_date         DATE                 not null,
   constraint PK_LECTURE primary key (lecture_title, lecture_author, lecture_date)
);

alter table Lecture
  add constraint check_lecture_title 
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Lecture
  add constraint check_lecture_author 
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Lecture
  add constraint check_lecture_date 
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));

create table Paragraph 
(
   lecture_title        CHAR(70)             not null,
   lecture_author       CHAR(60)             not null,
   lecture_date         DATE                 not null,
   paragr_num_f         INTEGER              not null,
   copy_start_point     INTEGER              not null,
   copy_finish_point    INTEGER              not null,
   constraint PK_PARAGRAPH primary key (lecture_title, lecture_author, lecture_date, copy_start_point, copy_finish_point)
);
alter table Paragraph
  add constraint check_lecture_title_par 
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Paragraph
  add constraint check_lecture_author_par
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Paragraph
  add constraint check_lecture_date_par
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Paragraph
  add constraint check_par_num
  check (REGEXP_LIKE(paragr_num_f,'(\d+)'));
alter table Paragraph
  add constraint check_start
  check (REGEXP_LIKE(copy_start_point,'(\d+)'));
alter table Paragraph
  add constraint check_finish
  check (REGEXP_LIKE(copy_finish_point,'(\d+)'));

alter table Paragraph
   add constraint "FK_PARAGRAP_LECTURE C_LECTURE" foreign key (lecture_title, lecture_author, lecture_date)
      references Lecture (lecture_title, lecture_author, lecture_date);

create table Paragraph_has_one_or_more_note 
(
   Par_lecture_title    CHAR(70)             not null,
   Par_lecture_author   CHAR(60)             not null,
   Par_lecture_date     DATE                 not null,
   copy_start_point     INTEGER              not null,
   copy_finish_point    INTEGER              not null,
   lecture_title        CHAR(70)             not null,
   lecture_author       CHAR(60)             not null,
   lecture_date         DATE                 not null,
   login                CHAR(15)             not null,
   note_number          INTEGER              not null,
   note_date            DATE                 not null,
   constraint "PK_PARAGRAPH_HAS_ONE_OR_MORE_N" primary key (Par_lecture_title, Par_lecture_author, Par_lecture_date, copy_start_point, copy_finish_point, lecture_title, lecture_author, lecture_date, login, note_number, note_date)
);

alter table Paragraph_has_one_or_more_note
  add constraint check_par_lecture_title_par 
  check (REGEXP_LIKE(Par_lecture_title,'([\w\s\d\.])'));
alter table Paragraph_has_one_or_more_note
  add constraint check_par_lecture_author_par
  check (REGEXP_LIKE(Par_lecture_author,'([\w\s])'));
alter table Paragraph_has_one_or_more_note
  add constraint check_par_lecture_date_par
  check (REGEXP_LIKE(Par_lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Paragraph_has_one_or_more_note
  add constraint check_start_par
  check (REGEXP_LIKE(copy_start_point,'(\d+)'));
alter table Paragraph_has_one_or_more_note
  add constraint check_finish_par
  check (REGEXP_LIKE(copy_finish_point,'(\d+)'));
alter table Paragraph_has_one_or_more_note
  add constraint check_lecture_title_parag
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Paragraph_has_one_or_more_note
  add constraint check_lecture_author_parag
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Paragraph_has_one_or_more_note
  add constraint check_lecture_date_parag
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Paragraph_has_one_or_more_note
  add constraint check_login_parag 
  check (REGEXP_LIKE(login,'([A-Za-z\d]{3,15})'));
alter table Paragraph_has_one_or_more_note
  add constraint check_note_number_parag 
  check (REGEXP_LIKE(note_number,'(\d+)'));
alter table Paragraph_has_one_or_more_note
  add constraint check_note_date_parag
  check (REGEXP_LIKE(note_date,'((?:\d{2}\.){2}\d{4})'));
  
alter table Paragraph_has_one_or_more_note
   add constraint FK_PARAGRAP_PARAGRAPH_PARAGRAP foreign key (Par_lecture_title, Par_lecture_author, Par_lecture_date, copy_start_point, copy_finish_point)
      references Paragraph (lecture_title, lecture_author, lecture_date, copy_start_point, copy_finish_point);

alter table Paragraph_has_one_or_more_note
   add constraint FK_PARAGRAP_PARAGRAPH_NOTE foreign key (lecture_title, lecture_author, lecture_date, login, note_number, note_date)
      references Note (lecture_title, lecture_author, lecture_date, login, note_number, note_date);
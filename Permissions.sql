CREATE LOGIN [admin]
WITH PASSWORD='123';

CREATE LOGIN training_manager
WITH PASSWORD='234';

CREATE LOGIN instructor 
WITH PASSWORD='345';

CREATE LOGIN student 
WITH PASSWORD='456';

CREATE USER [admin]
FOR LOGIN [admin];

CREATE USER training_manager
FOR LOGIN training_manager;

CREATE USER instructor
FOR LOGIN instructor;

CREATE USER student
FOR LOGIN student;


GRANT all 
on Instructor TO [admin] with grant option;

GRANT all ON Course TO training_manager with grant option;
GRANT all ON Exam TO training_manager with grant option;
GRANT all ON Instructor TO training_manager with grant option;
GRANT all ON Instructor_Course TO training_manager with grant option;

GRANT all  ON Course TO instructor; 
GRANT all  ON Exam_Question TO instructor;
GRANT all  ON Question_Answer_MCQ TO instructor;
GRANT all  ON Question_Answer_Text TO instructor;
GRANT all  ON Question_Answer_TF TO instructor;
GRANT all  ON Student_Exam TO instructor;

GRANT select , insert 
ON Question_Bank TO instructor; 

GRANT select , Delete 
ON Student_Course TO instructor; 

GRANT select , insert ON solve TO student
GRANT select , insert ON Student TO student
GRANT select , insert ON Student_Course TO student


--     Case Study 3: Student Management System

--       Scenario:      
-- Create a database to manage students, their courses, and grades.

      Tasks:      
1.       Create the Database:      
   - Name the database `StudentDB`.

2.       Create Tables:      
   -       Students Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `age`: INT, Not Null
     - `email`: VARCHAR(50), Not Null, Unique
   -       Courses Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
   -       Enrollments Table:      
     - `student_id`: INT, Foreign Key References `Students(id)`
     - `course_id`: INT, Foreign Key References `Courses(id)`
     - `grade`: CHAR(1)
     - Primary Key (`student_id`, `course_id`)

3.       Insert Sample Data.
      
4.       Queries:    
  
   - List all students.
   - List all courses.
   - Show the names of students and the courses they are enrolled in.
   - Count the number of students in each course.

Solution:

create database StudentDB;
use StudentDB;

CREATE TABLE Students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade CHAR(1),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

INSERT INTO Students (name, age, email)
VALUES 
('Alice Johnson', 20, 'alice.johnson@example.com'),
('Bob Smith', 22, 'bob.smith@example.com'),
('Charlie Brown', 21, 'charlie.brown@example.com'),
('Diana White', 23, 'diana.white@example.com');

INSERT INTO Courses (name)
VALUES 
('Mathematics'),
('Physics'),
('Computer Science'),
('English');

INSERT INTO Enrollments (student_id, course_id, grade)
VALUES 
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'C'),
(2, 3, 'B'),
(3, 2, 'A'),
(3, 4, 'A'),
(4, 3, 'C');


SELECT * FROM Students;

SELECT * FROM Courses;

SELECT 
    s.name AS StudentName,
    c.name AS CourseName,
    e.grade AS Grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.id
JOIN Courses c ON e.course_id = c.id;

SELECT 
    c.name AS CourseName,
    COUNT(e.student_id) AS StudentCount
FROM Enrollments e
JOIN Courses c ON e.course_id = c.id
GROUP BY c.name;



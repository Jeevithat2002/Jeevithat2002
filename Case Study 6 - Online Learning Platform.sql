-- Case Study 6: Online Learning Platform

--   Scenario:      
-- Design a database for an online learning platform to manage courses, instructors, and student enrollments.

      Tasks:      
1.       Create the Database:      
   - Name the database `LearningDB`.

2.       Create Tables:      
   -       Courses Table:      
   - `id`: INT, Primary Key, Auto Increment
   - `title`: VARCHAR(100), Not Null
   - `description`: TEXT
   -       Instructors Table:      
   - `id`: INT, Primary Key, Auto Increment
   - `name`: VARCHAR(50), Not Null
   - `expertise`: VARCHAR(50), Not Null
   -       Students Table:      
   - `id`: INT, Primary Key, Auto Increment
   - `name`: VARCHAR(50), Not Null
   - `email`: VARCHAR(50), Not Null, Unique
   -       Enrollments Table:      
   - `student_id`: INT, Foreign Key References `Students(id)`
   - `course_id`: INT, Foreign Key References `Courses(id)`
   - `enrollment_date`: DATE, Not Null
   - Primary Key (`student_id`, `course_id`)

3.       Insert Sample Data.      
4.       Queries:      
   - List all courses.
   - List all instructors.
   - Show enrollments with student names and course titles.
   - Count the number of students enrolled in each course.





Solution:

-- create database `database `LearningDB``;
use `LearningDB`;

CREATE TABLE Courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE Instructors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    expertise VARCHAR(50) NOT NULL
);

CREATE TABLE Students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE Enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

INSERT INTO Courses (title, description)
VALUES 
('Introduction to Programming', 'Learn the basics of programming with Python.'),
('Data Science for Beginners', 'Introduction to data science and machine learning concepts.'),
('Web Development 101', 'Learn to build websites using HTML, CSS, and JavaScript.'),
('Digital Marketing', 'Understand the basics of digital marketing strategies and tools.');

INSERT INTO Instructors (name, expertise)
VALUES 
('Dr. Alice Smith', 'Computer Science'),
('Mr. Bob Johnson', 'Data Science'),
('Ms. Clara Lee', 'Web Development'),
('Mr. Daniel Brown', 'Marketing');

INSERT INTO Students (name, email)
VALUES 
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Michael Johnson', 'michael.johnson@example.com'),
('Emily Brown', 'emily.brown@example.com');

INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES 
(1, 1, '2024-11-01'),
(2, 2, '2024-11-03'),
(3, 3, '2024-11-05'),
(4, 4, '2024-11-07'),
(1, 3, '2024-11-02'),
(2, 1, '2024-11-04');

SELECT * FROM Courses;

SELECT * FROM Instructors;

SELECT 
    s.name AS StudentName,
    c.title AS CourseTitle,
    e.enrollment_date AS EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.student_id = s.id
JOIN Courses c ON e.course_id = c.id;

SELECT 
    c.title AS CourseTitle,
    COUNT(e.student_id) AS StudentCount
FROM Enrollments e
JOIN Courses c ON e.course_id = c.id
GROUP BY c.title;

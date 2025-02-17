-- Case Study 1 : Employee Management System

#  Scenario:
-- You have been hired as a database administrator for a new company, and you need to create an Employee Management System to keep track of the employees, their departments, projects they are working on, and their attendance.

  -- Task List:

1.   Create the Database:  
   - Name the database `EmployeeManagement`.

2.   Create Tables:  
   -   Departments Table:  
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
   -   Employees Table:  
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `age`: INT, Not Null
     - `gender`: VARCHAR(10), Not Null
     - `salary`: INT, Not Null, Check Salary > 30000
     - `department_id`: INT, Foreign Key References `Departments(id)`
   -   Projects Table:  
     - `
id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `budget`: INT, Not Null, Check Budget > 10000
   -   Employee_Projects Table:  
     - `employee_id`: INT, Foreign Key References `Employees(id)`
     - `project_id`: INT, Foreign Key References `Projects(id)`
     - Primary Key (`employee_id`, `project_id`)
   -   Attendance Table:  
     - `id`: INT, Primary Key, Auto Increment
     - `id`: INT, Primary Key, Auto Increment
     - `employee_id`: INT, Foreign Key References `Employees(id)`
     - `date`: DATE, Not Null
     - `status`: ENUM('Present', 'Absent', 'On Leave')

3.   Insert Sample Data:  
   - Insert data into `Departments`, `Employees`, `Projects`, `Employee_Projects`, and `Attendance` tables.

4.   Queries:  
   R- Retrieve all employees.
   - Retrieve all employees in the 'IT' department.
   - List all projects with a budget greater than 50000.
   - Show the names of employees and the projects they are working on.
   - Count the number of employees in each department.
   - Find employees with a salary greater than 50000.
   - Get attendance records for a specific employee.

5.   Update Records:  
   - Increase the salary of employees in the 'HR' department by 10%.
   - Change the department of an employee.


6.   Delete Records:  
   - CRemove an employee who has resigned.
   - Delete a project that is completed.ccc

7.   Constraints and Modifications:  
   - Add a unique constraint to the `email` column in `Employees` table.
   - Ensure `age` is always greater than 18.
   - Add a default value 'Unknown' to `gender` if not specified.


Solution:

CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

CREATE TABLE Departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL CHECK (age > 18), -- Age must be greater than 18
    gender VARCHAR(10) NOT NULL DEFAULT 'Unknown', -- Default gender is 'Unknown'
    salary INT NOT NULL CHECK (salary > 30000), -- Salary must be greater than 30,000
    department_id INT NOT NULL,
    email VARCHAR(100) UNIQUE, -- Email must be unique
    FOREIGN KEY (department_id) REFERENCES Departments(id)
);

CREATE TABLE Projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    budget INT NOT NULL CHECK (budget > 10000) -- Budget must be greater than 10,000
);

CREATE TABLE Employee_Projects (
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(id),
    FOREIGN KEY (project_id) REFERENCES Projects(id)
);

CREATE TABLE Attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'On Leave') NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);

INSERT INTO Departments (name)
VALUES ('HR'), ('IT'), ('Finance'), ('Marketing');

INSERT INTO Employees (name, age, gender, salary, department_id, email)
VALUES 
('Alice', 30, 'Female', 45000, 2, 'alice@example.com'),
('Bob', 28, 'Male', 55000, 2, 'bob@example.com'),
('Charlie', 35, 'Male', 60000, 1, 'charlie@example.com'),
('Diana', 32, 'Female', 48000, 3, 'diana@example.com');


INSERT INTO Projects (name, budget)
VALUES 
('Website Development', 60000),
('Mobile App', 75000),
('Data Analysis', 30000);


INSERT INTO Employee_Projects (employee_id, project_id)
VALUES 
(1, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 3);

INSERT INTO Attendance (employee_id, date, status)
VALUES 
(1, '2024-11-01', 'Present'),
(2, '2024-11-01', 'Absent'),
(3, '2024-11-01', 'On Leave'),
(4, '2024-11-01', 'Present');

SELECT * FROM Employees;

SELECT e.name 
FROM Employees e
JOIN Departments d ON e.department_id = d.id
WHERE d.name = 'IT';


SELECT * FROM Projects WHERE budget > 50000;

SELECT e.name AS Employee, p.name AS Project
FROM Employee_Projects ep
JOIN Employees e ON ep.employee_id = e.id
JOIN Projects p ON ep.project_id = p.id;

SELECT d.name AS Department, COUNT(e.id) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON d.id = e.department_id
GROUP BY d.name;

SELECT * FROM Employees WHERE salary > 50000;

SELECT * FROM Attendance WHERE employee_id = 1;

UPDATE Employees
SET salary = salary * 1.1
WHERE department_id = (SELECT id FROM Departments WHERE name = 'HR');

UPDATE Employees
SET department_id = (SELECT id FROM Departments WHERE name = 'Finance')
WHERE id = 1; -- Example: Employee ID 1

DELETE FROM Employees WHERE id = 1; -- Example: Employee ID 1
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`employeemanagement`.`attendance`, CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`))


DELETE FROM Projects WHERE id = 1; -- Example: Project ID 1
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`employeemanagement`.`attendance`, CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`))

ALTER TABLE Employees ADD CONSTRAINT UNIQUE (email);

ALTER TABLE Employees MODIFY age INT NOT NULL CHECK (age > 18);

ALTER TABLE Employees MODIFY gender VARCHAR(10) NOT NULL DEFAULT 'Unknown';


Case Study 5: Hospital Management System

      Scenario:      
Create a database to manage patients, doctors, and appointments in a hospital.

      Tasks:      
1.       Create the Database:      
   - Name the database `HospitalDB`.

2.       Create Tables:      
   -       Patients Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `age`: INT, Not Null
     - `gender`: VARCHAR(10)
     - `contact`: VARCHAR(50)
   -       Doctors Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `specialization`: VARCHAR(50), Not Null
   -       Appointments Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `patient_id`: INT, Foreign Key References `Patients(id)`
     - `doctor_id`: INT, Foreign Key References `Doctors(id)`
     - `appointment_date`: DATE, Not Null
     - `status`: ENUM('Scheduled', 'Completed', 'Cancelled')

3.       Insert Sample Data.      
4.       Queries:      
   - List all patients.
   - List all doctors.
   - Show appointments with patient and doctor names.
   - Count appointments per doctor.


Solution:

create database `HospitalDB`;
use HospitalDB;

CREATE TABLE Patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10),
    contact VARCHAR(50)
);


CREATE TABLE Doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50) NOT NULL
);

CREATE TABLE Appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(id)
);


INSERT INTO Patients (name, age, gender, contact)
VALUES 
('John Doe', 30, 'Male', '123-456-7890'),
('Jane Smith', 25, 'Female', '987-654-3210'),
('Alice Johnson', 40, 'Female', '555-555-5555'),
('Bob Brown', 50, 'Male', '111-111-1111');


INSERT INTO Doctors (name, specialization)
VALUES 
('Dr. Adam White', 'Cardiologist'),
('Dr. Sarah Black', 'Dermatologist'),
('Dr. Michael Green', 'Orthopedic'),
('Dr. Emma Blue', 'Pediatrician');


INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status)
VALUES 
(1, 1, '2024-11-20', 'Scheduled'),
(2, 3, '2024-11-21', 'Completed'),
(3, 2, '2024-11-22', 'Scheduled'),
(4, 4, '2024-11-23', 'Canceled');


SELECT * FROM Patients;

SELECT * FROM Doctors;

SELECT 
    p.name AS PatientName,
    d.name AS DoctorName,
    a.appointment_date AS AppointmentDate,
    a.status AS AppointmentStatus
FROM Appointments a
JOIN Patients p ON a.patient_id = p.id
JOIN Doctors d ON a.doctor_id = d.id;

SELECT 
    d.name AS DoctorName,
    COUNT(a.id) AS TotalAppointments
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.id
GROUP BY d.name;
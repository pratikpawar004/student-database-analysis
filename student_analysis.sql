-- Student Database Analysis Project
-- Author: Pratik Pawar
-- Description: Schema, sample data, and queries for analyzing student performance

-- 1. Drop database if exists and create a new one
DROP DATABASE IF EXISTS student_analysis;
CREATE DATABASE student_analysis;
USE student_analysis;

-- 2. Create tables
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    year INT
);

CREATE TABLE Subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credits INT
);

CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    attended_classes INT,
    total_classes INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- 3. Insert sample data
INSERT INTO Students (name, department, year) VALUES
('Amit Sharma', 'Computer Engg', 2),
('Priya Singh', 'Computer Engg', 2),
('Rahul Verma', 'IT', 3),
('Neha Patil', 'Electronics', 1);

INSERT INTO Subjects (subject_name, credits) VALUES
('Database Systems', 4),
('Data Structures', 3),
('Mathematics', 4);

INSERT INTO Attendance (student_id, subject_id, attended_classes, total_classes) VALUES
(1, 1, 18, 20),
(1, 2, 15, 20),
(2, 1, 20, 20),
(3, 3, 12, 20),
(4, 2, 10, 20);

INSERT INTO Grades (student_id, subject_id, marks, grade) VALUES
(1, 1, 85, 'A'),
(1, 2, 78, 'B'),
(2, 1, 92, 'A'),
(3, 3, 60, 'C'),
(4, 2, 55, 'D');

-- 4. Example Queries for Analysis

-- a) Find average marks per subject
SELECT s.subject_name, AVG(g.marks) AS avg_marks
FROM Grades g
JOIN Subjects s ON g.subject_id = s.subject_id
GROUP BY s.subject_name;

-- b) Attendance percentage per student
SELECT st.name, sub.subject_name,
       (a.attended_classes / a.total_classes) * 100 AS attendance_percentage
FROM Attendance a
JOIN Students st ON a.student_id = st.student_id
JOIN Subjects sub ON a.subject_id = sub.subject_id;

-- c) Students with grade 'A'
SELECT st.name, sub.subject_name, g.grade
FROM Grades g
JOIN Students st ON g.student_id = st.student_id
JOIN Subjects sub ON g.subject_id = sub.subject_id
WHERE g.grade = 'A';

-- d) Create a View for Student Performance (Attendance + Grades)
CREATE OR REPLACE VIEW student_performance AS
SELECT st.name, sub.subject_name,
       g.marks, g.grade,
       (a.attended_classes / a.total_classes) * 100 AS attendance_percentage
FROM Students st
JOIN Grades g ON st.student_id = g.student_id
JOIN Attendance a ON st.student_id = a.student_id AND g.subject_id = a.subject_id
JOIN Subjects sub ON g.subject_id = sub.subject_id;

-- e) Query from View
SELECT * FROM student_performance;

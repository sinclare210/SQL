

-- Create Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Create Courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL
);


CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    numerical_score INT NOT NULL,
    letter_grade CHAR(1) NOT NULL,
    grade_points DECIMAL(3,2) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


INSERT INTO students VALUES
(1, 'Mushin', 'ikeja', 'mushinikeja@email.com'),
(2, 'Linda', 'Johnson', 'lindajohnson@email.com'),
(3, 'Daemon', 'Sinclair', 'daemonsinclair@email.com'),
(4, 'Emila', 'Davis', 'emiladavis@email.com'),
(5, 'David', 'Solomon', 'davidsolomo@email.com'),
(6, 'Lionel', 'Messi', 'lionelmessi@email.com'),
(7, 'James', 'Fuminiyi', 'jamesfuminiyi@email.com'),
(8, 'Mary', 'Grace', 'marygrace@email.com');

INSERT INTO courses VALUES
(101, 'MATH101', 'Calculus I', 4),
(102, 'PHYS101', 'Physics I', 4),
(103, 'CHEM101', 'General Chemistry', 3),
(104, 'ENG101', 'English Composition', 3),
(105, 'HIST101', 'World History', 3),
(106, 'BIOL101', 'Biology I', 4),
(107, 'COMP101', 'Computer Science I', 3);


INSERT INTO enrollments VALUES

(1, 1, 101, 85, 'A', 5.0),
(2, 1, 102, 78, 'A', 5.0),
(3, 1, 103, 92, 'A', 5.0),
(4, 1, 104, 88, 'A', 5.0),
(5, 1, 105, 74, 'A', 5.0),


(6, 2, 101, 82, 'A', 5.0),
(7, 2, 102, 76, 'A', 5.0),
(8, 2, 104, 91, 'A', 5.0),
(9, 2, 105, 79, 'A', 5.0),
(10, 2, 106, 73, 'A', 5.0),


(11, 3, 101, 68, 'B', 4.0),
(12, 3, 103, 65, 'B', 4.0),
(13, 3, 104, 71, 'A', 5.0),
(14, 3, 106, 62, 'B', 4.0),
(15, 3, 107, 58, 'C', 3.0),


(16, 4, 102, 94, 'A', 5.0),
(17, 4, 103, 87, 'A', 5.0),
(18, 4, 105, 83, 'A', 5.0),
(19, 4, 106, 90, 'A', 5.0),
(20, 4, 107, 76, 'A', 5.0),


(21, 5, 101, 52, 'C', 3.0),
(22, 5, 102, 48, 'D', 2.0),
(23, 5, 104, 55, 'C', 3.0),
(24, 5, 105, 59, 'C', 3.0),

-
(25, 6, 101, 77, 'A', 5.0),
(26, 6, 103, 84, 'A', 5.0),
(27, 6, 104, 75, 'A', 5.0),
(28, 6, 106, 69, 'B', 4.0),
(29, 6, 107, 81, 'A', 5.0),


(30, 7, 101, 42, 'E', 1.0),
(31, 7, 102, 38, 'F', 0.0),
(32, 7, 103, 46, 'D', 2.0),
(33, 7, 104, 51, 'C', 3.0),


(34, 8, 101, 70, 'A', 5.0),
(35, 8, 102, 67, 'B', 4.0),
(36, 8, 103, 72, 'A', 5.0),
(37, 8, 105, 64, 'B', 4.0),
(38, 8, 106, 73, 'A', 5.0);


SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(e.enrollment_id) AS total_courses,
    SUM(c.credit_hours * e.grade_points) AS total_grade_points,
    SUM(c.credit_hours) AS total_credit_hours,
    ROUND(
        SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 
        2
    ) AS gpa
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY gpa DESC;

SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    ROUND(
        SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 
        2
    ) AS gpa,
    'First Class' AS class
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING ROUND(
    SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 
    2
) >= 4.5
ORDER BY gpa DESC;

SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    ROUND(
        SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 
        2
    ) AS gpa,
    CASE 
        WHEN ROUND(SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 2) >= 4.5 
            THEN 'First Class'
        WHEN ROUND(SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 2) >= 3.5 
            THEN 'Second Class Upper'
        WHEN ROUND(SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 2) >= 2.5 
            THEN 'Second Class Lower'
        WHEN ROUND(SUM(c.credit_hours * e.grade_points) / SUM(c.credit_hours), 2) >= 2.0 
            THEN 'Third Class'
        ELSE 'Pass/Fail'
    END AS classification
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY gpa DESC;


SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    c.credit_hours,
    e.numerical_score,
    e.letter_grade,
    e.grade_points
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.last_name, s.first_name, c.course_code;


SELECT 
    'Grade Conversion Reference' AS info,
    'A: 70-100 = 5.0 points' AS grade_a,
    'B: 60-69 = 4.0 points' AS grade_b,
    'C: 50-59 = 3.0 points' AS grade_c,
    'D: 45-49 = 2.0 points' AS grade_d,
    'E: 40-44 = 1.0 points' AS grade_e,
    'F: 0-39 = 0.0 points' AS grade_f;
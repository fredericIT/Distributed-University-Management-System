-- Entity Relationships and Constraints
-- Additional MySQL setup for University Management System

USE university_db;

-- 1. Add Additional Constraints and Indexes
ALTER TABLE departments ADD CONSTRAINT chk_department_name_not_empty 
CHECK (department_name IS NOT NULL AND department_name != '');

ALTER TABLE students ADD CONSTRAINT chk_student_name_not_empty 
CHECK (name IS NOT NULL AND name != '');

ALTER TABLE students ADD CONSTRAINT chk_student_email_format 
CHECK (email LIKE '%@%.%');

ALTER TABLE lecturers ADD CONSTRAINT chk_lecturer_name_not_empty 
CHECK (name IS NOT NULL AND name != '');

ALTER TABLE lecturers ADD CONSTRAINT chk_lecturer_email_format 
CHECK (email LIKE '%@%.%');

ALTER TABLE courses ADD CONSTRAINT chk_course_name_not_empty 
CHECK (course_name IS NOT NULL AND course_name != '');

ALTER TABLE courses ADD CONSTRAINT chk_credits_positive 
CHECK (credits > 0);

-- 2. Create Views for Better Data Access
CREATE VIEW v_student_details AS
SELECT 
    s.id,
    s.name AS student_name,
    s.email AS student_email,
    d.department_name,
    d.head_of_department,
    s.created_at AS student_created_at
FROM students s
JOIN departments d ON s.department_id = d.id;

CREATE VIEW v_lecturer_details AS
SELECT 
    l.id,
    l.name AS lecturer_name,
    l.email AS lecturer_email,
    d.department_name,
    d.head_of_department,
    l.created_at AS lecturer_created_at
FROM lecturers l
JOIN departments d ON l.department_id = d.id;

CREATE VIEW v_course_details AS
SELECT 
    c.id,
    c.course_name,
    c.credits,
    d.department_name,
    d.head_of_department,
    c.created_at AS course_created_at
FROM courses c
JOIN departments d ON c.department_id = d.id;

CREATE VIEW v_department_summary AS
SELECT 
    d.id,
    d.department_name,
    d.head_of_department,
    COUNT(DISTINCT s.id) AS student_count,
    COUNT(DISTINCT l.id) AS lecturer_count,
    COUNT(DISTINCT c.id) AS course_count,
    d.created_at
FROM departments d
LEFT JOIN students s ON d.id = s.department_id
LEFT JOIN lecturers l ON d.id = l.department_id
LEFT JOIN courses c ON d.id = c.department_id
GROUP BY d.id, d.department_name, d.head_of_department, d.created_at;

-- 3. Create Stored Procedures for Common Operations
DELIMITER //

-- Procedure to add new student
CREATE PROCEDURE sp_add_student(
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_department_id BIGINT
)
BEGIN
    INSERT INTO students (name, email, department_id)
    VALUES (p_name, p_email, p_department_id);
    SELECT LAST_INSERT_ID() AS student_id;
END //

-- Procedure to add new lecturer
CREATE PROCEDURE sp_add_lecturer(
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_department_id BIGINT
)
BEGIN
    INSERT INTO lecturers (name, email, department_id)
    VALUES (p_name, p_email, p_department_id);
    SELECT LAST_INSERT_ID() AS lecturer_id;
END //

-- Procedure to add new course
CREATE PROCEDURE sp_add_course(
    IN p_course_name VARCHAR(255),
    IN p_credits INT,
    IN p_department_id BIGINT
)
BEGIN
    INSERT INTO courses (course_name, credits, department_id)
    VALUES (p_course_name, p_credits, p_department_id);
    SELECT LAST_INSERT_ID() AS course_id;
END //

-- Procedure to get department statistics
CREATE PROCEDURE sp_get_department_stats()
BEGIN
    SELECT 
        d.department_name,
        d.head_of_department,
        COUNT(DISTINCT s.id) AS student_count,
        COUNT(DISTINCT l.id) AS lecturer_count,
        COUNT(DISTINCT c.id) AS course_count
    FROM departments d
    LEFT JOIN students s ON d.id = s.department_id
    LEFT JOIN lecturers l ON d.id = l.department_id
    LEFT JOIN courses c ON d.id = c.department_id
    GROUP BY d.id, d.department_name, d.head_of_department
    ORDER BY d.department_name;
END //

DELIMITER ;

-- 4. Create Triggers for Audit Logging
DELIMITER //

-- Trigger for departments audit
CREATE TRIGGER tr_departments_insert
AFTER INSERT ON departments
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation, record_id, old_values, new_values, timestamp)
    VALUES ('departments', 'INSERT', NEW.id, NULL, 
            CONCAT('name: ', NEW.department_name, ', head: ', NEW.head_of_department), NOW());
END //

CREATE TRIGGER tr_departments_update
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation, record_id, old_values, new_values, timestamp)
    VALUES ('departments', 'UPDATE', NEW.id, 
            CONCAT('name: ', OLD.department_name, ', head: ', OLD.head_of_department),
            CONCAT('name: ', NEW.department_name, ', head: ', NEW.head_of_department), NOW());
END //

DELIMITER ;

-- 5. Create Audit Log Table
CREATE TABLE IF NOT EXISTS audit_log (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    operation VARCHAR(20) NOT NULL,
    record_id BIGINT,
    old_values TEXT,
    new_values TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_table_operation (table_name, operation),
    INDEX idx_timestamp (timestamp)
);

-- 6. Grant Permissions (if needed)
-- CREATE USER 'university_user'@'localhost' IDENTIFIED BY 'your_password';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON university_db.* TO 'university_user'@'localhost';
-- FLUSH PRIVILEGES;

-- 7. Test Queries
SELECT 'Database setup completed!' AS message;
SELECT COUNT(*) AS total_departments FROM departments;
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_lecturers FROM lecturers;
SELECT COUNT(*) AS total_courses FROM courses;

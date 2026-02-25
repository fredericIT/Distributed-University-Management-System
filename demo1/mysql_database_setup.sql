-- University Management System MySQL Database Setup
-- Execute these commands in MySQL to create the database and tables

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS university_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE university_db;

-- 2. Create Departments Table (Parent Table)
CREATE TABLE departments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL UNIQUE,
    head_of_department VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Create Students Table
CREATE TABLE students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    department_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE,
    INDEX idx_department_id (department_id)
);

-- 4. Create Lecturers Table
CREATE TABLE lecturers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    department_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE,
    INDEX idx_department_id (department_id)
);

-- 5. Create Courses Table
CREATE TABLE courses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT NOT NULL,
    department_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE,
    INDEX idx_department_id (department_id)
);

-- 6. Insert Sample Data (Optional)
-- Departments
INSERT INTO departments (department_name, head_of_department) VALUES 
('ICT', 'NIYOMUGABO Ephlem'),
('MECHANICAL', 'NIYONGIRA Janvier');

-- Students
INSERT INTO students (name, email, department_id) VALUES 
('NTAWUKURIRYAYO frederic', 'ntawukuriryayofrederic817@gmail.com', 1),
('MUTONI GIGI', 'mutonigigi@gmail.com', 2),
('gakuba john', 'johngakuba@gmail.com', 2),
('mahoro dodo', 'dodomahoro67@gmail.com', 2);

-- Lecturers
INSERT INTO lecturers (name, email, department_id) VALUES 
('NISHIMWE Gabriel', 'nigibril1@gmail.com', 1),
('Maherezo Joseph1', 'josephmaherezo87@gmail.com', 2),
('Maherezo joseph', 'maherezojoseph@gmail.com', 1);

-- Courses
INSERT INTO courses (course_name, credits, department_id) VALUES 
('backend using java', 5, 1),
('database development', 8, 2);

-- 7. Show Database Structure
SHOW TABLES;
DESCRIBE departments;
DESCRIBE students;
DESCRIBE lecturers;
DESCRIBE courses;

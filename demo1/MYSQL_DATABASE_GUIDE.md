# MySQL Database Setup for University Management System

## 📋 Database Overview
- **Database Name**: `university_db`
- **Character Set**: `utf8mb4` (supports Unicode)
- **Collation**: `utf8mb4_unicode_ci`

## 🗄️ Entity Tables

### 1. departments
```sql
CREATE TABLE departments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL UNIQUE,
    head_of_department VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```
**Purpose**: Stores university departments
**Relationships**: Parent table for students, lecturers, and courses

### 2. students
```sql
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
```
**Purpose**: Stores student information
**Relationships**: Many-to-One with departments

### 3. lecturers
```sql
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
```
**Purpose**: Stores lecturer information
**Relationships**: Many-to-One with departments

### 4. courses
```sql
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
```
**Purpose**: Stores course information
**Relationships**: Many-to-One with departments

## 🔗 Entity Relationships

```
departments (1) ──── (M) students
departments (1) ──── (M) lecturers  
departments (1) ──── (M) courses
```

## 📊 Database Features

### Constraints
- **Primary Keys**: Auto-increment BIGINT for all tables
- **Foreign Keys**: department_id references departments(id) with CASCADE delete
- **Unique Constraints**: department_name, email fields
- **NOT NULL**: Required fields enforced
- **CHECK Constraints**: Data validation (email format, positive credits)

### Indexes
- **Primary Key Indexes**: Automatic on id columns
- **Foreign Key Indexes**: department_id for performance
- **Unique Indexes**: department_name, email fields

### Audit Features
- **Timestamps**: created_at and updated_at columns
- **Audit Log**: Tracks all INSERT/UPDATE operations
- **Triggers**: Automatic audit logging

### Views
- **v_student_details**: Student information with department
- **v_lecturer_details**: Lecturer information with department
- **v_course_details**: Course information with department
- **v_department_summary**: Department statistics

### Stored Procedures
- **sp_add_student**: Add new student
- **sp_add_lecturer**: Add new lecturer
- **sp_add_course**: Add new course
- **sp_get_department_stats**: Get department statistics

## 🚀 Setup Instructions

### 1. Execute Basic Setup
```bash
mysql -u root -p < mysql_database_setup.sql
```

### 2. Execute Advanced Setup (Optional)
```bash
mysql -u root -p < mysql_advanced_setup.sql
```

### 3. Update Spring Boot Configuration
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/university_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=your_mysql_password
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=update
```

## 📈 Sample Data Included
- **2 Departments**: ICT, MECHANICAL
- **4 Students**: Various students assigned to departments
- **3 Lecturers**: Various lecturers assigned to departments
- **2 Courses**: backend using java, database development

## 🔍 Verification Queries
```sql
-- Check all tables
SHOW TABLES;

-- Check table structures
DESCRIBE departments;
DESCRIBE students;
DESCRIBE lecturers;
DESCRIBE courses;

-- Check data
SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM lecturers;
SELECT * FROM courses;

-- Check relationships
SELECT s.name, d.department_name 
FROM students s JOIN departments d ON s.department_id = d.id;
```

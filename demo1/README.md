# Distributed University Management System

A Spring MVC application for managing university departments, students, lecturers, and courses with JSP views and MySQL database.

## 🛠 Technologies Used

- **Backend**: Spring Boot 3.2.0, Spring MVC, Spring Data JPA
- **Frontend**: JSP with JSTL
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Java Version**: 17

## 📋 Features

### Department Management
- Add, view, update, delete departments
- Fields: id, departmentName, headOfDepartment

### Student Management
- Add, view, update, delete students
- Fields: id, name, email, department (foreign key)

### Lecturer Management
- Add, view, update, delete lecturers
- Fields: id, name, email, department (foreign key)

### Course Management
- Add, view, update, delete courses
- Fields: id, courseName, credits, department (foreign key)

## 🚀 Setup Instructions

### Prerequisites
- Java 17 or higher
- Maven 3.6 or higher

### Database Options

#### Option 1: H2 In-Memory Database (Default - For Testing)
The application comes pre-configured with H2 in-memory database for immediate testing:
- No setup required
- Data is stored in memory and lost on restart
- H2 console available at: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:university_db`
- Username: `sa`
- Password: (empty)

#### Option 2: MySQL Database (For Production)

1. **Install MySQL**
   ```bash
   # Ubuntu/Debian
   sudo apt update && sudo apt install mysql-server
   
   # Start MySQL service
   sudo systemctl start mysql
   sudo systemctl enable mysql
   ```

2. **Create Database**
   ```sql
   CREATE DATABASE university_db;
   ```

3. **Configure Application**
   Edit `src/main/resources/application.properties`:
   ```properties
   # Comment out H2 configuration
   # spring.datasource.url=jdbc:h2:mem:university_db
   
   # Uncomment and update MySQL configuration
   spring.datasource.url=jdbc:mysql://localhost:3306/university_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
   spring.datasource.username=your_mysql_username
   spring.datasource.password=your_mysql_password
   spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
   
   # Update dialect
   spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect
   
   # Change DDL strategy for production
   spring.jpa.hibernate.ddl-auto=update
   ```

4. **Secure MySQL (Optional but Recommended)**
   ```bash
   sudo mysql_secure_installation
   ```

### Running the Application

1. **Build the Project**
   ```bash
   mvn clean install
   ```

2. **Run the Application**
   ```bash
   mvn spring-boot:run
   ```

3. **Access the Application**
   Open your browser and navigate to: `http://localhost:8080`

4. **Access H2 Console** (if using H2)
   Navigate to: `http://localhost:8080/h2-console`

## 🏗️ Project Structure

```
src/
├── main/
│   ├── java/com/university/
│   │   ├── UniversityManagementApplication.java  # Main application class
│   │   ├── controller/                           # MVC Controllers
│   │   │   ├── HomeController.java
│   │   │   ├── DepartmentController.java
│   │   │   ├── StudentController.java
│   │   │   ├── LecturerController.java
│   │   │   └── CourseController.java
│   │   ├── entity/                              # JPA Entities
│   │   │   ├── Department.java
│   │   │   ├── Student.java
│   │   │   ├── Lecturer.java
│   │   │   └── Course.java
│   │   ├── repository/                          # Spring Data JPA Repositories
│   │   │   ├── DepartmentRepository.java
│   │   │   ├── StudentRepository.java
│   │   │   ├── LecturerRepository.java
│   │   │   └── CourseRepository.java
│   │   └── service/                             # Business Logic
│   │       ├── DepartmentService.java
│   │       ├── StudentService.java
│   │       ├── LecturerService.java
│   │       └── CourseService.java
│   ├── resources/
│   │   └── application.properties               # Application configuration
│   └── webapp/
│       └── WEB-INF/
│           └── views/                           # JSP Views
│               ├── index.jsp                     # Home page
│               ├── departments/
│               ├── students/
│               ├── lecturers/
│               └── courses/
└── test/                                        # Test classes
```

## 🌐 Application URLs

- **Home**: `http://localhost:8080/`
- **Departments**: `http://localhost:8080/departments`
- **Students**: `http://localhost:8080/students`
- **Lecturers**: `http://localhost:8080/lecturers`
- **Courses**: `http://localhost:8080/courses`

## 📊 Database Schema

The application automatically creates the following tables:

1. **departments**
   - id (BIGINT, PRIMARY KEY, AUTO_INCREMENT)
   - department_name (VARCHAR, UNIQUE, NOT NULL)
   - head_of_department (VARCHAR)

2. **students**
   - id (BIGINT, PRIMARY KEY, AUTO_INCREMENT)
   - name (VARCHAR, NOT NULL)
   - email (VARCHAR, UNIQUE, NOT NULL)
   - department_id (BIGINT, FOREIGN KEY)

3. **lecturers**
   - id (BIGINT, PRIMARY KEY, AUTO_INCREMENT)
   - name (VARCHAR, NOT NULL)
   - email (VARCHAR, UNIQUE, NOT NULL)
   - department_id (BIGINT, FOREIGN KEY)

4. **courses**
   - id (BIGINT, PRIMARY KEY, AUTO_INCREMENT)
   - course_name (VARCHAR, NOT NULL)
   - credits (INT, NOT NULL)
   - department_id (BIGINT, FOREIGN KEY)

## 🔧 Configuration

### Application Properties
- Database connection settings
- JPA/Hibernate configuration
- JSP view resolver configuration
- Server port configuration

### Maven Dependencies
- Spring Boot Starter Web
- Spring Boot Starter Data JPA
- MySQL Connector
- JSTL for JSP
- Tomcat Embed Jasper
- Spring Boot DevTools

## 🧪 Testing

Run the application tests:
```bash
mvn test
```

## 📝 Notes

- The application uses `hibernate.ddl-auto=update` to automatically create/update database tables
- JSP files are located in `src/main/webapp/WEB-INF/views/`
- All CRUD operations are fully functional for each entity
- Responsive design with modern CSS styling
- Navigation between all modules is available in the header

## 🐛 Troubleshooting

1. **Database Connection Issues**
   - Ensure MySQL is running
   - Check database credentials in `application.properties`
   - Verify the database `university_db` exists

2. **Port Conflicts**
   - Change server port in `application.properties` if 8080 is in use

3. **JSP Compilation Issues**
   - Ensure you're using Java 17 or higher
   - Check Maven dependencies are properly installed

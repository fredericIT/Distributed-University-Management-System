<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 20px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #2980b9;
            text-decoration: none;
            color: white;
        }
        .btn-success {
            background-color: #27ae60;
        }
        .btn-success:hover {
            background-color: #229954;
        }
        .btn-warning {
            background-color: #f39c12;
        }
        .btn-warning:hover {
            background-color: #e67e22;
        }
        .btn-danger {
            background-color: #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .actions {
            display: flex;
            gap: 5px;
        }
        .header-nav {
            background-color: #2c3e50;
            padding: 15px 0;
            margin-bottom: 30px;
            border-radius: 10px;
        }
        .header-nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }
        .header-nav a:hover {
            color: #3498db;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-nav">
            <a href="/">Home</a>
            <a href="/departments">Departments</a>
            <a href="/students">Students</a>
            <a href="/lecturers">Lecturers</a>
            <a href="/courses">Courses</a>
        </div>
        
        <h1>Course Management</h1>
        
        <a href="/courses/new" class="btn btn-success">Add New Course</a>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Course Name</th>
                    <th>Credits</th>
                    <th>Department</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="course" items="${courses}">
                    <tr>
                        <td>${course.id}</td>
                        <td>${course.courseName}</td>
                        <td>${course.credits}</td>
                        <td>${course.department.departmentName}</td>
                        <td>
                            <div class="actions">
                                <a href="/courses/edit/${course.id}" class="btn btn-warning">Edit</a>
                                <a href="/courses/delete/${course.id}" class="btn btn-danger" 
                                   onclick="return confirm('Are you sure you want to delete this course?')">Delete</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${empty courses}">
            <p style="text-align: center; color: #666; margin-top: 30px;">No courses found. Click "Add New Course" to create one.</p>
        </c:if>
    </div>
</body>
</html>

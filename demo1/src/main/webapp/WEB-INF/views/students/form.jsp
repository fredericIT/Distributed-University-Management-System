<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-right: 10px;
            transition: background-color 0.3s;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #2980b9;
            text-decoration: none;
            color: white;
        }
        .btn-secondary {
            background-color: #95a5a6;
        }
        .btn-secondary:hover {
            background-color: #7f8c8d;
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
        
        <h1>
            <c:if test="${student.id == null}">Add New Student</c:if>
            <c:if test="${student.id != null}">Edit Student</c:if>
        </h1>
        
        <c:choose>
            <c:when test="${student.id == null}">
                <form action="/students" method="post">
            </c:when>
            <c:otherwise>
                <form action="/students/update/${student.id}" method="post">
            </c:otherwise>
        </c:choose>
            
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${student.name}" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${student.email}" required>
            </div>
            
            <div class="form-group">
                <label for="department">Department:</label>
                <select id="department" name="department.id" required>
                    <option value="">Select Department</option>
                    <c:forEach var="department" items="${departments}">
                        <option value="${department.id}" 
                                <c:if test="${student.department.id == department.id}">selected</c:if>>
                            ${department.departmentName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <button type="submit" class="btn">
                <c:if test="${student.id == null}">Save Student</c:if>
                <c:if test="${student.id != null}">Update Student</c:if>
            </button>
            <a href="/students" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>

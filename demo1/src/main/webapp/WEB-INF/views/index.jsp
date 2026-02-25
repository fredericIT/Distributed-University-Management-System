<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University Management System</title>
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
            text-align: center;
            margin-bottom: 40px;
        }
        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .nav-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            text-decoration: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .nav-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            text-decoration: none;
            color: white;
        }
        .nav-card h3 {
            margin: 0 0 10px 0;
            font-size: 1.5em;
        }
        .nav-card p {
            margin: 0;
            opacity: 0.9;
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
        
        <h1>Distributed University Management System</h1>
        <p style="text-align: center; color: #666; margin-bottom: 30px;">
            Welcome to the University Management System. Select a module below to manage university data.
        </p>
        
        <div class="nav-grid">
            <a href="/departments" class="nav-card">
                <h3>Departments</h3>
                <p>Manage university departments</p>
            </a>
            <a href="/students" class="nav-card">
                <h3>Students</h3>
                <p>Manage student records</p>
            </a>
            <a href="/lecturers" class="nav-card">
                <h3>Lecturers</h3>
                <p>Manage lecturer information</p>
            </a>
            <a href="/courses" class="nav-card">
                <h3>Courses</h3>
                <p>Manage course catalog</p>
            </a>
        </div>
    </div>
</body>
</html>

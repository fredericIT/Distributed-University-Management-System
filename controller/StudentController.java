package com.university.controller;

import com.university.entity.Student;
import com.university.entity.Department;
import com.university.service.StudentService;
import com.university.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {
    
    @Autowired
    private StudentService studentService;
    
    @Autowired
    private DepartmentService departmentService;
    
    @GetMapping
    public String listStudents(Model model) {
        List<Student> students = studentService.getAllStudents();
        model.addAttribute("students", students);
        return "students/list";
    }
    
    @GetMapping("/new")
    public String createStudentForm(Model model) {
        Student student = new Student();
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("student", student);
        model.addAttribute("departments", departments);
        return "students/form";
    }
    
    @PostMapping
    public String saveStudent(@ModelAttribute Student student) {
        studentService.saveStudent(student);
        return "redirect:/students";
    }
    
    @GetMapping("/edit/{id}")
    public String editStudentForm(@PathVariable Long id, Model model) {
        Student student = studentService.getStudentById(id)
            .orElseThrow(() -> new RuntimeException("Student not found"));
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("student", student);
        model.addAttribute("departments", departments);
        return "students/form";
    }
    
    @PostMapping("/update/{id}")
    public String updateStudent(@PathVariable Long id, @ModelAttribute Student student) {
        studentService.updateStudent(id, student);
        return "redirect:/students";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return "redirect:/students";
    }
}

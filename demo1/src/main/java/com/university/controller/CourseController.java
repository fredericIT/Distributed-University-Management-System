package com.university.controller;

import com.university.entity.Course;
import com.university.entity.Department;
import com.university.service.CourseService;
import com.university.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/courses")
public class CourseController {
    
    @Autowired
    private CourseService courseService;
    
    @Autowired
    private DepartmentService departmentService;
    
    @GetMapping
    public String listCourses(Model model) {
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("courses", courses);
        return "courses/list";
    }
    
    @GetMapping("/new")
    public String createCourseForm(Model model) {
        Course course = new Course();
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("course", course);
        model.addAttribute("departments", departments);
        return "courses/form";
    }
    
    @PostMapping
    public String saveCourse(@ModelAttribute Course course) {
        courseService.saveCourse(course);
        return "redirect:/courses";
    }
    
    @GetMapping("/edit/{id}")
    public String editCourseForm(@PathVariable Long id, Model model) {
        Course course = courseService.getCourseById(id)
            .orElseThrow(() -> new RuntimeException("Course not found"));
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("course", course);
        model.addAttribute("departments", departments);
        return "courses/form";
    }
    
    @PostMapping("/update/{id}")
    public String updateCourse(@PathVariable Long id, @ModelAttribute Course course) {
        courseService.updateCourse(id, course);
        return "redirect:/courses";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable Long id) {
        courseService.deleteCourse(id);
        return "redirect:/courses";
    }
}

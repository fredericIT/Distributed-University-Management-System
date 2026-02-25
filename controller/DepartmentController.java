package com.university.controller;

import com.university.entity.Department;
import com.university.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/departments")
public class DepartmentController {
    
    @Autowired
    private DepartmentService departmentService;
    
    @GetMapping
    public String listDepartments(Model model) {
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("departments", departments);
        return "departments/list";
    }
    
    @GetMapping("/new")
    public String createDepartmentForm(Model model) {
        Department department = new Department();
        model.addAttribute("department", department);
        return "departments/form";
    }
    
    @PostMapping
    public String saveDepartment(@ModelAttribute Department department) {
        departmentService.saveDepartment(department);
        return "redirect:/departments";
    }
    
    @GetMapping("/edit/{id}")
    public String editDepartmentForm(@PathVariable Long id, Model model) {
        Department department = departmentService.getDepartmentById(id)
            .orElseThrow(() -> new RuntimeException("Department not found"));
        model.addAttribute("department", department);
        return "departments/form";
    }
    
    @PostMapping("/update/{id}")
    public String updateDepartment(@PathVariable Long id, @ModelAttribute Department department) {
        departmentService.updateDepartment(id, department);
        return "redirect:/departments";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteDepartment(@PathVariable Long id) {
        departmentService.deleteDepartment(id);
        return "redirect:/departments";
    }
}

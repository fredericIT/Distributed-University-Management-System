package com.university.controller;

import com.university.entity.Lecturer;
import com.university.entity.Department;
import com.university.service.LecturerService;
import com.university.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/lecturers")
public class LecturerController {
    
    @Autowired
    private LecturerService lecturerService;
    
    @Autowired
    private DepartmentService departmentService;
    
    @GetMapping
    public String listLecturers(Model model) {
        List<Lecturer> lecturers = lecturerService.getAllLecturers();
        model.addAttribute("lecturers", lecturers);
        return "lecturers/list";
    }
    
    @GetMapping("/new")
    public String createLecturerForm(Model model) {
        Lecturer lecturer = new Lecturer();
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("lecturer", lecturer);
        model.addAttribute("departments", departments);
        return "lecturers/form";
    }
    
    @PostMapping
    public String saveLecturer(@ModelAttribute Lecturer lecturer) {
        lecturerService.saveLecturer(lecturer);
        return "redirect:/lecturers";
    }
    
    @GetMapping("/edit/{id}")
    public String editLecturerForm(@PathVariable Long id, Model model) {
        Lecturer lecturer = lecturerService.getLecturerById(id)
            .orElseThrow(() -> new RuntimeException("Lecturer not found"));
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("lecturer", lecturer);
        model.addAttribute("departments", departments);
        return "lecturers/form";
    }
    
    @PostMapping("/update/{id}")
    public String updateLecturer(@PathVariable Long id, @ModelAttribute Lecturer lecturer) {
        lecturerService.updateLecturer(id, lecturer);
        return "redirect:/lecturers";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteLecturer(@PathVariable Long id) {
        lecturerService.deleteLecturer(id);
        return "redirect:/lecturers";
    }
}

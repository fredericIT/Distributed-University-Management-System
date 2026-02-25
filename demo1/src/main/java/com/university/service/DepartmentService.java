package com.university.service;

import com.university.entity.Department;
import com.university.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DepartmentService {
    
    @Autowired
    private DepartmentRepository departmentRepository;
    
    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }
    
    public Optional<Department> getDepartmentById(Long id) {
        return departmentRepository.findById(id);
    }
    
    public Department saveDepartment(Department department) {
        return departmentRepository.save(department);
    }
    
    public Department updateDepartment(Long id, Department departmentDetails) {
        Department department = departmentRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Department not found with id: " + id));
        
        department.setDepartmentName(departmentDetails.getDepartmentName());
        department.setHeadOfDepartment(departmentDetails.getHeadOfDepartment());
        
        return departmentRepository.save(department);
    }
    
    public void deleteDepartment(Long id) {
        departmentRepository.deleteById(id);
    }
}

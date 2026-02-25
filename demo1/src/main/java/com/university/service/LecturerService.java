package com.university.service;

import com.university.entity.Lecturer;
import com.university.repository.LecturerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class LecturerService {
    
    @Autowired
    private LecturerRepository lecturerRepository;
    
    public List<Lecturer> getAllLecturers() {
        return lecturerRepository.findAll();
    }
    
    public Optional<Lecturer> getLecturerById(Long id) {
        return lecturerRepository.findById(id);
    }
    
    public Lecturer saveLecturer(Lecturer lecturer) {
        return lecturerRepository.save(lecturer);
    }
    
    public Lecturer updateLecturer(Long id, Lecturer lecturerDetails) {
        Lecturer lecturer = lecturerRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Lecturer not found with id: " + id));
        
        lecturer.setName(lecturerDetails.getName());
        lecturer.setEmail(lecturerDetails.getEmail());
        lecturer.setDepartment(lecturerDetails.getDepartment());
        
        return lecturerRepository.save(lecturer);
    }
    
    public void deleteLecturer(Long id) {
        lecturerRepository.deleteById(id);
    }
}

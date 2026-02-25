package com.university.service;

import com.university.entity.Course;
import com.university.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CourseService {
    
    @Autowired
    private CourseRepository courseRepository;
    
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }
    
    public Optional<Course> getCourseById(Long id) {
        return courseRepository.findById(id);
    }
    
    public Course saveCourse(Course course) {
        return courseRepository.save(course);
    }
    
    public Course updateCourse(Long id, Course courseDetails) {
        Course course = courseRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Course not found with id: " + id));
        
        course.setCourseName(courseDetails.getCourseName());
        course.setCredits(courseDetails.getCredits());
        course.setDepartment(courseDetails.getDepartment());
        
        return courseRepository.save(course);
    }
    
    public void deleteCourse(Long id) {
        courseRepository.deleteById(id);
    }
}

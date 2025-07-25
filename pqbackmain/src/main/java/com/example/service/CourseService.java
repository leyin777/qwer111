package com.example.service;

import com.example.entity.Course;
import com.example.mapper.CourseMapper;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;
import java.util.List;

@Service
public class CourseService {
    @Resource
    private CourseMapper courseMapper;

    public List<Course> getAllCourses() {
        return courseMapper.selectList(null);
    }

    public boolean saveCourse(Course course) {
        return courseMapper.insert(course) > 0;
    }

    public Course getById(Long id) {
        return courseMapper.selectById(id);
    }

    public boolean removeById(Long id) {
        return courseMapper.deleteById(id) > 0;
    }
}

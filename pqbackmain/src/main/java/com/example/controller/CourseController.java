package com.example.controller;

import com.example.entity.Course;
import com.example.service.CourseService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
public class CourseController {
    @Resource
    private CourseService courseService;

    @GetMapping("/courses")
    public List<Course> getAllCourses() {
        return courseService.getAllCourses();
    }

    @PostMapping("/courses")
    public Map<String, Object> addCourse(@RequestBody Course course) {
        Map<String, Object> result = new HashMap<>();
        boolean success = courseService.saveCourse(course);
        if (success) {
            result.put("code", 0);
            result.put("msg", "添加成功");
        } else {
            result.put("code", 1);
            result.put("msg", "添加失败");
        }
        return result;
    }

    @DeleteMapping("/courses/{id}")
    public Map<String, Object> deleteCourse(@PathVariable Long id, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        String loginName = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        // 只有演讲者可以删除
        if (!"speaker".equals(role)) {
            result.put("code", 1);
            result.put("msg", "只有演讲者可以删除课程");
            return result;
        }

        // 查询课程
        Course course = courseService.getById(id);
        if (course == null) {
            result.put("code", 1);
            result.put("msg", "课程不存在");
            return result;
        }
        if (!loginName.equals(course.getSpeakername())) {
            result.put("code", 1);
            result.put("msg", "只能删除自己的课程");
            return result;
        }

        boolean success = courseService.removeById(id);
        if (success) {
            result.put("code", 0);
            result.put("msg", "删除成功");
        } else {
            result.put("code", 1);
            result.put("msg", "删除失败");
        }
        return result;
    }
}
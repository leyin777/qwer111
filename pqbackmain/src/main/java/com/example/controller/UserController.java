package com.example.controller;

import com.example.entity.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

//import jakarta.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> params, HttpSession session) {
        String username = params.get("username");
        String password = params.get("password");
        String role = params.get("role");

        Map<String, Object> result = new HashMap<>();
        User user = userService.findByUsernameAndPassword(username, password);

        if (user != null && role.equals(user.getRole())) {
            // 登录成功，保存用户名和角色到 session
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            result.put("code", 0);
            // 返回 userId
            result.put("data", Map.of("userId", user.getId(), "role", user.getRole()));
            result.put("msg", "登录成功");
        } else {
            result.put("code", 1);
            result.put("msg", "用户名或密码错误，或身份不符");
        }
        return result;
    }

    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody Map<String, String> params) {
        String username = params.get("username");
        String password = params.get("password");
        String email = params.get("email");
        String role = params.get("role");

        Map<String, Object> result = new HashMap<>();

        // 校验用户名是否已存在
        User existingUser = userService.findByUsername(username);
        if (existingUser != null) {
            result.put("success", false);
            result.put("message", "用户名已存在");
            return result;
        }

        // 创建新用户
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setRole(role);

        userService.saveUser(user);

        result.put("success", true);
        result.put("message", "注册成功");
        return result;
    }
}
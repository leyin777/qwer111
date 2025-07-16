package com.example.controller;

import com.example.entity.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

//import jakarta.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
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
            result.put("data", Map.of("role", user.getRole()));
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
        String role = params.get("role");
        String email = params.get("email"); // 新增

        Map<String, Object> result = new HashMap<>();
        // 检查用户名是否已存在
        User existUser = userService.findByUsername(username);
        if (existUser != null) {
            result.put("code", 1);
            result.put("msg", "用户名已存在");
            return result;
        }
        // 创建新用户
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);
        user.setEmail(email); // 新增
        boolean success = userService.saveUser(user);
        if (success) {
            result.put("code", 0);
            result.put("msg", "注册成功");
        } else {
            result.put("code", 1);
            result.put("msg", "注册失败");
        }
        return result;
    }
}
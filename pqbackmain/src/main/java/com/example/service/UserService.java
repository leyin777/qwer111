package com.example.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.User;
import com.example.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//import jakarta.annotation.Resource;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public User findByUsernameAndPassword(String username, String password) {
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username)
                .eq("password", password);
        return userMapper.selectOne(wrapper);
    }

    public boolean register(User user) {
        // 检查用户名是否已存在
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", user.getUsername());
        User exist = userMapper.selectOne(wrapper);
        if (exist != null) {
            return false;
        }
        return userMapper.insert(user) > 0;
    }
}
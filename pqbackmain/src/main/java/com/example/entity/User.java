package com.example.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
@TableName("user")
public class User {
    @TableId(type = IdType.AUTO)//ALTER TABLE user AUTO_INCREMENT = 0;
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String role;
}
package com.example.entity;

import java.util.Date;

public class Comment {
    private Integer id;
    private String content;
    private String username;
    private Integer courseId;
    private Date createTime;

    public Comment() {}

    public Comment(String content, String username, Integer courseId) {
        this.content = content;
        this.username = username;
        this.courseId = courseId;
        this.createTime = new Date();
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
} 
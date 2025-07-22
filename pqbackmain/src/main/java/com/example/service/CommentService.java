package com.example.service;

import com.example.entity.Comment;
import com.example.mapper.CommentMapper;
import com.example.mapper.UserMapper;
import com.example.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    
    @Autowired
    private CommentMapper commentMapper;
    
    @Autowired
    private UserMapper userMapper;
    
    /**
     * 根据课程ID获取所有评论
     */
    public List<Comment> getCommentsByCourseId(Integer courseId) {
        List<Comment> comments = commentMapper.getCommentsByCourseId(courseId);
        for (Comment comment : comments) {
            if (comment.getUsername() != null) {
                User user = userMapper.selectOne(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<User>().eq("username", comment.getUsername()));
                if (user != null) {
                    comment.setRole(user.getRole());
                } else {
                    comment.setRole("audience"); // 默认角色
                }
            } else {
                comment.setRole("audience");
            }
        }
        return comments;
    }
    
    /**
     * 添加新评论
     */
    public boolean addComment(Comment comment) {
        return commentMapper.insertComment(comment) > 0;
    }
    
    /**
     * 删除评论
     */
    public boolean deleteComment(Integer id) {
        return commentMapper.deleteCommentById(id) > 0;
    }
    
    /**
     * 根据课程ID删除所有评论
     */
    public boolean deleteCommentsByCourseId(Integer courseId) {
        return commentMapper.deleteCommentsByCourseId(courseId) > 0;
    }
} 
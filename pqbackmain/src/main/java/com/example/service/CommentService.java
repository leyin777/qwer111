package com.example.service;

import com.example.entity.Comment;
import com.example.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    
    @Autowired
    private CommentMapper commentMapper;
    
    /**
     * 根据课程ID获取所有评论
     */
    public List<Comment> getCommentsByCourseId(Integer courseId) {
        return commentMapper.getCommentsByCourseId(courseId);
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
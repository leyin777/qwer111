package com.example.mapper;

import com.example.entity.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentMapper {
    
    // 根据课程ID获取所有评论
    List<Comment> getCommentsByCourseId(@Param("courseId") Integer courseId);
    
    // 插入新评论
    int insertComment(Comment comment);
    
    // 根据ID删除评论
    int deleteCommentById(@Param("id") Integer id);
    
    // 根据课程ID删除所有评论
    int deleteCommentsByCourseId(@Param("courseId") Integer courseId);
} 
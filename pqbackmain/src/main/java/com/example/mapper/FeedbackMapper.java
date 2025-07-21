package com.example.mapper;

import com.example.entity.Feedback;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface FeedbackMapper {
    
    // 插入反馈记录
    int insertFeedback(Feedback feedback);
    
    // 根据qid获取反馈统计
    Map<String, Object> getFeedbackStats(@Param("qid") Integer qid);
    
    // 根据qid获取所有评论
    List<Feedback> getCommentsByQid(@Param("qid") Integer qid);
    
    // 检查用户是否已经提交过反馈
    Feedback getFeedbackByUserAndQid(@Param("uid") Integer uid, @Param("qid") Integer qid);
    
    // 更新反馈记录
    int updateFeedback(Feedback feedback);
} 
package com.example.service;

import com.example.entity.Feedback;
import com.example.mapper.FeedbackMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FeedbackService {
    
    @Autowired
    private FeedbackMapper feedbackMapper;
    
    /**
     * 提交反馈
     */
    public boolean submitFeedback(Feedback feedback) {
        // 检查用户是否已经提交过反馈
        Feedback existingFeedback = feedbackMapper.getFeedbackByUserAndQid(feedback.getUid(), feedback.getQid());
        
        if (existingFeedback != null) {
            // 如果已存在，则更新
            feedback.setId(existingFeedback.getId());
            return feedbackMapper.updateFeedback(feedback) > 0;
        } else {
            // 如果不存在，则插入新记录
            return feedbackMapper.insertFeedback(feedback) > 0;
        }
    }
    
    /**
     * 获取反馈统计
     */
    public Map<String, Object> getFeedbackStats(Integer qid) {
        Map<String, Object> stats = feedbackMapper.getFeedbackStats(qid);
        
        // 处理null值，确保返回0而不是null
        if (stats == null) {
            stats = new HashMap<>();
        }
        
        stats.put("tooFastCount", stats.get("tooFastCount") != null ? stats.get("tooFastCount") : 0);
        stats.put("tooSlowCount", stats.get("tooSlowCount") != null ? stats.get("tooSlowCount") : 0);
        stats.put("boringCount", stats.get("boringCount") != null ? stats.get("boringCount") : 0);
        stats.put("badQuestionCount", stats.get("badQuestionCount") != null ? stats.get("badQuestionCount") : 0);
        stats.put("totalFeedbackCount", stats.get("totalFeedbackCount") != null ? stats.get("totalFeedbackCount") : 0);
        
        return stats;
    }
    
    /**
     * 获取评论列表
     */
    public List<Feedback> getComments(Integer qid) {
        return feedbackMapper.getCommentsByQid(qid);
    }
    
    /**
     * 检查用户是否已提交反馈
     */
    public boolean hasUserSubmittedFeedback(Integer uid, Integer qid) {
        return feedbackMapper.getFeedbackByUserAndQid(uid, qid) != null;
    }
    
    /**
     * 获取用户的反馈记录
     */
    public Feedback getUserFeedback(Integer uid, Integer qid) {
        return feedbackMapper.getFeedbackByUserAndQid(uid, qid);
    }
} 
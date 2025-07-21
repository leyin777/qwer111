package com.example.controller;

import com.example.entity.Feedback;
import com.example.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class FeedbackController {
    
    @Autowired
    private FeedbackService feedbackService;
    
    /**
     * 测试接口 - 验证控制器是否被正确加载
     * GET /api/feedback/test
     */
    @GetMapping("/feedback/test")
    public Map<String, Object> test() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "FeedbackController 已正确加载");
        result.put("timestamp", System.currentTimeMillis());
        result.put("availableEndpoints", new String[]{
            "GET /api/feedback/test",
            "POST /api/feedback/submit",
            "GET /api/feedback/stats?qid={qid}",
            "GET /api/feedback/comments?qid={qid}",
            "GET /api/feedback/check?uid={uid}&qid={qid}"
        });
        return result;
    }
    
    /**
     * 提交反馈
     * POST /api/feedback/submit
     */
    @PostMapping("/feedback/submit")
    public Map<String, Object> submitFeedback(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (request.get("qid") == null || request.get("uid") == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：qid 或 uid");
                return result;
            }
            
            Integer qid = Integer.valueOf(request.get("qid").toString());
            Integer uid = Integer.valueOf(request.get("uid").toString());
            
            // 创建反馈对象
            Feedback feedback = new Feedback();
            feedback.setQid(qid);
            feedback.setUid(uid);
            
            // 设置反馈选项（0或1）
            feedback.setTooFast(getIntValue(request.get("tooFast"), 0));
            feedback.setTooSlow(getIntValue(request.get("tooSlow"), 0));
            feedback.setBoring(getIntValue(request.get("boring"), 0));
            feedback.setBadQuestion(getIntValue(request.get("badQuestion"), 0));
            
            // 设置评论
            String comment = request.get("comment") != null ? request.get("comment").toString() : "";
            feedback.setComment(comment);
            
            // 提交反馈
            boolean success = feedbackService.submitFeedback(feedback);
            
            if (success) {
                result.put("code", 0);
                result.put("msg", "反馈提交成功");
            } else {
                result.put("code", 1);
                result.put("msg", "反馈提交失败");
            }
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "提交反馈时发生错误：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取反馈统计
     * GET /api/feedback/stats?qid={qid}
     */
    @GetMapping("/feedback/stats")
    public Map<String, Object> getFeedbackStats(@RequestParam Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Map<String, Object> stats = feedbackService.getFeedbackStats(qid);
            result.put("code", 0);
            result.put("data", stats);
            result.put("msg", "获取统计成功");
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "获取统计失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取评论列表
     * GET /api/feedback/comments?qid={qid}
     */
    @GetMapping("/feedback/comments")
    public Map<String, Object> getComments(@RequestParam Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            List<Feedback> comments = feedbackService.getComments(qid);
            result.put("code", 0);
            result.put("data", comments);
            result.put("msg", "获取评论成功");
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "获取评论失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 检查用户是否已提交反馈
     * GET /api/feedback/check?uid={uid}&qid={qid}
     */
    @GetMapping("/feedback/check")
    public Map<String, Object> checkUserFeedback(@RequestParam Integer uid, @RequestParam Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean hasSubmitted = feedbackService.hasUserSubmittedFeedback(uid, qid);
            Feedback userFeedback = null;
            
            if (hasSubmitted) {
                userFeedback = feedbackService.getUserFeedback(uid, qid);
            }
            
            result.put("code", 0);
            result.put("hasSubmitted", hasSubmitted);
            result.put("userFeedback", userFeedback);
            result.put("msg", "检查完成");
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "检查失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 辅助方法：安全地获取整数值
     */
    private int getIntValue(Object value, int defaultValue) {
        if (value == null) {
            return defaultValue;
        }
        
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        
        if (value instanceof String) {
            try {
                return Integer.parseInt((String) value);
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        
        return defaultValue;
    }
} 
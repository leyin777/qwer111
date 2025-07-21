package com.example.controller;

import com.example.entity.Question;
import com.example.entity.AnswerRecord;
import com.example.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class QuestionController {
    @Autowired
    private QuestionService questionService;

    // 获取一组题目
    @GetMapping("/question/list")
    public List<Question> getQuestions(@RequestParam Long qid) {
        return questionService.getQuestionsByQid(qid);
    }

    // 提交单题答案
    @PostMapping("/question/answer")
    public Map<String, Object> submitAnswer(@RequestParam(required = false) Long userId,
                                            @RequestBody Map<String, Object> body) {
        Map<String, Object> result = new HashMap<>();
        
        
        // 参数校验
        if (userId == null && body.get("userId") != null) {
            userId = Long.valueOf(body.get("userId").toString());
        }
        if (userId == null || body.get("questionId") == null || body.get("userAnswerIndex") == null || body.get("correct") == null) {
            result.put("code", 1);
            result.put("msg", "参数缺失，请检查 userId、questionId、userAnswerIndex、correct 是否都已传递！");
            return result;
        }
        // 构造 AnswerRecord
        Long questionId = Long.valueOf(body.get("questionId").toString());
        int userAnswerIndex = Integer.parseInt(body.get("userAnswerIndex").toString());
        int correct = 0;
        Object correctObj = body.get("correct");
        if (correctObj instanceof Number) {
            correct = ((Number) correctObj).intValue();
        } else if (correctObj instanceof String) {
            correct = "1".equals(correctObj) || "true".equalsIgnoreCase((String) correctObj) ? 1 : 0;
        }
        // 以 questionId 作为 qid
        Long qid = questionId;
        
        // 新增：检查答题时间限制
        if (!questionService.isWithinAnswerTimeLimit(questionId)) {
            result.put("code", 1);
            result.put("msg", "答题时间已过期，只能在课程创建后2小时内答题");
            return result;
        }
        
        AnswerRecord record = new AnswerRecord(questionId, userAnswerIndex, correct);
        questionService.saveAnswerRecord(userId, qid, record);
        questionService.updateQuestionAccuracy(record.getQuestionId());
        
        result.put("code", 0);
        result.put("correct", correct);
        result.put("msg", "答题记录已保存");
        return result;
    }

    // 获取统计信息
    @GetMapping("/question/stat")
    public Map<String, Object> getStat(@RequestParam Long userId, @RequestParam Long qid) {
        int correct = questionService.countCorrectAnswers(userId, qid);
        int total = questionService.countTotalAnswers(userId, qid);
        Map<String, Object> stat = new HashMap<>();
        stat.put("correct", correct);
        stat.put("total", total);
        return stat;
    }
    
    // 临时添加反馈统计接口
    @GetMapping("/feedback-stats")
    public Map<String, Object> getFeedbackStats(@RequestParam Integer qid) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "临时反馈统计接口");
        result.put("qid", qid);
        result.put("data", Map.of(
            "tooFastCount", 0,
            "tooSlowCount", 0,
            "boringCount", 0,
            "badQuestionCount", 0,
            "totalFeedbackCount", 0
        ));
        return result;
    }
    
    // 临时添加重新计算排名接口
    @PostMapping("/rank-recalculate")
    public Map<String, Object> recalculateRank(@RequestParam(required = false) Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (qid == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：qid");
                return result;
            }
            
            result.put("code", 0);
            result.put("msg", "临时重新计算排名接口");
            result.put("qid", qid);
            result.put("note", "请使用 /api/rank/recalculate 接口");
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "重新计算排名时发生错误：" + e.getMessage());
        }
        
        return result;
    }
} 
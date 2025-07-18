package com.example.controller;

import com.example.entity.Question;
import com.example.entity.AnswerRecord;
import com.example.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/question")
public class QuestionController {
    @Autowired
    private QuestionService questionService;

    // 获取一组题目
    @GetMapping("/list")
    public List<Question> getQuestions(@RequestParam Long qid) {
        return questionService.getQuestionsByQid(qid);
    }

    // 提交单题答案
    @PostMapping("/answer")
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
        AnswerRecord record = new AnswerRecord(questionId, userAnswerIndex, correct);
        questionService.saveAnswerRecord(userId, qid, record);
        questionService.updateQuestionAccuracy(record.getQuestionId());
        result.put("code", 0);
        result.put("correct", correct);
        return result;
    }

    // 获取统计信息
    @GetMapping("/stat")
    public Map<String, Object> getStat(@RequestParam Long userId, @RequestParam Long qid) {
        int correct = questionService.countCorrectAnswers(userId, qid);
        int total = questionService.countTotalAnswers(userId, qid);
        Map<String, Object> stat = new HashMap<>();
        stat.put("correct", correct);
        stat.put("total", total);
        return stat;
    }
} 
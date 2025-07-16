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
    public Map<String, Object> submitAnswer(@RequestParam Long userId, @RequestParam Long qid, @RequestBody AnswerRecord record) {
        questionService.saveAnswerRecord(userId, qid, record);
        Map<String, Object> result = new HashMap<>();
        result.put("correct", record.isCorrect());
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
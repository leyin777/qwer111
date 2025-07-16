package com.example.service;

import com.example.entity.Question;
import com.example.entity.AnswerRecord;
import com.example.mapper.QuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class QuestionService {
    @Autowired
    private QuestionMapper questionMapper;

    public List<Question> getQuestionsByQid(Long qid) {
        return questionMapper.getQuestionsByQid(qid);
    }

    public void saveAnswerRecord(Long userId, Long qid, AnswerRecord record) {
        questionMapper.saveAnswerRecord(userId, qid, record);
    }

    public int countCorrectAnswers(Long userId, Long qid) {
        return questionMapper.countCorrectAnswers(userId, qid);
    }

    public int countTotalAnswers(Long userId, Long qid) {
        return questionMapper.countTotalAnswers(userId, qid);
    }
} 
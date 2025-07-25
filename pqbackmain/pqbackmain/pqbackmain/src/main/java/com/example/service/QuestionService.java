package com.example.service;

import com.example.entity.Question;
import com.example.entity.AnswerRecord;
import com.example.mapper.QuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Date;

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

    public void updateQuestionAccuracy(Long questionId) {
        int total = questionMapper.countTotalByQuestionId(questionId);
        int correct = questionMapper.countCorrectByQuestionId(questionId);
        double accuracy = total == 0 ? 0 : (double) correct / total;
        questionMapper.updateAccuracy(accuracy, questionId);
    }

    public boolean isWithinAnswerTimeLimit(Long questionId) {
        Date courseCreateTime = questionMapper.getCourseCreateTimeByQuestionId(questionId);
        if (courseCreateTime == null) {
            return false;
        }
        
        long currentTime = System.currentTimeMillis();
        long createTime = courseCreateTime.getTime();
        long timeDiff = currentTime - createTime;
        long twoHoursInMillis = 2 * 60 * 60 * 1000;
        
        return timeDiff <= twoHoursInMillis;
    }
} 
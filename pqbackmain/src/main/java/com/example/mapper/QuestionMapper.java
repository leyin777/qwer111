package com.example.mapper;

import com.example.entity.Question;
import com.example.entity.AnswerRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Date;

@Mapper
public interface QuestionMapper {
    // 根据qid获取一组题目
    List<Question> getQuestionsByQid(@Param("qid") Long qid);

    // 保存用户答题记录
    void saveAnswerRecord(@Param("userId") Long userId, @Param("qid") Long qid, @Param("record") AnswerRecord record);

    // 获取某用户某题组的答题统计
    int countCorrectAnswers(@Param("userId") Long userId, @Param("qid") Long qid);
    int countTotalAnswers(@Param("userId") Long userId, @Param("qid") Long qid);
    int countTotalByQuestionId(@Param("questionId") Long questionId);
    int countCorrectByQuestionId(@Param("questionId") Long questionId);
    void updateAccuracy(@Param("accuracy") double accuracy, @Param("questionId") Long questionId);
    Date getCourseCreateTimeByQuestionId(@Param("questionId") Long questionId);
} 
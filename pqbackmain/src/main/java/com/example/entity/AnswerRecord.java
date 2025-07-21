package com.example.entity;

public class AnswerRecord {
    private Long questionId;
    private int userAnswerIndex;
    private int correct; // 0/1

    public AnswerRecord() {}

    public AnswerRecord(Long questionId, int userAnswerIndex, int correct) {
        this.questionId = questionId;
        this.userAnswerIndex = userAnswerIndex;
        this.correct = correct;
    }

    public Long getQuestionId() { return questionId; }
    public void setQuestionId(Long questionId) { this.questionId = questionId; }
    public int getUserAnswerIndex() { return userAnswerIndex; }
    public void setUserAnswerIndex(int userAnswerIndex) { this.userAnswerIndex = userAnswerIndex; }
    public int getCorrect() { return correct; }
    public void setCorrect(int correct) { this.correct = correct; }
} 
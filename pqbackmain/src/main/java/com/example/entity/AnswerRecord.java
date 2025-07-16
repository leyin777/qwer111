package com.example.entity;

public class AnswerRecord {
    private Long questionId;
    private int userAnswerIndex;
    private boolean correct;

    public AnswerRecord() {}

    public AnswerRecord(Long questionId, int userAnswerIndex, boolean correct) {
        this.questionId = questionId;
        this.userAnswerIndex = userAnswerIndex;
        this.correct = correct;
    }

    public Long getQuestionId() { return questionId; }
    public void setQuestionId(Long questionId) { this.questionId = questionId; }
    public int getUserAnswerIndex() { return userAnswerIndex; }
    public void setUserAnswerIndex(int userAnswerIndex) { this.userAnswerIndex = userAnswerIndex; }
    public boolean isCorrect() { return correct; }
    public void setCorrect(boolean correct) { this.correct = correct; }
} 
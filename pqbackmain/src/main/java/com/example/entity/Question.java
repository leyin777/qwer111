package com.example.entity;

public class Question {
    private Long id;
    private Long qid;
    private String content;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private int correctIndex;
    private Double accuracy;
    private Integer correctUserCount;

    public Question() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getQid() { return qid; }
    public void setQid(Long qid) { this.qid = qid; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getOptionA() { return optionA; }
    public void setOptionA(String optionA) { this.optionA = optionA; }
    public String getOptionB() { return optionB; }
    public void setOptionB(String optionB) { this.optionB = optionB; }
    public String getOptionC() { return optionC; }
    public void setOptionC(String optionC) { this.optionC = optionC; }
    public String getOptionD() { return optionD; }
    public void setOptionD(String optionD) { this.optionD = optionD; }
    public int getCorrectIndex() { return correctIndex; }
    public void setCorrectIndex(int correctIndex) { this.correctIndex = correctIndex; }
    public Double getAccuracy() { return accuracy; }
    public void setAccuracy(Double accuracy) { this.accuracy = accuracy; }
    public Integer getCorrectUserCount() { return correctUserCount; }
    public void setCorrectUserCount(Integer correctUserCount) { this.correctUserCount = correctUserCount; }
}
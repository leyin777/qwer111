package com.example.entity;

public class Question {
    private Long id;
    private String content;
    private String[] options;
    private int correctIndex;

    public Question() {}

    public Question(Long id, String content, String[] options, int correctIndex) {
        this.id = id;
        this.content = content;
        this.options = options;
        this.correctIndex = correctIndex;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String[] getOptions() { return options; }
    public void setOptions(String[] options) { this.options = options; }
    public int getCorrectIndex() { return correctIndex; }
    public void setCorrectIndex(int correctIndex) { this.correctIndex = correctIndex; }
} 
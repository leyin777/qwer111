package com.example.entity;

public class Question {
    private Long id;
    private String text;
    private String ansa;
    private String ansb;
    private String ansc;
    private String ansd;
    private String correct;
    private Long qid;
    private Double accuracy;

    public Question() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getText() { return text; }
    public void setText(String text) { this.text = text; }
    public String getAnsa() { return ansa; }
    public void setAnsa(String ansa) { this.ansa = ansa; }
    public String getAnsb() { return ansb; }
    public void setAnsb(String ansb) { this.ansb = ansb; }
    public String getAnsc() { return ansc; }
    public void setAnsc(String ansc) { this.ansc = ansc; }
    public String getAnsd() { return ansd; }
    public void setAnsd(String ansd) { this.ansd = ansd; }
    public String getCorrect() { return correct; }
    public void setCorrect(String correct) { this.correct = correct; }
    public Long getQid() { return qid; }
    public void setQid(Long qid) { this.qid = qid; }
    public Double getAccuracy() { return accuracy; }
    public void setAccuracy(Double accuracy) { this.accuracy = accuracy; }
} 
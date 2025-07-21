package com.example.entity;

public class Rank {
    private Integer id;
    private Integer uid;
    private Integer qid;
    private String accuracy;
    private String ranking;

    public Rank() {}

    public Rank(Integer uid, Integer qid, String accuracy, String ranking) {
        this.uid = uid;
        this.qid = qid;
        this.accuracy = accuracy;
        this.ranking = ranking;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public Integer getUid() { return uid; }
    public void setUid(Integer uid) { this.uid = uid; }
    
    public Integer getQid() { return qid; }
    public void setQid(Integer qid) { this.qid = qid; }
    
    public String getAccuracy() { return accuracy; }
    public void setAccuracy(String accuracy) { this.accuracy = accuracy; }
    
    public String getRanking() { return ranking; }
    public void setRanking(String ranking) { this.ranking = ranking; }
} 
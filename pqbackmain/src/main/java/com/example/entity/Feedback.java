package com.example.entity;

import java.util.Date;

public class Feedback {
    private Integer id;
    private Integer qid;
    private Integer uid;
    private Integer tooFast;
    private Integer tooSlow;
    private Integer boring;
    private Integer badQuestion;
    private String comment;
    private Date createdAt;

    public Feedback() {}

    public Feedback(Integer qid, Integer uid, Integer tooFast, Integer tooSlow, 
                   Integer boring, Integer badQuestion, String comment) {
        this.qid = qid;
        this.uid = uid;
        this.tooFast = tooFast;
        this.tooSlow = tooSlow;
        this.boring = boring;
        this.badQuestion = badQuestion;
        this.comment = comment;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public Integer getQid() { return qid; }
    public void setQid(Integer qid) { this.qid = qid; }
    
    public Integer getUid() { return uid; }
    public void setUid(Integer uid) { this.uid = uid; }
    
    public Integer getTooFast() { return tooFast; }
    public void setTooFast(Integer tooFast) { this.tooFast = tooFast; }
    
    public Integer getTooSlow() { return tooSlow; }
    public void setTooSlow(Integer tooSlow) { this.tooSlow = tooSlow; }
    
    public Integer getBoring() { return boring; }
    public void setBoring(Integer boring) { this.boring = boring; }
    
    public Integer getBadQuestion() { return badQuestion; }
    public void setBadQuestion(Integer badQuestion) { this.badQuestion = badQuestion; }
    
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
} 
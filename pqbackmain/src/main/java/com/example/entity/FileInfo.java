package com.example.entity;

public class FileInfo {
    private Long id;
    private String name;
    private String type;
    private String url;

    public FileInfo() {}

    public FileInfo(Long id, String name, String type, String url) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.url = url;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
} 
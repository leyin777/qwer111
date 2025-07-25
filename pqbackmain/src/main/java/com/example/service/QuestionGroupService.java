package com.example.service;

import com.example.mapper.QuestionGroupMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QuestionGroupService {
    @Autowired
    private QuestionGroupMapper questionGroupMapper;

    public Long getQidByFileId(Long fileId) {
        return questionGroupMapper.getQidByFileId(fileId);
    }
} 
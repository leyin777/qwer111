package com.example.controller;

import com.example.entity.FileInfo;
import com.example.service.FileService;
import com.example.service.QuestionGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/file")
public class FileController {
    @Autowired
    private FileService fileService;

    @Autowired
    private QuestionGroupService questionGroupService;

    @GetMapping("/list")
    public List<FileInfo> getFileList() {
        return fileService.getFileList();
    }

    @GetMapping("/detail")
    public FileInfo getFileDetail(@RequestParam Long id) {
        return fileService.getFileDetail(id);
    }

    @GetMapping("/qid")
    public Long getQidByFileId(@RequestParam Long fileId) {
        return questionGroupService.getQidByFileId(fileId);
    }
} 
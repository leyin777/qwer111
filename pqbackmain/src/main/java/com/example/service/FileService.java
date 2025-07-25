package com.example.service;

import com.example.entity.FileInfo;
import com.example.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FileService {
    @Autowired
    private FileMapper fileMapper;

    public List<FileInfo> getFileList() {
        return fileMapper.getFileList();
    }

    public FileInfo getFileDetail(Long id) {
        return fileMapper.getFileDetail(id);
    }
} 
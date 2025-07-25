package com.example.mapper;

import com.example.entity.FileInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface FileMapper {
    List<FileInfo> getFileList();
    FileInfo getFileDetail(@Param("id") Long id);
} 
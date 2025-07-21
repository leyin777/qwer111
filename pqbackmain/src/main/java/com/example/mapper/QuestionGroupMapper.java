package com.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface QuestionGroupMapper {
    Long getQidByFileId(@Param("fileId") Long fileId);
} 
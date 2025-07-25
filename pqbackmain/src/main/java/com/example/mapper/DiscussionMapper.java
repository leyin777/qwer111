package com.example.mapper;

import com.example.entity.Discussion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface DiscussionMapper {
    // 根据问题ID获取所有讨论
    List<Discussion> getDiscussionsByQid(@Param("qid") Integer qid);
    // 插入新讨论
    int insertDiscussion(Discussion discussion);
    // 根据ID删除讨论
    int deleteDiscussionById(@Param("id") Integer id);
    // 根据问题ID删除所有讨论
    int deleteDiscussionsByQid(@Param("qid") Integer qid);
} 
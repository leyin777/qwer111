package com.example.service;

import com.example.entity.Discussion;
import com.example.mapper.DiscussionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DiscussionService {
    @Autowired
    private DiscussionMapper discussionMapper;

    /**
     * 根据问题ID获取所有讨论
     */
    public List<Discussion> getDiscussionsByQid(Integer qid) {
        return discussionMapper.getDiscussionsByQid(qid);
    }

    /**
     * 添加新讨论
     */
    public boolean addDiscussion(Discussion discussion) {
        return discussionMapper.insertDiscussion(discussion) > 0;
    }

    /**
     * 删除讨论
     */
    public boolean deleteDiscussion(Integer id) {
        return discussionMapper.deleteDiscussionById(id) > 0;
    }

    /**
     * 根据问题ID删除所有讨论
     */
    public boolean deleteDiscussionsByQid(Integer qid) {
        return discussionMapper.deleteDiscussionsByQid(qid) > 0;
    }
} 
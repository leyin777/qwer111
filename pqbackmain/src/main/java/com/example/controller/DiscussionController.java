package com.example.controller;

import com.example.entity.Discussion;
import com.example.service.DiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class DiscussionController {
    @Autowired
    private DiscussionService discussionService;

    /**
     * 获取某问题的所有讨论
     * GET /api/discussions?qid={qid}
     */
    @GetMapping("/discussions")
    public List<Discussion> getDiscussions(@RequestParam Integer qid) {
        return discussionService.getDiscussionsByQid(qid);
    }

    /**
     * 添加新讨论
     * POST /api/discussions
     */
    @PostMapping("/discussions")
    public Map<String, Object> addDiscussion(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        try {
            if (request.get("content") == null || request.get("qid") == null || request.get("uid") == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：content、qid或uid");
                return result;
            }
            String content = request.get("content").toString();
            Integer qid = Integer.valueOf(request.get("qid").toString());
            Integer uid = Integer.valueOf(request.get("uid").toString());
            Discussion discussion = new Discussion();
            discussion.setContent(content);
            discussion.setQid(qid);
            discussion.setUid(uid);
            boolean success = discussionService.addDiscussion(discussion);
            if (success) {
                result.put("code", 0);
                result.put("msg", "讨论发表成功");
                result.put("data", discussion);
            } else {
                result.put("code", 1);
                result.put("msg", "讨论发表失败");
            }
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "发表讨论时发生错误：" + e.getMessage());
        }
        return result;
    }

    /**
     * 删除讨论
     * DELETE /api/discussions/{id}
     */
    @DeleteMapping("/discussions/{id}")
    public Map<String, Object> deleteDiscussion(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            boolean success = discussionService.deleteDiscussion(id);
            if (success) {
                result.put("code", 0);
                result.put("msg", "讨论删除成功");
            } else {
                result.put("code", 1);
                result.put("msg", "讨论删除失败");
            }
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "删除讨论时发生错误：" + e.getMessage());
        }
        return result;
    }
} 
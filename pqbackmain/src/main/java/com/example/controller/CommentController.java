package com.example.controller;

import com.example.entity.Comment;
import com.example.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class CommentController {
    
    @Autowired
    private CommentService commentService;
    
    /**
     * 获取课程的所有评论
     * GET /api/comments?courseId={courseId}
     */
    @GetMapping("/comments")
    public List<Comment> getComments(@RequestParam Integer courseId) {
        return commentService.getCommentsByCourseId(courseId);
    }
    
    /**
     * 添加新评论
     * POST /api/comments
     */
    @PostMapping("/comments")
    public Map<String, Object> addComment(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (request.get("content") == null || request.get("courseId") == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：content 或 courseId");
                return result;
            }
            
            String content = request.get("content").toString();
            Integer courseId = Integer.valueOf(request.get("courseId").toString());
            
            // 创建评论对象
            Comment comment = new Comment();
            comment.setContent(content);
            comment.setCourseId(courseId);
            comment.setUsername(request.getOrDefault("username", "匿名用户").toString());
            if (request.get("role") != null) {
                comment.setRole(request.get("role").toString());
            } else {
                comment.setRole("audience");
            }
            
            // 保存评论
            boolean success = commentService.addComment(comment);
            
            if (success) {
                result.put("code", 0);
                result.put("msg", "评论发表成功");
                result.put("data", comment);
            } else {
                result.put("code", 1);
                result.put("msg", "评论发表失败");
            }
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "发表评论时发生错误：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 删除评论
     * DELETE /api/comments/{id}
     */
    @DeleteMapping("/comments/{id}")
    public Map<String, Object> deleteComment(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = commentService.deleteComment(id);
            
            if (success) {
                result.put("code", 0);
                result.put("msg", "评论删除成功");
            } else {
                result.put("code", 1);
                result.put("msg", "评论删除失败");
            }
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "删除评论时发生错误：" + e.getMessage());
        }
        
        return result;
    }
} 
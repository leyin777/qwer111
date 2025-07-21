package com.example.controller;

import com.example.entity.Rank;
import com.example.service.RankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class RankController {
    
    @Autowired
    private RankService rankService;
    
    @Autowired
    private com.example.mapper.RankMapper rankMapper;
    
    /**
     * 测试接口 - 验证RankController是否正常工作
     * GET /api/rank/test
     */
    @GetMapping("/rank/test")
    public Map<String, Object> test() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "RankController 正常工作");
        result.put("timestamp", System.currentTimeMillis());
        result.put("availableEndpoints", new String[]{
            "GET /api/rank/test",
            "POST /api/rank/calculate",
            "GET /api/rank/list?qid={qid}",
            "GET /api/rank/details?qid={qid}",
            "GET /api/rank/user?uid={uid}&qid={qid}",
            "GET /api/rank/stats?qid={qid}",
            "DELETE /api/rank/delete?qid={qid}",
            "POST /api/rank/recalculate?qid={qid}"
        });
        return result;
    }
    
    /**
     * 上传用户答题正确率并计算排名
     * POST /api/rank/calculate
     */
    @PostMapping("/rank/calculate")
    public Map<String, Object> calculateRank(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (request.get("uid") == null || request.get("qid") == null || request.get("accuracy") == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：uid、qid 或 accuracy");
                return result;
            }
            
            Integer uid = Integer.valueOf(request.get("uid").toString());
            Integer qid = Integer.valueOf(request.get("qid").toString());
            Integer accuracy = Integer.valueOf(request.get("accuracy").toString());
            
            // 验证accuracy范围
            if (accuracy < 0 || accuracy > 100) {
                result.put("code", 1);
                result.put("msg", "正确率应在0-100之间");
                return result;
            }
            
            // 上传正确率并更新排名
            boolean success = rankService.uploadAccuracyAndUpdateRank(uid, qid, accuracy);
            
            if (success) {
                result.put("code", 0);
                result.put("msg", "正确率上传成功，排名已更新");
                result.put("data", Map.of(
                    "uid", uid,
                    "qid", qid,
                    "accuracy", accuracy + "%"
                ));
            } else {
                result.put("code", 1);
                result.put("msg", "正确率上传失败");
            }
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "上传正确率时发生错误：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取课程排名列表
     * GET /api/rank/list?qid={qid}
     */
    @GetMapping("/rank/list")
    public Map<String, Object> getRankList(@RequestParam(required = false) Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (qid == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：qid");
                return result;
            }
            
            List<Rank> ranks = rankService.getRanksByQid(qid);
            result.put("code", 0);
            result.put("data", ranks);
            result.put("msg", "获取排名列表成功");
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "获取排名列表失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取用户排名信息
     * GET /api/rank/user?uid={uid}&qid={qid}
     */
    @GetMapping("/rank/user")
    public Map<String, Object> getUserRank(@RequestParam Integer uid, @RequestParam Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Rank userRank = rankService.getUserRank(uid, qid);
            result.put("code", 0);
            result.put("data", userRank);
            result.put("msg", "获取用户排名成功");
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "获取用户排名失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 删除课程排名记录
     * DELETE /api/rank/delete?qid={qid}
     */
    @DeleteMapping("/rank/delete")
    public Map<String, Object> deleteRanks(@RequestParam Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = rankService.deleteRanksByQid(qid);
            if (success) {
                result.put("code", 0);
                result.put("msg", "删除排名记录成功");
            } else {
                result.put("code", 1);
                result.put("msg", "删除排名记录失败");
            }
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "删除排名记录时发生错误：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取课程排名统计
     * GET /api/rank/stats?qid={qid}
     */
    @GetMapping("/rank/stats")
    public Map<String, Object> getRankStats(@RequestParam Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            int count = rankService.getRankCountByQid(qid);
            List<Rank> ranks = rankService.getRanksByQid(qid);
            
            Map<String, Object> stats = new HashMap<>();
            stats.put("totalParticipants", count);
            stats.put("topRanks", ranks.size() > 3 ? ranks.subList(0, 3) : ranks);
            
            result.put("code", 0);
            result.put("data", stats);
            result.put("msg", "获取排名统计成功");
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "获取排名统计失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取课程排名详细信息
     * GET /api/rank/details?qid={qid}
     */
    @GetMapping("/rank/details")
    public Map<String, Object> getRankDetails(@RequestParam(required = false) Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (qid == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：qid");
                return result;
            }
            
            List<Map<String, Object>> rankDetails = rankService.getRankDetailsByQid(qid);
            result.put("code", 0);
            result.put("data", rankDetails);
            result.put("msg", "获取排名详细信息成功");
            result.put("qid", qid);
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "获取排名详细信息失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 直接上传排名数据
     * POST /api/rank/upload
     */
    @PostMapping("/rank/upload")
    public Map<String, Object> uploadRank(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (request.get("uid") == null || request.get("qid") == null || request.get("accuracy") == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：uid、qid 或 accuracy");
                return result;
            }
            
            Integer uid = Integer.valueOf(request.get("uid").toString());
            Integer qid = Integer.valueOf(request.get("qid").toString());
            String accuracy = request.get("accuracy").toString();
            
            // 验证accuracy格式
            try {
                Double.parseDouble(accuracy);
            } catch (NumberFormatException e) {
                result.put("code", 1);
                result.put("msg", "accuracy格式错误，应为数字");
                return result;
            }
            
            // 检查用户是否已有排名记录
            Rank existingRank = rankService.getUserRank(uid, qid);
            
            if (existingRank != null) {
                // 更新现有记录
                existingRank.setAccuracy(accuracy);
                rankMapper.updateRank(existingRank);
            } else {
                // 插入新记录
                Rank newRank = new Rank(uid, qid, accuracy, "");
                rankMapper.insertRank(newRank);
            }
            
            // 更新所有用户的排名
            updateAllRankings(qid);
            
            result.put("code", 0);
            result.put("msg", "排名数据上传成功");
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "上传排名数据时发生错误：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * Audience答题结束后直接上传排名数据
     * POST /api/rank/audience-upload
     */
    @PostMapping("/rank/audience-upload")
    public Map<String, Object> audienceUploadRank(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (request.get("uid") == null || request.get("qid") == null || request.get("accuracy") == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：uid、qid 或 accuracy");
                return result;
            }
            
            Integer uid = Integer.valueOf(request.get("uid").toString());
            Integer qid = Integer.valueOf(request.get("qid").toString());
            String accuracy = request.get("accuracy").toString();
            
            // 验证accuracy格式
            try {
                Double.parseDouble(accuracy);
            } catch (NumberFormatException e) {
                result.put("code", 1);
                result.put("msg", "accuracy格式错误，应为数字");
                return result;
            }
            
            // 直接调用服务方法处理排名更新
            boolean success = rankService.updateRankAfterAnswer(uid, qid);
            
            if (success) {
                result.put("code", 0);
                result.put("msg", "Audience排名数据上传成功");
                result.put("data", Map.of(
                    "uid", uid,
                    "qid", qid,
                    "accuracy", accuracy
                ));
            } else {
                result.put("code", 1);
                result.put("msg", "排名数据上传失败");
            }
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "上传排名数据时发生错误：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 重新计算指定课程的排名（支持并列排名）
     * POST /api/rank/recalculate?qid={qid}
     */
    @PostMapping("/rank/recalculate")
    public Map<String, Object> recalculateRank(@RequestParam(required = false) Integer qid) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 参数验证
            if (qid == null) {
                result.put("code", 1);
                result.put("msg", "缺少必要参数：qid");
                return result;
            }
            
            // 重新计算排名
            updateAllRankings(qid);
            
            // 获取更新后的排名详情
            List<Map<String, Object>> rankDetails = rankService.getRankDetailsByQid(qid);
            
            result.put("code", 0);
            result.put("msg", "排名重新计算成功");
            result.put("data", rankDetails);
            result.put("qid", qid);
            
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "重新计算排名时发生错误：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 更新所有用户的排名（支持并列排名）
     */
    private void updateAllRankings(Integer qid) {
        // 获取按正确率排序的排名列表
        List<Rank> ranks = rankService.getRanksByQid(qid);
        
        if (ranks.isEmpty()) {
            return;
        }
        
        // 计算并列排名
        int currentRank = 1;
        String currentAccuracy = ranks.get(0).getAccuracy();
        
        for (int i = 0; i < ranks.size(); i++) {
            Rank rank = ranks.get(i);
            String accuracy = rank.getAccuracy();
            
            // 如果正确率不同，更新排名
            if (!accuracy.equals(currentAccuracy)) {
                currentRank = i + 1;
                currentAccuracy = accuracy;
            }
            
            // 设置排名（相同正确率获得相同排名）
            rank.setRanking(String.valueOf(currentRank));
            rankMapper.updateRank(rank);
        }
    }
} 
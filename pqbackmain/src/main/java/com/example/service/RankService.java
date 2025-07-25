package com.example.service;

import com.example.entity.Rank;
import com.example.mapper.RankMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RankService {
    
    @Autowired
    private RankMapper rankMapper;
    
    @Autowired
    private QuestionService questionService;
    
    /**
     * 直接上传正确率并更新排名
     */
    public boolean uploadAccuracyAndUpdateRank(Integer uid, Integer qid, Integer accuracy) {
        try {
            // 将整数正确率转换为字符串格式
            String accuracyStr = String.format("%.2f", accuracy.doubleValue());
            
            // 检查用户是否已有排名记录
            Rank existingRank = rankMapper.getRankByUserAndQid(uid, qid);
            
            if (existingRank != null) {
                // 更新现有记录
                existingRank.setAccuracy(accuracyStr);
                rankMapper.updateRank(existingRank);
            } else {
                // 插入新记录
                Rank newRank = new Rank(uid, qid, accuracyStr, "");
                rankMapper.insertRank(newRank);
            }
            
            // 更新所有用户的排名
            updateAllRankings(qid);
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 每次答题后更新用户排名（新增方法）
     */
    public boolean updateRankAfterAnswer(Integer uid, Integer qid) {
        try {
            // 计算用户当前正确率
            String accuracy = calculateUserAccuracy(uid, qid);
            
            // 检查用户是否已有排名记录
            Rank existingRank = rankMapper.getRankByUserAndQid(uid, qid);
            
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
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 计算用户正确率并更新排名
     */
    public boolean calculateAndUpdateRank(Integer uid, Integer qid) {
        try {
            // 计算用户正确率
            String accuracy = calculateUserAccuracy(uid, qid);
            
            // 检查用户是否已有排名记录
            Rank existingRank = rankMapper.getRankByUserAndQid(uid, qid);
            
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
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 计算用户正确率
     */
    private String calculateUserAccuracy(Integer uid, Integer qid) {
        // 获取用户正确答题数
        int correctCount = questionService.countCorrectAnswers(uid.longValue(), qid.longValue());
        // 获取用户总答题数
        int totalCount = questionService.countTotalAnswers(uid.longValue(), qid.longValue());
        
        if (totalCount == 0) {
            return "0.00";
        }
        
        // 计算正确率（保留两位小数）
        double accuracy = (double) correctCount / totalCount * 100;
        return String.format("%.2f", accuracy);
    }
    
    /**
     * 更新所有用户的排名（支持并列排名）
     */
    private void updateAllRankings(Integer qid) {
        // 获取按正确率排序的排名列表
        List<Rank> ranks = rankMapper.getRanksByQid(qid);
        
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
    
    /**
     * 获取指定课程的排名列表
     */
    public List<Rank> getRanksByQid(Integer qid) {
        return rankMapper.getRanksByQid(qid);
    }
    
    /**
     * 获取用户的排名信息
     */
    public Rank getUserRank(Integer uid, Integer qid) {
        return rankMapper.getRankByUserAndQid(uid, qid);
    }
    
    /**
     * 删除指定课程的所有排名记录
     */
    public boolean deleteRanksByQid(Integer qid) {
        return rankMapper.deleteRanksByQid(qid) > 0;
    }
    
    /**
     * 获取指定课程的排名记录数量
     */
    public int getRankCountByQid(Integer qid) {
        return rankMapper.countRanksByQid(qid);
    }
    
    /**
     * 获取指定课程的排名详细信息（包括用户名）
     */
    public List<Map<String, Object>> getRankDetailsByQid(Integer qid) {
        return rankMapper.getRankDetailsByQid(qid);
    }
} 
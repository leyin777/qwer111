package com.example.mapper;

import com.example.entity.Rank;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface RankMapper {
    
    // 插入排名记录
    int insertRank(Rank rank);
    
    // 根据qid获取所有排名记录（按正确率降序）
    List<Rank> getRanksByQid(@Param("qid") Integer qid);
    
    // 根据qid获取排名详细信息（包括用户名）
    List<Map<String, Object>> getRankDetailsByQid(@Param("qid") Integer qid);
    
    // 检查用户是否已经提交过反馈
    Rank getRankByUserAndQid(@Param("uid") Integer uid, @Param("qid") Integer qid);
    
    // 更新反馈记录
    int updateRank(Rank rank);
    
    // 删除指定qid的所有排名记录
    int deleteRanksByQid(@Param("qid") Integer qid);
    
    // 获取指定qid的排名记录数量
    int countRanksByQid(@Param("qid") Integer qid);
} 
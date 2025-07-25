package com.example.mapper;

import com.example.entity.Addfile;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface AddfileMapper {
    @Insert("INSERT INTO addfile (filee, qid) VALUES (#{filee}, #{qid})")
    int insertFile(Addfile addfile);

    @Select("SELECT * FROM addfile WHERE qid = #{qid} LIMIT 1")
    Addfile selectByQid(Integer qid);

    @Select("SELECT * FROM addfile WHERE qid = #{qid}")
    java.util.List<Addfile> selectAllByQid(Integer qid);

    @Select("SELECT * FROM addfile")
    java.util.List<Addfile> selectAll();
} 
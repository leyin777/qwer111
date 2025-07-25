package com.example.service;

import com.example.entity.Addfile;
import com.example.entity.Question;
import com.example.mapper.AddfileMapper;
import com.mysql.cj.jdbc.ConnectionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AddfileService {
    // ① 注入配置值
    @Value("${aipq.baseurl}")
    private String baseUrl;
    @Autowired
    private AddfileMapper addfileMapper;
    @Autowired
    private JdbcTemplate jdbcTemplate;


    @Autowired
    private com.example.mapper.QuestionMapper questionMapper;

    public int saveFileContent(String content, Integer qid) {

        Addfile addfile = new Addfile();
        addfile.setFilee(content);
        addfile.setQid(qid);
        return addfileMapper.insertFile(addfile);
    }

    public int generateQuestionsByQid(Integer qid) {
        // 1. 把多条 filee 拼成一段完整文本
        List<Addfile> list = addfileMapper.selectAllByQid(qid);
        String fullText = list.stream()
                .map(Addfile::getFilee)
                .collect(Collectors.joining("\n"));

// 2. 构造 multipart/form-data
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("text", fullText);          // 必填字段
        body.add("n", 5);                    // 可选，按接口要求

        HttpEntity<MultiValueMap<String, Object>> requestEntity =
                new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.postForEntity(
                baseUrl + "aipqapi/generate",
                requestEntity,
                Map.class
        );


        List<Map<String, Object>> questions =
                (List<Map<String, Object>>) response.getBody().get("questions");
        if (questions == null) {
            throw new RuntimeException("未返回 questions");
        }

        // 4. 批量插入
        int count = 0;
        jdbcTemplate.batchUpdate(
                "INSERT INTO question (qid, text, ansa, ansb, ansc, ansd, correct) VALUES (?, ?, ?, ?, ?, ?, ?)",
                questions,
                questions.size(),
                (ps, q) -> {
                    ps.setLong(1, qid.longValue());
                    ps.setString(2, (String) q.get("stem"));
                    ps.setString(3, (String) q.get("A"));
                    ps.setString(4, (String) q.get("B"));
                    ps.setString(5, (String) q.get("C"));
                    ps.setString(6, (String) q.get("D"));
                    ps.setString(7,  (String)q.get("correct"));

                }
        );
        return count;
    }




    // 工具方法：将A/B/C/D转为0/1/2/3
    private int optionToIndex(String correct) {
        switch (correct) {
            case "A": return 0;
            case "B": return 1;
            case "C": return 2;
            case "D": return 3;
            default: return -1;
        }
    }
} 
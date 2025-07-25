package com.example.controller;

import com.example.service.AddfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.client.RestTemplate;
import java.util.Map;
import java.io.InputStream;
import org.springframework.core.io.InputStreamResource;

@RestController

public class AddfileController {
    // ① 注入配置值
    @Value("${aipq.baseurl}")
    private String baseUrl;

    @Autowired
    private AddfileService addfileService;

    @PostMapping("/uploadAndSave")
    public String uploadAndSave(@RequestParam("file") MultipartFile file,
                                @RequestParam("qid") Integer qid) {
        try {
            // 构造转发请求

            String url = baseUrl+"aipqapi/extract";
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("file", new MultipartInputStreamFileResource(file.getInputStream(), file.getOriginalFilename()));

            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<Map> response = restTemplate.postForEntity(url, requestEntity, Map.class);

            // 解析text字段
            Object textObj = response.getBody().get("text");
            if (textObj == null) {
                return "外部接口未返回text字段";
            }
            String text = textObj.toString();

            // 保存到数据库
            addfileService.saveFileContent(text, qid);

            return "文件上传并保存成功";
        } catch (Exception e) {
            e.printStackTrace();
            return "操作失败: " + e.getMessage();
        }
    }

    @PostMapping("/generateQuestions")
    public String generateQuestions(@RequestParam("qid") Integer qid) {
        try {
            int count = addfileService.generateQuestionsByQid(qid);
            return "成功导入" + count + "道题";
        } catch (Exception e) {
            e.printStackTrace();
            return "生成题目失败: " + e.getMessage();
        }
    }



    // 工具类：用于RestTemplate转发文件
    public static class MultipartInputStreamFileResource extends InputStreamResource {
        private final String filename;
        public MultipartInputStreamFileResource(InputStream inputStream, String filename) {
            super(inputStream);
            this.filename = filename;
        }
        @Override
        public String getFilename() {
            return this.filename;
        }
        @Override
        public long contentLength() {
            return -1;
        }
    }
} 
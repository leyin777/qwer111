-- 创建反馈表
CREATE TABLE IF NOT EXISTS feedback (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    qid INT(11) NOT NULL COMMENT '课程ID',
    uid INT(11) NOT NULL COMMENT '用户ID',
    too_fast INT(11) DEFAULT 0 COMMENT '讲得太快（0或1）',
    too_slow INT(11) DEFAULT 0 COMMENT '讲得太慢（0或1）',
    boring INT(11) DEFAULT 0 COMMENT '演讲本身太乏味（0或1）',
    bad_question INT(11) DEFAULT 0 COMMENT '题目出得质量不好（0或1）',
    comment TEXT COMMENT '用户评论',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    -- 添加索引
    INDEX idx_qid (qid),
    INDEX idx_uid (uid),
    INDEX idx_qid_uid (qid, uid),
    
    -- 添加外键约束（可选，如果表存在的话）
    -- FOREIGN KEY (qid) REFERENCES course(id),
    -- FOREIGN KEY (uid) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户反馈表';

-- 插入测试数据（可选）
-- INSERT INTO feedback (qid, uid, too_fast, too_slow, boring, bad_question, comment) VALUES
-- (1, 1, 1, 0, 0, 0, '讲得有点快，希望能慢一点'),
-- (1, 2, 0, 1, 0, 0, '讲得太慢了，希望能快一点'),
-- (1, 3, 0, 0, 1, 0, '内容有点枯燥'),
-- (1, 4, 0, 0, 0, 1, '题目质量需要改进'); 
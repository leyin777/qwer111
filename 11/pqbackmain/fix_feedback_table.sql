-- 修复feedback表的id字段，确保其为自增主键
ALTER TABLE feedback MODIFY COLUMN id INT(11) AUTO_INCREMENT PRIMARY KEY;

-- 如果表不存在，则创建表
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
    INDEX idx_qid_uid (qid, uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户反馈表';

-- 检查表结构
DESCRIBE feedback; 
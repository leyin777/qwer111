-- 创建排名表
CREATE TABLE IF NOT EXISTS rank (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    uid INT(11) NOT NULL COMMENT '用户ID',
    qid INT(11) NOT NULL COMMENT '课程ID',
    accuracy VARCHAR(255) NOT NULL COMMENT '正确率（百分比字符串）',
    ranking VARCHAR(255) NOT NULL COMMENT '排名',
    
    -- 添加索引
    INDEX idx_qid (qid),
    INDEX idx_uid (uid),
    INDEX idx_qid_uid (qid, uid),
    INDEX idx_accuracy (accuracy),
    INDEX idx_ranking (ranking),
    
    -- 添加唯一约束，确保每个用户在每个课程中只有一条排名记录
    UNIQUE KEY uk_user_course (uid, qid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户答题排名表';

-- 检查表结构
DESCRIBE rank;

-- 插入测试数据（可选）
-- INSERT INTO rank (uid, qid, accuracy, ranking) VALUES
-- (1, 1, '80.00', '1'),
-- (2, 1, '60.00', '2'),
-- (3, 1, '40.00', '3'); 
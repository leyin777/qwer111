-- 测试并列排名功能的数据
-- 先清空现有数据
DELETE FROM rank WHERE qid = 999;

-- 插入测试数据（qid=999用于测试）
INSERT INTO rank (uid, qid, accuracy, ranking) VALUES
(1, 999, '100.00', '1'),  -- 用户1，100%正确率
(2, 999, '100.00', '1'),  -- 用户2，100%正确率（应该并列第一）
(3, 999, '80.00', '3'),   -- 用户3，80%正确率（应该是第三名）
(4, 999, '80.00', '3'),   -- 用户4，80%正确率（应该并列第三）
(5, 999, '60.00', '5'),   -- 用户5，60%正确率（应该是第五名）
(6, 999, '40.00', '6');   -- 用户6，40%正确率（应该是第六名）

-- 查看插入的数据
SELECT * FROM rank WHERE qid = 999 ORDER BY CAST(accuracy AS DECIMAL(5,2)) DESC;

-- 测试排名详情查询
SELECT 
    r.ranking as ranking,
    u.username as username,
    r.accuracy as accuracy,
    ROUND(CAST(r.accuracy AS DECIMAL(5,2)) * 5 / 100, 0) as score
FROM rank r
LEFT JOIN user u ON r.uid = u.id
WHERE r.qid = 999
ORDER BY CAST(r.accuracy AS DECIMAL(5,2)) DESC, r.id ASC; 
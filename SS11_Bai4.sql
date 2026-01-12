-- 1. SỬ DỤNG DATABASE
USE social_network_pro;

-- 2. TẠO STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE CreatePostWithValidation (
    IN p_user_id INT,
    IN p_content TEXT,
    OUT result_message VARCHAR(255)
)
BEGIN
    -- Kiểm tra độ dài nội dung
    IF CHAR_LENGTH(p_content) < 5 THEN
        SET result_message = 'Nội dung quá ngắn';
    ELSE
        INSERT INTO posts (user_id, content, created_at)
        VALUES (p_user_id, p_content, NOW());

        SET result_message = 'Thêm bài viết thành công';
    END IF;
END //

DELIMITER ;

-- 3. GỌI THỦ TỤC – TEST CÁC TRƯỜNG HỢP

-- Trường hợp 1: Nội dung quá ngắn
CALL CreatePostWithValidation(1, 'Hi', @msg1);
SELECT @msg1 AS result_case_1;

-- Trường hợp 2: Nội dung hợp lệ
CALL CreatePostWithValidation(1, 'Đây là một bài viết hợp lệ', @msg2);
SELECT @msg2 AS result_case_2;

-- 4. KIỂM TRA KẾT QUẢ TRONG BẢNG POSTS
SELECT post_id, user_id, content, created_at
FROM posts
WHERE user_id = 1
ORDER BY created_at DESC
LIMIT 5;

-- 5. XÓA STORED PROCEDURE
DROP PROCEDURE IF EXISTS CreatePostWithValidation;

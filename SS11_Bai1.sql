-- 1. SỬ DỤNG DATABASE
-- ==============================
USE social_network_pro;

-- ==============================
-- 2. TẠO STORED PROCEDURE
-- Lấy danh sách bài viết của 1 user
-- ==============================
DELIMITER //

CREATE PROCEDURE sp_GetPostsByUser (
    IN p_user_id INT
)
BEGIN
    SELECT
        post_id,
        content,
        created_at
    FROM posts
    WHERE user_id = p_user_id
    ORDER BY created_at DESC;
END //

DELIMITER ;

-- ==============================
-- 3. GỌI STORED PROCEDURE
-- Ví dụ: lấy bài viết của user_id = 1
-- ==============================
CALL sp_GetPostsByUser(1);

-- ==============================
-- 4. XÓA STORED PROCEDURE
-- ==============================
DROP PROCEDURE IF EXISTS sp_GetPostsByUser;

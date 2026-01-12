-- ==============================
-- 1. SỬ DỤNG DATABASE
-- ==============================
USE social_network_pro;

-- ==============================
-- 2. TẠO STORED PROCEDURE
-- Tính tổng số like của 1 bài viết
-- ==============================
DELIMITER //

CREATE PROCEDURE CalculatePostLikes (
    IN p_post_id INT,
    OUT total_likes INT
)
BEGIN
    SELECT COUNT(*)
    INTO total_likes
    FROM likes
    WHERE post_id = p_post_id;
END //

DELIMITER ;

-- ==============================
-- 3. GỌI STORED PROCEDURE
-- Ví dụ: tính like của post_id = 101
-- ==============================
CALL CalculatePostLikes(101, @total_likes);

-- Xem giá trị OUT
SELECT @total_likes AS total_likes_of_post;

-- ==============================
-- 4. XÓA STORED PROCEDURE
-- ==============================
DROP PROCEDURE IF EXISTS CalculatePostLikes;


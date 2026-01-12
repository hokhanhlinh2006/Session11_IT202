
-- 1. SỬ DỤNG DATABASE
USE social_network_pro;

-- 2. TẠO STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE CalculateBonusPoints (
    IN p_user_id INT,
    INOUT p_bonus_points INT
)
BEGIN
    DECLARE post_count INT DEFAULT 0;

    -- Đếm số bài viết của user
    SELECT COUNT(*)
    INTO post_count
    FROM posts
    WHERE user_id = p_user_id;

    -- Cộng điểm theo điều kiện
    IF post_count >= 20 THEN
        SET p_bonus_points = p_bonus_points + 100;
    ELSEIF post_count >= 10 THEN
        SET p_bonus_points = p_bonus_points + 50;
    END IF;
END //

DELIMITER ;

-- 3. GỌI STORED PROCEDURE
SET @bonus = 100;
CALL CalculateBonusPoints(1, @bonus);

-- 4. XEM GIÁ TRỊ INOUT SAU KHI CẬP NHẬT
SELECT @bonus AS final_bonus_points;

-- 5. XÓA STORED PROCEDURE
DROP PROCEDURE IF EXISTS CalculateBonusPoints;


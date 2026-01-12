-- Tạo cơ sở dữ liệu SocialLab và bảng posts gồm các trường:
-- post_id (INT, Primary Key, Auto Increment)
-- content (TEXT)
-- author (VARCHAR)
-- likes_count (INT, Default 0)
 
-- 2. Yêu cầu thực hiện 
-- Bạn hãy viết các Stored Procedure thực hiện các nhiệm vụ sau:
-- Task 1 (CREATE): Viết thủ tục sp_CreatePost để thêm bài viết mới.
-- Sử dụng tham số IN cho content và author.
-- Sử dụng tham số OUT để trả về post_id của bài viết vừa tạo.
-- Task 2 (READ & SEARCH): Viết thủ tục sp_SearchPost để tìm kiếm.
-- Sử dụng tham số IN là từ khóa tìm kiếm.
-- Kết quả trả về danh sách các bài viết có nội dung chứa từ khóa đó.
-- Task 3 (UPDATE): Viết thủ tục sp_IncreaseLike để tăng tương tác.
-- Sử dụng tham số IN cho post_id.
-- Sử dụng tham số INOUT để truyền vào số Like hiện tại và nhận lại số Like mới sau khi đã cộng thêm 1.
-- Task 4 (DELETE): Viết thủ tục sp_DeletePost.
-- Sử dụng tham số IN là post_id để xóa bài viết tương ứng.
 
-- 3. Kiểm tra và Dọn dẹp
-- Thực hiện chuỗi thao tác sau để kiểm tra logic:

-- Tạo 2 bài viết mới và dùng biến để xem ID trả về.
-- Tìm kiếm các bài viết có chữ "hello".
-- Tăng Like cho bài viết vừa tạo (sử dụng biến @ để truyền và nhận giá trị từ INOUT).
-- Xóa một bài viết bất kỳ.
-- Xóa bỏ (Drop) tất cả các thủ tục đã tạo sau khi hoàn thành.

/* =========================================
   SOCIAL NETWORK – STORED PROCEDURE PRACTICE
   ========================================= */
INSERT INTO studio (studio_id, studio_name, studio_location, hourly_price, studio_status) VALUES
('ST01', 'Studio A', 'Ha Noi', '20.00', 'Available'),
('ST02', 'Studio B', 'HCM', '25.00', 'Available'),
('ST03', 'Studio C', 'Danang', '30.00', 'Booked'),
('ST04', 'Studio D', 'Ha Noi', '22.00', 'Available'),
('ST05', 'Studio E', 'Can Tho', '18.00', 'Maintenance');
-- =========================
-- 1. TẠO DATABASE & TABLE
-- =========================
CREATE DATABASE SocialLab;
USE SocialLab;

DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    content TEXT,
    author VARCHAR(100),
    likes_count INT DEFAULT 0
);

-- =========================
-- 2. STORED PROCEDURES
-- =========================
DELIMITER //

-- Task 1: CREATE POST (IN + OUT)
CREATE PROCEDURE sp_CreatePost (
    IN p_content TEXT,
    IN p_author VARCHAR(100),
    OUT p_post_id INT
)
BEGIN
    INSERT INTO posts (content, author)
    VALUES (p_content, p_author);

    SET p_post_id = LAST_INSERT_ID();
END //

-- Task 2: SEARCH POST (IN)
CREATE PROCEDURE sp_SearchPost (
    IN p_keyword VARCHAR(100)
)
BEGIN
    SELECT post_id, content, author, likes_count
    FROM posts
    WHERE content LIKE CONCAT('%', p_keyword, '%');
END //

-- Task 3: INCREASE LIKE (IN + INOUT)
CREATE PROCEDURE sp_IncreaseLike (
    IN p_post_id INT,
    INOUT p_like INT
)
BEGIN
    UPDATE posts
    SET likes_count = likes_count + 1
    WHERE post_id = p_post_id;

    SELECT likes_count
    INTO p_like
    FROM posts
    WHERE post_id = p_post_id;
END //

-- Task 4: DELETE POST (IN)
CREATE PROCEDURE sp_DeletePost (
    IN p_post_id INT
)
BEGIN
    DELETE FROM posts
    WHERE post_id = p_post_id;
END //

DELIMITER ;

-- =========================
-- 3. KIỂM TRA LOGIC
-- =========================

-- 3.1 Tạo 2 bài viết mới
CALL sp_CreatePost('hello mysql', 'Admin', @post_id_1);
CALL sp_CreatePost('hello stored procedure', 'User1', @post_id_2);

SELECT @post_id_1 AS post_1, @post_id_2 AS post_2;

-- 3.2 Tìm bài viết chứa từ "hello"
CALL sp_SearchPost('hello');

-- 3.3 Tăng like cho bài viết đầu tiên
SET @like_count = 0;
CALL sp_IncreaseLike(@post_id_1, @like_count);

SELECT @like_count AS new_like_count;

-- 3.4 Xóa một bài viết
CALL sp_DeletePost(@post_id_2);

-- Kiểm tra lại bảng posts
SELECT * FROM posts;

-- =========================
-- 4. DỌN DẸP (DROP PROCEDURE)
-- =========================
DROP PROCEDURE IF EXISTS sp_CreatePost;
DROP PROCEDURE IF EXISTS sp_SearchPost;
DROP PROCEDURE IF EXISTS sp_IncreaseLike;
DROP PROCEDURE IF EXISTS sp_DeletePost;

/* ====== END FILE ====== */

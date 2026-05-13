-- =========================================
-- SOCIAL MEDIA PLATFORM PROJECT
-- =========================================

-- STEP 1 : CREATE DATABASE
DROP DATABASE IF EXISTS Social_Media;

CREATE DATABASE Social_Media;

USE Social_Media;

-- =========================================
-- STEP 2 : CREATE TABLES
-- =========================================

CREATE TABLE Users(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50),
    email_id VARCHAR(100) NOT NULL UNIQUE,
    gender ENUM('Female','Male','Others'),
    phone_number BIGINT UNIQUE
);

CREATE TABLE Posts(
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    caption VARCHAR(255),
    posted_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_Posts
    FOREIGN KEY(user_id)
    REFERENCES Users(user_id)
);

CREATE TABLE Followers(
    follower_id INT,
    following_id INT,
    follow_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(follower_id)
    REFERENCES Users(user_id),

    FOREIGN KEY(following_id)
    REFERENCES Users(user_id)
);

CREATE TABLE Comments(
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    comment_text TEXT,
    commented_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(post_id)
    REFERENCES Posts(post_id),

    FOREIGN KEY(user_id)
    REFERENCES Users(user_id)
);

CREATE TABLE Likes(
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    liked_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(post_id)
    REFERENCES Posts(post_id),

    FOREIGN KEY(user_id)
    REFERENCES Users(user_id)
);

CREATE TABLE Notifications(
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(user_id)
    REFERENCES Users(user_id)
);

-- =========================================
-- STEP 3 : INSERT USERS
-- =========================================

INSERT INTO Users(user_name,email_id,gender,phone_number)
VALUES
('Vaishu','vaishu@gmail.com','Female',9999999999),
('Harshana','Harshana@gmail.com','Female',9876543210),
('Rithika','Rithika@yahoo.com','Female',9123456780),
('Tarik','Tarik@gmail.com','Male',9234567890),
('Karthik','Karthik@gmail.com','Male',9345678901),
('Tina','Tina@gmail.com','Female',9456789012),
('Swathy','Swathy@gmail.com','Female',9567890123),
('Aditya','Aditya@gmail.com','Male',9678901234);

-- =========================================
-- STEP 4 : INSERT POSTS
-- =========================================

INSERT INTO Posts(user_id,caption,posted_date)
VALUES
(1,'Morning sunrise at beach','2024-01-05 06:30:00'),
(1,'Coffee and coding','2024-01-05 09:00:00'),
(2,'Weekend trip to mountains','2024-01-06 10:30:00'),
(3,'Late night coding session','2024-01-06 23:00:00'),
(2,'Movie night with friends','2024-01-07 20:30:00'),
(1,'Festival celebrations','2024-01-08 19:00:00'),
(3,'New book arrived','2024-01-09 15:00:00'),
(4,'Morning workout complete','2024-01-12 06:30:00');

-- =========================================
-- STEP 5 : INSERT COMMENTS
-- =========================================

INSERT INTO Comments(post_id,user_id,comment_text)
VALUES
(1,2,'Beautiful view'),
(1,3,'Amazing'),
(1,4,'Wonderful'),
(2,5,'Nice post'),
(2,6,'Keep coding'),
(3,1,'Love this place'),
(4,2,'Great work'),
(5,3,'Awesome movie'),
(6,4,'Happy festival'),
(7,5,'Which book?');

-- =========================================
-- STEP 6 : INSERT LIKES
-- =========================================

INSERT INTO Likes(post_id,user_id)
VALUES
(1,2),
(1,3),
(1,4),
(1,5),
(2,1),
(2,3),
(3,1),
(3,2),
(4,5),
(5,6),
(6,7),
(7,8);

-- =========================================
-- STEP 7 : INSERT FOLLOWERS
-- =========================================

INSERT INTO Followers(follower_id,following_id)
VALUES
(2,1),
(3,1),
(4,1),
(5,2),
(6,2),
(7,3),
(8,4);

-- =========================================
-- STEP 8 : BASIC QUERIES
-- =========================================

-- Users starting with 'a'
SELECT *
FROM Users
WHERE user_name LIKE 'a%';

-- Posts between dates
SELECT *
FROM Posts
WHERE posted_date BETWEEN '2024-01-01' AND '2024-12-31';

-- NULL captions
SELECT *
FROM Posts
WHERE caption IS NULL;

-- Email domains
SELECT *
FROM Users
WHERE SUBSTRING_INDEX(email_id,'@',-1)
IN ('gmail.com','yahoo.com');

-- =========================================
-- STEP 9 : GROUP BY / ORDER BY
-- =========================================

-- Top active users
SELECT
    user_id,
    COUNT(*) AS total_posts
FROM Posts
GROUP BY user_id
ORDER BY total_posts DESC
LIMIT 5;

-- Posts per day
SELECT
    DATE(posted_date) AS post_day,
    COUNT(*) AS total_posts
FROM Posts
GROUP BY DATE(posted_date)
HAVING COUNT(*) > 1;

-- =========================================
-- STEP 10 : BUILT IN FUNCTIONS
-- =========================================

SELECT MONTHNAME(posted_date)
FROM Posts;

SELECT LENGTH(caption)
FROM Posts;

SELECT UPPER(user_name)
FROM Users;

-- =========================================
-- STEP 11 : UNION QUERY
-- =========================================

SELECT
    u.user_name,
    u.user_id,
    c.comment_id AS interaction_id

FROM Users u

LEFT JOIN Comments c
ON u.user_id = c.user_id

UNION

SELECT
    u.user_name,
    u.user_id,
    l.like_id

FROM Users u

LEFT JOIN Likes l
ON u.user_id = l.user_id;

-- =========================================
-- STEP 12 : JOIN REPORT
-- =========================================

SELECT
    p.post_id,
    p.caption,
    u.user_name,

    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments

FROM Posts p

INNER JOIN Users u
ON p.user_id = u.user_id

LEFT JOIN Likes l
ON p.post_id = l.post_id

LEFT JOIN Comments c
ON p.post_id = c.post_id

GROUP BY
p.post_id,
p.caption,
u.user_name;

-- =========================================
-- STEP 13 : FUNCTION
-- =========================================

DELIMITER //

CREATE FUNCTION UserEngagement(userid INT)
RETURNS INT
READS SQL DATA
BEGIN

    DECLARE total_likes INT;
    DECLARE total_comments INT;

    SELECT COUNT(*)
    INTO total_likes
    FROM Likes
    WHERE user_id = userid;

    SELECT COUNT(*)
    INTO total_comments
    FROM Comments
    WHERE user_id = userid;

    RETURN total_likes + total_comments;

END //

DELIMITER ;

SELECT UserEngagement(1);

-- =========================================
-- STEP 14 : SUBQUERY
-- =========================================

SELECT
    u.user_id,
    COUNT(f.follower_id) AS followers_count

FROM Users u

JOIN Followers f
ON u.user_id = f.following_id

GROUP BY u.user_id

HAVING COUNT(f.follower_id) >

(
SELECT AVG(followerscount)
FROM
(
SELECT COUNT(*) AS followerscount
FROM Followers
GROUP BY following_id
) AS temp
);

-- =========================================
-- STEP 15 : STORED PROCEDURE
-- =========================================

DELIMITER //

CREATE PROCEDURE AllPost(IN input_name VARCHAR(50))
BEGIN

SELECT
    p.post_id,
    p.caption,
    p.posted_date

FROM Posts p

JOIN Users u
ON p.user_id = u.user_id

WHERE u.user_name = input_name;

END //

DELIMITER ;

CALL AllPost('vaishu');

-- =========================================
-- STEP 16 : VIEW
-- =========================================

CREATE VIEW post_summary AS

SELECT
    p.post_id,
    u.user_name,
    p.caption,

    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments

FROM Posts p

JOIN Users u
ON p.user_id = u.user_id

LEFT JOIN Likes l
ON p.post_id = l.post_id

LEFT JOIN Comments c
ON p.post_id = c.post_id

GROUP BY
p.post_id,
u.user_name,
p.caption;

SELECT * FROM post_summary;

-- =========================================
-- STEP 17 : TRIGGER
-- =========================================

DELIMITER //

CREATE TRIGGER insert_notification

AFTER INSERT ON Likes

FOR EACH ROW

BEGIN

DECLARE post_owner INT;

SELECT user_id
INTO post_owner
FROM Posts
WHERE post_id = NEW.post_id;

INSERT INTO Notifications(user_id,message)

VALUES
(
post_owner,
CONCAT('User ',NEW.user_id,' liked your post')
);

END //

DELIMITER ;

-- Test Trigger
INSERT INTO Likes(post_id,user_id)
VALUES(2,4);

SELECT * FROM Notifications;

-- =========================================
-- STEP 18 : HASHTAG ANALYSIS
-- =========================================

ALTER TABLE Posts
ADD COLUMN hashtag VARCHAR(50);

UPDATE Posts
SET hashtag =
CASE
WHEN caption LIKE '%Coffee%' THEN '#coffee'
WHEN caption LIKE '%coding%' THEN '#coding'
WHEN caption LIKE '%Festival%' THEN '#festival'
WHEN caption LIKE '%Movie%' THEN '#movie'
ELSE '#general'
END;

SELECT
    hashtag,
    COUNT(*) AS usage_count

FROM Posts

GROUP BY hashtag

ORDER BY usage_count DESC;

-- =========================================
-- STEP 19 : FINAL ANALYTICS
-- =========================================

SELECT
    u.user_id,
    u.user_name,

    COUNT(DISTINCT p.post_id)
    +
    COUNT(DISTINCT l.like_id)
    +
    COUNT(DISTINCT c.comment_id)
    AS total_engagement

FROM Users u

LEFT JOIN Posts p
ON u.user_id = p.user_id

LEFT JOIN Likes l
ON p.post_id = l.post_id

LEFT JOIN Comments c
ON p.post_id = c.post_id

GROUP BY
u.user_id,
u.user_name

ORDER BY total_engagement DESC;

-- =========================================
-- STEP 20 : SHOW TABLE DATA
-- =========================================

SELECT * FROM Users;
SELECT * FROM Posts;
SELECT * FROM Followers;
SELECT * FROM Comments;
SELECT * FROM Likes;
SELECT * FROM Notifications;
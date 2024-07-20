-- Creating Friends table with dummy data
CREATE TABLE Friends (
    user_id INT,
    friend_id INT
);

-- Creating Likes table with dummy data
CREATE TABLE Likes (
    user_id INT,
    page_id INT
);

-- Insert sample data into Friends table
INSERT INTO Friends (user_id, friend_id)
VALUES
    (1, 2),
    (1, 3),
    (1, 14),
    (2, 3),
    (2, 4),
    (3, 1),
    (3, 4),
    (4, 1),
    (4, 3),
    (5, 2),
    (5, 4),
    (6, 1),
    (6, 5),
    (7, 2),
    (7, 6),
    (8, 3),
    (8, 4),
    (9, 5),
    (9, 6),
    (10, 1),
    (10, 7),
    (11, 2);

-- Insert sample data into Likes table
INSERT INTO Likes (user_id, page_id)
VALUES
    (1, 101),
    (1, 102),
    (2, 101),
    (2, 103),
    (3, 101),
    (3, 102),
    (3, 102),
    (4, 101),
    (4, 102),
    (4, 104)
    (5, 103),
    (6, 101),
    (6, 103),
    (7, 101),
    (7, 102),
    (7, 103),
    (8, 101),
    (9, 102),
    (9, 103),
    (10, 101),
    (10, 102),
    (11, 103),
    (12, 101),
    (13, 102);


-- 1. Find mutual friends of user 1 and user 2.
SELECT f1.friend_id
FROM Friends f1
JOIN Friends f2 ON f1.friend_id = f2.friend_id
WHERE f1.user_id = 1 AND f2.user_id = 2;

-- 2. Common likes between friends: Find the common pages liked by all friends 
-- of a specific user (e.g., user_id 1).
SELECT l.page_id
FROM Friends f
INNER JOIN Likes l
ON f.friend_id = l.user_id
WHERE f.user_id = 1
GROUP BY l.page_id
HAVING COUNT(DISTINCT l.user_id) = (SELECT COUNT(DISTINCT friend_id) 
                                    FROM Friends WHERE user_id = 1);

-- 3. Mutual page likes among friends: Find friends who like the same pages as user 1.
SELECT f.friend_id
FROM Friends f
INNER JOIN Likes l1
ON f.friend_id = l1.user_id
INNER JOIN Likes l2
ON l1.page_id = l2.page_id
WHERE f.user_id = 1 AND l2.user_id = 1
GROUP BY f.friend_id
HAVING COUNT(l1.page_id) = (SELECT COUNT(page_id) FROM Likes WHERE user_id = 1);

-- 4. Users who like all pages: Find users who like all pages liked by user 1.
SELECT l2.user_id
FROM Likes l1
INNER JOIN Likes l2
ON l1.page_id = l2.page_id
WHERE l1.user_id = 1
GROUP BY l2.user_id
HAVING COUNT(DISTINCT l2.page_id) = (SELECT COUNT(DISTINCT page_id) FROM Likes WHERE user_id = 1);

-- 5. Page popularity among friends: Determine the most liked page among friends 
-- of a specific user (e.g., user_id 2).
SELECT l.page_id, COUNT(l.user_id) AS like_count
FROM Friends f
INNER JOIN Likes l
ON f.friend_id = l.user_id
WHERE f.user_id = 2
GROUP BY l.page_id
ORDER BY like_count DESC
LIMIT 1;

-- 6. Recommend all users with pages liked by users friend but not him
SELECT DISTINCT f.user_id, fl.page_id
FROM Friends f
INNER JOIN Likes l 
ON f.friend_id = l.user_id
LEFT JOIN Likes ul 
ON ul.user_id = f.user_id AND ul.page_id = l.page_id
INNER JOIN Likes fl 
ON f.friend_id = fl.user_id AND fl.page_id = l.page_id
WHERE ul.page_id IS NULL;

-- 7. Suggested friends based on mutual likes: Suggest friends for user 3 
-- based on mutual page likes (i.e., friends of friends who like the same pages as user 3).
SELECT f2.friend_id
FROM Friends f1
INNER JOIN Friends f2
ON f1.friend_id = f2.user_id
INNER JOIN Likes l1
ON f2.friend_id = l1.user_id
INNER JOIN Likes l2
ON l1.page_id = l2.page_id
WHERE f1.user_id = 3 AND l2.user_id = 3 AND l1.user_id <> 3
GROUP BY f2.friend_id
HAVING COUNT(l1.page_id) > 1;

-- 8. Friendship triangles: Identify users who form a friendship triangle with user 1
-- (i.e., user 1, user 2, and user 3 are all friends with each other).
SELECT f1.friend_id AS user_a, f2.friend_id AS user_b
FROM friends f1
JOIN friends f2 ON f1.friend_id = f2.user_id
JOIN friends f3 ON f2.friend_id = f3.user_id AND f3.friend_id = f1.user_id
WHERE f1.user_id = 1 AND f2.user_id <> 1 AND f3.user_id <> 1;

-- 9. Friend recommendations: Recommend friends to user 4 based on common friends 
-- (i.e., friends of friends who are not already friends with user 4).
SELECT f2.friend_id
FROM friends f1
JOIN friends f2 
ON f1.friend_id = f2.user_id
WHERE f1.user_id = 4
AND f2.friend_id <> 4
AND f2.friend_id NOT IN (SELECT friend_id FROM Friends WHERE user_id = 4)
GROUP BY f2.friend_id;

-- 10. Common interests in a group: Find the common pages liked by a group of friends 
-- (e.g., user_id 1, 2, and 3).
SELECT l.page_id
FROM Likes l
WHERE l.user_id IN (1, 2, 3)
GROUP BY l.page_id
HAVING COUNT(DISTINCT l.user_id) = 3;

-- 11. Users with maximum mutual friends: Find the user who has the most 
-- mutual friends with user 5.
SELECT f2.user_id, COUNT(f1.friend_id) AS mutual_friend_count
FROM Friends f1
INNER JOIN Friends f2
ON f1.friend_id = f2.friend_id
WHERE f1.user_id = 5 AND f2.user_id <> 5
GROUP BY f2.user_id
ORDER BY mutual_friend_count DESC
LIMIT 1;

-- 12. Page popularity ranking: Rank the pages based on the number of unique users 
-- who like them.
SELECT page_id, COUNT(user_id) as popularity
FROM Likes
GROUP BY page_id
ORDER BY popularity DESC;

-- 13. Friendship path length: Find the shortest path length between user 1 and user 4 
-- (i.e., the minimum number of friendships needed to connect the two users).
-- TO DO: Learn CTE / Recursive CTE



-- 14. Friends who haven't liked any pages: Find friends of user 1 who haven't liked any pages.
SELECT f.friend_id
FROM Friends f
LEFT JOIN Likes l
ON f.friend_id = l.user_id
WHERE f.user_id = 1 AND l.page_id IS NULL;

-- 15. Most active users: Identify the top 3 users with the most number of page likes.
SELECT user_id, COUNT(page_id) AS page_likes
FROM Likes l
GROUP BY user_id
ORDER BY page_likes DESC
LIMIT 3;

-- 16. Friends with similar interests: Find friends of user 2 who have liked at least 
-- 2 of the same pages as user 2.
SELECT f.friend_id
FROM Friends f
INNER JOIN Likes l1
ON f.friend_id = l1.user_id
INNER JOIN Likes l2
ON l1.page_id = l2.page_id
WHERE f.user_id = 2 AND l2.user_id = 2
GROUP BY f.friend_id
HAVING COUNT(DISTINCT l1.page_id) >= 2;

-- 17. All users with a common friend: List all users who share at least 
-- one common friend with user 3.
SELECT f2.user_id
FROM Friends f1
INNER JOIN Friends f2
ON f1.friend_id = f2.friend_id
WHERE f1.user_id = 3
AND f2.user_id <> 3;

-- 18. Most popular user: Find the user with the highest number of friends.
SELECT user_id, COUNT(friend_id) as friend_count
FROM Friends
GROUP BY user_id
ORDER BY friend_count DESC
LIMIT 1;

-- 19. Friends who like all pages of another user: Identify friends of user 4 
-- who have liked all the pages that user 4 has liked.
SELECT f.friend_id
FROM Friends f
JOIN Likes l1 ON f.friend_id = l1.user_id
JOIN Likes l2 ON l1.page_id = l2.page_id
WHERE f.user_id = 4 AND l2.user_id = 4
GROUP BY f.friend_id
HAVING COUNT(DISTINCT l1.page_id) = (SELECT COUNT(DISTINCT page_id) 
                                     FROM Likes WHERE user_id = 4);

-- 20. Pages liked by friends but not by user: List pages liked by friends of user 1 
-- that user 1 hasn't liked.
SELECT *
FROM Friends f
INNER JOIN Likes l
ON f.friend_id = l.user_id
WHERE f.user_id = 1
AND l.page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1);

-- 21. Users with similar friendship patterns: Identify users who have the same friends 
-- as user 2.
SELECT f2.user_id
FROM Friends f1
INNER JOIN Friends f2
ON f1.friend_id = f2.friend_id
WHERE f1.user_id = 2
AND f2.user_id <> 2
GROUP BY f2.user_id
HAVING COUNT(f1.friend_id) = (SELECT COUNT(friend_id) FROM Friends WHERE user_id = 2);

-- 22. Page recommendation: Recommend pages to user 3 based on pages liked by their friends 
-- but not by user 3.
SELECT DISTINCT l.page_id
FROM Friends f
INNER JOIN Likes l
ON f.friend_id = l.user_id
WHERE f.user_id = 3
AND l.page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 3);

-- 23. Friends of friends who like the same pages: Find friends of friends of user 2 
-- who like the same pages as user 2.
SELECT DISTINCT l1.user_id
FROM Friends f1
INNER JOIN Friends f2
ON f1.friend_id = f2.user_id
INNER JOIN Likes l1
ON f2.friend_id = l1.user_id
INNER JOIN Likes l2
ON l1.page_id = l2.page_id
WHERE f1.user_id = 2 AND l1.user_id <> 2 AND l2.user_id = 2;

-- 24. Users who like the most popular page: Identify users who like the most popular page 
-- (i.e., the page liked by the most users).
SELECT user_id
FROM Likes l
WHERE page_id = 
(
  SELECT page_id
  FROM Likes
  GROUP BY page_id
  ORDER BY COUNT(user_id) DESC
  LIMIT 1
);

 -- 25. Page co-likes by friends: Find pairs of pages that are commonly liked together 
 -- by friends of user 1.
 SELECT l1.page_id AS page1, l2.page_id AS page2, COUNT(*) AS co_likes
 FROM Friends f
 INNER JOIN Likes l1
 ON f.friend_id = l1.user_id
 INNER JOIN Likes l2
 ON f.friend_id = l2.user_id
 AND l1.page_id < l2.page_id
 WHERE f.user_id = 1
 GROUP BY l1.page_id, l2.page_id
 ORDER BY co_likes DESC;

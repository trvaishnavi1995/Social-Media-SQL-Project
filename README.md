# Social Media Platform SQL Project

## Project Overview
This project is a complete SQL-based Social Media Platform Database Management System inspired by applications like Instagram and Twitter.

The project demonstrates:
- Database creation
- Table relationships
- Constraints
- CRUD operations
- SQL joins
- Views
- Stored procedures
- Functions
- Triggers
- Social media analytics

---

# Technologies Used
- MySQL
- MySQL Workbench
- SQL

---

# Database Name
```sql
Social_Media
```

---

# Features
- User Management
- Post Management
- Followers System
- Likes & Comments
- Notifications Trigger
- Hashtag Analysis
- Engagement Analytics
- User Activity Reports

---

# Tables Used

| Table Name | Description |
|---|---|
| Users | Stores user details |
| Posts | Stores user posts |
| Followers | Stores follower-following relationships |
| Comments | Stores post comments |
| Likes | Stores likes on posts |
| Notifications | Stores notification messages |

---

# SQL Concepts Implemented

## Constraints
- Primary Key
- Foreign Key
- Unique Constraint
- Default Constraint

---

## SQL Operations
- INSERT
- UPDATE
- DELETE
- SELECT

---

## Filtering
- WHERE
- BETWEEN
- IN
- NULL Checks

---

## Aggregate Functions
- COUNT()
- AVG()
- GROUP BY
- HAVING()
- ORDER BY
- LIMIT

---

## Joins
- INNER JOIN
- LEFT JOIN

---

## Advanced SQL
- UNION
- Views
- Stored Procedures
- Functions
- Triggers
- Subqueries

---

# Function Used

## UserEngagement(user_id)
Returns total likes and comments made by a user.

Example:
```sql
SELECT UserEngagement(1);
```

---

# Stored Procedure

## AllPost(username)
Returns all posts created by a user.

Example:
```sql
CALL AllPost('saranya');
```

---

# View Created

## post_summary
Displays:
- Post ID
- Username
- Caption
- Total Likes
- Total Comments

---

# Trigger

## insert_notification
Automatically inserts notifications when a user likes a post.

---

# Analytics Performed
- Top Influencers
- Trending Hashtags
- User Engagement Analysis
- Virality Reports
- Follower Growth Analysis
- Weekly Posting Activity

---

# Sample Queries

## Top Active Users
```sql
SELECT user_id, COUNT(*) AS total_posts
FROM Posts
GROUP BY user_id
ORDER BY total_posts DESC;
```

---

## Trending Hashtags
```sql
SELECT hashtag, COUNT(*) AS usage_count
FROM Posts
GROUP BY hashtag
ORDER BY usage_count DESC;
```

---

# Project Structure

```text
Social-Media-SQL-Project/
│
├── social_media_project.sql
├── README.md
└── screenshots/
```

---

# Learning Outcomes
Through this project, I learned:
- Relational Database Design
- SQL Query Optimization
- Handling Relationships using Foreign Keys
- Advanced SQL Programming
- Trigger and Procedure Implementation
- Data Analytics using SQL

---

# Conclusion
This project demonstrates an end-to-end implementation of a Social Media Database System using MySQL. It showcases both database management and analytical capabilities using advanced SQL concepts.


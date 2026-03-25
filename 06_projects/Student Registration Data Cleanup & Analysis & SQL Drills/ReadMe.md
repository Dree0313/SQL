📘 Project: Student Registration Data Cleanup & Analysis
🎯 Goal

By the end of this project, you will be able to:

Identify duplicate records
Analyze enrollment patterns
Write increasingly complex SELECT queries
Build the foundation needed to solve real-world data issues (like duplicate enrollments)
🧪 Dataset (You’ll Use This Table)
CREATE TABLE registrations (
    registration_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    term VARCHAR(20)
);

You can insert sample data like this (add more later if you want):

INSERT INTO registrations VALUES
(1, 101, 501, 'Fall2025'),
(2, 101, 501, 'Fall2025'), -- duplicate
(3, 102, 502, 'Fall2025'),
(4, 103, 503, 'Spring2026'),
(5, 101, 504, 'Spring2026'),
(6, 102, 502, 'Fall2025'), -- duplicate
(7, 104, 505, 'Fall2025');
🧩 SQL Practice Questions (Easiest → Hardest)
🟢 1. Basic Retrieval

Question:
Retrieve all records from the registrations table.

🟢 2. Filtering

Question:
Find all registrations for the term 'Fall2025'.

🟡 3. Grouping

Question:
Count how many registrations each student has.

🟡 4. Detect Potential Duplicates

Question:
Find combinations of student_id, course_id, and term that appear more than once.

(This is where things start getting real-world relevant 👀)

🔴 5. Identify Exact Duplicate Rows

Question:
Retrieve all rows that are duplicates based on student_id, course_id, and term.

(This is the closest stepping stone to your interview question—master this and you’re almost there.)

📄 README (For Your Project)

You can copy this into a README.md file:

Student Registration SQL Project
📌 Overview

This project is designed to strengthen SQL skills with a focus on data analysis and duplicate detection. The dataset simulates a student registration system where duplicate enrollments may occur.

🎯 Objectives
Practice writing SELECT queries
Learn how to filter and group data
Identify duplicate records in a dataset
Build foundational skills for real-world data cleaning tasks
🗂️ Table Structure

registrations

Column	Description
registration_id	Unique ID for each registration
student_id	ID of the student
course_id	ID of the course
term	Academic term (e.g., Fall2025)
🧪 Key Skills Practiced
Basic SELECT queries
Filtering with WHERE
Aggregation with COUNT
GROUP BY and HAVING
Identifying duplicate data patterns
🚀 Progression

This project starts with simple queries and builds toward more advanced data analysis tasks, preparing the user to handle real-world database issues like duplicate records and data integrity.

🔥 End Goal

By completing this project, you should be able to confidently approach problems involving duplicate data and understand how to analyze and troubleshoot them using SQL.

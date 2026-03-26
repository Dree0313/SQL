Project: Student Registration Data Cleanup & Analysis

Goal:
By the end of this project, you will be able to:

Identify duplicate records
Analyze enrollment patterns
Write increasingly complex SELECT queries
Build the foundation needed to solve real-world data issues (like duplicate enrollments)


Overview
This project is designed to strengthen SQL skills with a focus on data analysis and duplicate detection. The dataset simulates a student registration system where duplicate enrollments may occur.

Objectives
Practice writing SELECT queries
Learn how to filter and group data
Identify duplicate records in a dataset
Build foundational skills for real-world data cleaning tasks

Table Structure
Name: registrations
Column    Description
registration_id	Unique ID for each registration
student_id	ID of the student
course_id	ID of the course
term	Academic term (e.g., Fall2025)

Key Skills Practiced
Basic SELECT queries
Filtering with WHERE
Aggregation with COUNT
GROUP BY and HAVING
Identifying duplicate data patterns

Progression
This project starts with simple queries and builds toward more advanced data analysis tasks, preparing the user to handle real-world database issues like duplicate records and data integrity.

End Goal
By completing this project, you should be able to confidently approach problems involving duplicate data and understand how to analyze and troubleshoot them using SQL.


Dataset (You’ll Use This Table towards the end of the project)
CREATE TABLE registrations (
    registration_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    term VARCHAR(20)
);

You can insert sample data like this:

INSERT INTO registrations VALUES
(1, 101, 501, 'Fall2025'),
(2, 101, 501, 'Fall2025'), -- duplicate
(3, 102, 502, 'Fall2025'),
(4, 103, 503, 'Spring2026'),
(5, 101, 504, 'Spring2026'),
(6, 102, 502, 'Fall2025'), -- duplicate
(7, 104, 505, 'Fall2025');
(8, 103, 503, 'Spring2026'); -- duplicate


## What the project consists of

Step 1: You will complete 5 Select queries that become progressively harder. If you can complete these scenarios on your own, you will advance to step 2, otherwise, you repeat the step with new questions

Step 2: You will complete 5 modifications that become progressively harder. If you can complete these scenarios on your own, you will advance to step 3, otherwise, you repeat the step with new questions

Step 3: You will complete the following scenario:

You are working as a junior database analyst for a university’s registration system.

Recently, the academic department reported an issue:
students are appearing multiple times in the same course for the same term. This is causing:

inaccurate enrollment counts
billing errors
reporting inconsistencies

You’ve been asked to investigate the issue using the registrations table.

Table Structure
registrations (
    registration_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    term VARCHAR(20)
)

Problem
Due to a system bug, duplicate enrollments have been created where:
the same student
is enrolled in the same course
during the same term
more than once
Your Tasks (Interview Style)

1. Investigation

Write a query to identify whether duplicates exist in the table.

2. Impact Analysis

Determine how widespread the issue is:

Which students are affected?
How many duplicate enrollments exist per case?

3. Data Inspection

Retrieve the full records that are considered duplicates so they can be reviewed manually.

4. Business Awareness (Conceptual — no code required yet)

Explain:

Why duplicate records like this are a problem
What kind of real-world issues they could cause

5. Prevention Thinking

Describe:

What could have caused this issue in the system
What kind of database-level or application-level safeguards might prevent it




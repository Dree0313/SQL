--INSERT INTO registrations VALUES (1, 101, 501, 'Fall2025'), (2, 101, 501, 'Fall2025'), -- duplicate (3, 102, 502, 'Fall2025'), (4, 103, 503, 'Spring2026'), (5, 101, 504, 'Spring2026'), (6, 102, 502, 'Fall2025'), -- duplicate (7, 104, 505, 'Fall2025'); (8, 103, 503, 'Spring2026'); -- duplicate

--You are working as a junior database analyst for a university’s registration system.

--Recently, the academic department reported an issue: students are appearing multiple times in the same course for the same term. This is causing:

--inaccurate enrollment counts billing errors reporting inconsistencies

--You’ve been asked to investigate the issue using the registrations table.

--Table Structure registrations ( registration_id INT PRIMARY KEY, student_id INT, course_id INT, term VARCHAR(20) )

--Problem Due to a system bug, duplicate enrollments have been created where: the same student is enrolled in the same course during the same term more than once Your Tasks (Interview Style)

--Investigation
--Write a query to identify whether duplicates exist in the table.

SELECT student_id, course_id, term
FROM registrations
GROUP BY student_id, course_id, term
HAVING COUNT(*) > 1;

--Data Update
--Remove the records that are considered duplicates.

BEGIN TRANSACTION;

DELETE FROM registrations
WHERE student_id IN (
  SELECT student_id, ROW_NUMBER() OVER (PARTITION BY)
  FROM registrations
  GROUP BY student_id, course_id, term
  HAVING COUNT(*) > 1
)

Business Awareness (Conceptual — no code required yet)
Explain:

Why duplicate records like this are a problem What kind of real-world issues they could cause

Prevention Thinking
Describe:

What could have caused this issue in the system What kind of database-level or application-level safeguards might prevent it

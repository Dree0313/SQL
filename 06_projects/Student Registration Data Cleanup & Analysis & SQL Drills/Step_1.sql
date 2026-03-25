--🟢 1. Basic Data Check (Easy)

--Scenario:
--Before investigating the issue, your manager asks you to quickly review the data.

--Task:
--Retrieve all records from the registrations table.
SELECT *
FROM registrations;


--🟢 2. Focused Filtering (Easy → Medium)

--Scenario:
--The issue was first noticed in a specific term.

--Task:
--Find all registrations for a single term (e.g., 'Fall2025').

SELECT *
FROM registrations
WHERE term IS 'Fall2025';

-- This query was incorrect due to my use of IS instead of =. Correct query below:

SELECT *
FROM registrations
WHERE term = 'Fall2025';

--🟡 3. Enrollment Patterns (Medium)

--Scenario:
--You want to understand student activity to spot anything unusual.

--Task:
--Count how many total registrations each student has across all terms.

SELECT COUNT *
FROM registrations
WHERE 

-- I was unable to determine the correct query for this scenario. 
-- I should have selected student_id
-- My usage of COUNT * was also incorrect. It should have been COUNT(*)
-- Instead of using WHERE, I should have used GROUP BY
-- Below is the correct query:

SELECT student_id, COUNT(*) AS total_registration
FROM registrations
GROUP BY student_id;

-- This works because it selects the student's ID and counts all rows from the table registrations
-- It then groups by the student ID listing which means that it groups rows with the same value
  -- a single row.

-- Revised: This query groups all rows by student_id, meaning each unique student forms its own
  -- group. The COUNT(*) function then counts how many rows exist within each group, giving the
  -- total number of registrations per student.


--🟡 4. Duplicate Detection (Medium → Hard)

--Scenario:
--You suspect duplicates exist but need proof.

--Task:
--Identify combinations of:

--student_id
--course_id
--term

--that appear more than once.

SELECT student_id, course_id, term, COUNT(*) AS total_registration
FROM registrations
GROUP BY;

--I discontinued this problem because I thought that I was unable to group by more than one column.
--If I had not stopped, I likely would have added student_id, course_id, and term and ended from there.
--This would not have been correct because I would need to add a HAVING clause that would count all
  -- respective column rows that already exist
-- The correct query is below:

SELECT student_id, course_id, term, COUNT(*) AS total_registration
FROM registrations
GROUP BY student_id, course_id, term
HAVING COUNT(*) > 1;

--🔴 5. Full Duplicate Investigation (Hard)

--Scenario:
--Now the department wants to see the actual bad data so they can review it.

--Task:
--Retrieve all rows that are duplicates based on:

--student_id
--course_id
--term

--(Not just counts—the actual records.)

SELECT student_id, course_id, term
FROM registrations
WHERE COUNT(*) > 1
GROUP BY student_id, course_id, term;

-- Since WHERE is an aggregate function, I cannot use COUNT(*) here
-- Aggregate functions perform calculation on a set of values (multiple) rows and return a single summary value
-- GROUP BY groups rows and therefore has to be used for COUNT(*) to count groups
-- I am also returning grouped summaries and should be returning the actual duplicated records
-- Correct Query below:

SELECT *
FROM registrations
WHERE (student_id, course_id, term) IN (
  SELECT student_id, course_id, term
  FROM registrations
  GROUP BY student_id, course_id, term
  HAVING COUNT(*) > 1
);

-- This works because it selects all columns from the registrations table where the columns
  -- student_id, course_id, and term have a count greater than 1

-- Revised: The inner query groups records by student_id, course_id, and term, and uses HAVING
  -- COUNT(*) > 1 to identify combinations that appear more than once, which indicates duplicates.
  -- The outer query then selects all rows from the registrations table where those same combinations
  -- exist, using a tuple comparison in the IN clause. This returns the full records associated with
  -- the duplicate entries, not just the grouped summary.


--🟢 6. Student Enrollment Overview (Easy)

--Scenario:
--The registrar wants to see how many courses each student is enrolled in this term.

--Task:
--List each student and the total number of courses they are taking for 'Spring2026'.

--Hint:
--Think WHERE + GROUP BY.

🟢 7. Popular Courses (Easy → Medium)

Scenario:
The department wants to know which courses are most popular this term.

Task:
Find all courses for 'Spring2026' and the number of students enrolled in each, sorted by most students first.

Hint:
You’ll need GROUP BY course_id and ORDER BY.

🟡 8. Cross-Term Attendance (Medium)

Scenario:
Some students take the same course multiple times (retakes).

Task:
Identify students who are enrolled in the same course across multiple terms.

Hint:
Use GROUP BY student_id, course_id and HAVING COUNT(DISTINCT term) > 1.

🟡 9. Course Load Alert (Medium → Hard)

Scenario:
Advisors want to identify students who are overloaded, i.e., enrolled in more than 4 courses in a single term.

Task:
Return student_id, term, and the number of courses, but only show those who exceed 4 courses.

Hint:
GROUP BY student_id, term + HAVING.

🔴 10. Duplicate Registrations Across Departments (Hard)

Scenario:
Occasionally, system errors cause students to be registered multiple times for courses even in different departments (e.g., two sections of the same course code).

Task:
Find all duplicate registrations for the same student in the same course code, ignoring term differences, and return all details for review.

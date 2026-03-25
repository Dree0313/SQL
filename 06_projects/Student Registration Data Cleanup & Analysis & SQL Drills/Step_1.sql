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

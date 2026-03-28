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

SELECT student_id, COUNT(*) AS total_courses
FROM registrations
WHERE term = 'Spring2026'
GROUP BY student_id;

--🟢 7. Popular Courses (Easy → Medium)

--Scenario:
--The department wants to know which courses are most popular this term.

--Task:
--Find all courses for 'Spring2026' and the number of students enrolled in each, sorted by most students first.

--Hint:
--You’ll need GROUP BY course_id and ORDER BY.

SELECT course_id, COUNT(*) AS number_of_students
FROM registrations
WHERE term = 'Spring2026'
GROUP BY number_of_students
ORDER BY number_of_students DESC;

-- This query is incorrect since I cannot group by an aggregate alias
-- correct query:

SELECT course_id, COUNT(*) AS number_of_students
FROM registrations
WHERE term = 'Spring2026'
GROUP BY course_id
ORDER BY number_of_students DESC;


--🟡 8. Cross-Term Attendance (Medium)

--Scenario:
--Some students take the same course multiple times (retakes).

--Task:
--Identify students who are enrolled in the same course across multiple terms.

--Hint:
--Use GROUP BY student_id, course_id and HAVING COUNT(DISTINCT term) > 1.

SELECT student_id, course_id
FROM registrations
GROUP BY student_id, course_id
HAVING COUNT(DISTINCT term) > 1;

--🟡 9. Course Load Alert (Medium → Hard)

--Scenario:
--Advisors want to identify students who are overloaded, i.e., enrolled in more than 4 courses in a single term.

--Task:
--Return student_id, term, and the number of courses, but only show those who exceed 4 courses.

--Hint:
--GROUP BY student_id, term + HAVING.

SELECT student_id, term, COUNT(*) AS number_of_courses
FROM registrations
GROUP BY student_id, term
HAVING COUNT(*) > 4;

--🔴 10. Duplicate Registrations Across Departments (Hard)

--Scenario:
--Occasionally, system errors cause students to be registered multiple times for courses even in different departments (e.g., two sections of the same course code).

--Task:
--Find all duplicate registrations for the same student in the same course code, ignoring term differences, and return all details for review.

SELECT *
FROM registrations
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- This is incorrect because I selected all and didn't group or aggregate all the other columns
-- correct query below:

SELECT *
FROM registrations
WHERE (student_id, course_id) IN (
  SELECT student_id, course_id
  FROM registrations
  GROUP BY student_id, course_id
  HAVING COUNT(*) > 1
);

-- This works because I can select columns student_id and course_id from the table and group each
  -- student by the course_id and for any results that occur more than once, they are returned,
  -- and all columns for each result is also returned

-- Revised: The subquery groups the table by student_id and course_id to identify combinations that
  -- more than once using HAVING COUNT(*) > 1. The outer query then selects all rows from registrations
  -- where the (student_id, course_id) pair matches those duplicate combinations, allowing us to return
  -- full row details instead of aggregated results.


--🟢 11. Inactive Students (Easy → Medium)

--Scenario:
--The registrar wants to identify students who have not enrolled in any courses for the term 'Spring2026'.

--Task:
--Return all student_ids who are not present in the registrations table for 'Spring2026'.

SELECT student_id
FROM registrations
WHERE term != 'Spring2026';

-- This is incorrect because it instead returns students who have at least 1 term that is not 'Spring2026'
-- Correct Query below:

SELECT DISTINCT student_id
FROM registrations
WHERE student_id NOT IN (
  SELECT student_id
  FROM registrations
  WHERE term = 'Spring2026'
);

-- This works because it makes sure that the student's id is not returned more than once by using Distinct.
-- It also uses a subquery to determine the students who do have a registration witihin the 'Spring2026'
  -- term and instead returns the student's ids that are not within that result.

-- Revised The subquery selects all student_id who are enrolled in 'Spring2026'. The outer query then
  -- returns all distinct student_id from the registrations table excluding those found in the subquery,
  -- excluding those found in the subquery, ensuring we only get students with no enrollments in that
  -- term

--🟡 12. Single-Course Students (Medium)

--Scenario:
--Advisors want to find students who are taking only one course in a given term.

--Task:
--Return student_id, term, and total number of courses for students enrolled in exactly one course during 'Spring2026'.

SELECT DISTINCT student_id
FROM registrations
WHERE student_id IN (
  SELECT student_id, course_id, term
  FROM registrations
  GROUP BY student_id, term
  HAVING COUNT(*) = 1
);

-- This is incorrect because In eexpects one column, not three. I did not filter by the specific
  -- term either. Correct query below:

SELECT student_id, term, COUNT(*) AS number_of_courses
FROM registrations
WHERE term = 'Spring2026'
GROUP BY student_id, term
HAVING COUNT(*) = 1;

-- This works because the query pulls all Spring2026 term results and groups them by the student
  -- id and term. It then determines the results that only occur once. It can then return the student_id,
  -- term, and the amount of times they occur with the database. ✅

-- Professional: The query filters registrations to 'Spring2026', then groups the data by student_id
  -- and term. Using Count(*), it calculates how many courses each student is enrolled in and HAVING
  -- COUNT(*) = 1 ensures only students taking exactly one course are returned

--🟡 13. Most Recent Enrollment (Medium → Hard)

---Scenario:
--The system tracks multiple enrollments over time, and administrators want to see the latest course each student enrolled in.

--Task:
--Return each student_id along with their most recent term.

SELECT student_id, term AS most_recent_term
FROM registrations
WHERE MAX(term);

-- Again, MAX() is an aggregate like COUNT() and cannot be used in WHERE. It must be used as a subquery
  -- or with GROUP BY

SELECT student_id, MAX(term) AS most_recent_term
FROM registrations
GROUP BY student_id;

-- This works because the query returns the student_id associated with the maximum term within registrations.
  -- This only likely works since Fall comes first. I question whether this will work if summer was also
  -- within the table

-- Refined: The query groups records by student_id and uses MAX(term) to determine the most recent
  -- term for each student, returning one row per student with their latest enrollment term

--🔴 14. Course Overlap Pairs (Hard)

--Scenario:
--The university wants to identify students who are taking the exact same set of courses in the same term (potential study partners).

--Task:
--Return pairs of student_ids who are enrolled in the same courses during 'Spring2026'.

SELECT student_id, course_id, term
FROM registrations
WHERE term = 'Spring2026'

-- I discontinued this question because I reasoned that I'm not sure how to return 2 values of the
  -- same column

SELECT s1.student_id, s2.student_id
FROM (
  SELECT student_id, STRING_AGG(course_id, ',' ORDER BY course_id) AS courses
  FROM registrations
  WHERE term = 'Spring2026'
  GROUP BY student_id) AS s1
JOIN (
  SELECT student_id, STRING_AGG(course_id, ',' ORDER BY course_id) AS courses
  FROM registrations
  WHERE term = 'Spring2026'
  GROUP BY student_id) AS s2 ON s1.courses = s2.courses AND s1.student_id < s2.student_id;

-- I'm not sure what STRING_AGG() does, but this works because the first subquery determines the 
  -- results where term is equal to 'Spring2026' and groups by the student_id and then sets that 
  -- result as s1. It then does the same for s2. It then determines whether their student_id's courses
  -- match and verifies that s1 and s2 are not equal.

-- Refined: STRING_AGG() is an aggregate function that combines multiple row values into a single
  -- string. Each subquery aggregates the courses for each student in Spring2026 into a sorted string
  -- using STRING_AGG(). The query then self-joins on this aggregated result to find students whose
  -- course lists are identical, returning unique student pairs.


--🔴 15. Department Load Distribution (Hard)

--Scenario:
--Each course belongs to a department, and administrators want to analyze student workload distribution.

--Task:
--Return each student_id and the number of distinct departments they are enrolled in during 'Spring2026', but only include students taking courses in more than 2 departments.

SELECT student_id, course_id, DISTINCT COUNT(*) AS number_of_departments
FROM (
  SELECT course_id
  FROM registrations
  WHERE term = 'Spring2026'
  HAVING COUNT(*) > 2
);

-- This is incorrect due to invalid syntax. Instead of DISTINCT COUNT(*) it should be COUNT(DISTINCT 
  -- departmment_id). Instead of selecting course_id for the subquery, it should have been department_id.
-- Since there is no GROUP BY, HAVING COUNT(*) is invalid and doesn't relate to student_id. This is 
  -- also a direct aggregate problem and not a subquery one

SELECT student_id, COUNT(DISTINCT department_id) AS number_of_departments
FROM registrations
WHERE term = 'Spring2026'
GROUP BY student_id
HAVING COUNT(DISTINCT department_id) > 2;

-- This works because the query pulls results wheere the term is equal to Spring2026, groups the 
  -- results by the student_id and then filters out the results that more than 2 unique department_id.
-- It then returns the columns of student_id and the number of unique departments that student_id appears in 

-- Revision: The query filters registrations to 'Spring2026', groups the data by student_id, and counts the number
  -- of distinct departments each student is enrolled in. The HAVING clause ensures that only students
  -- enrolled in more than two unique departments are returned

--🟢 16. Repeat Students Per Term (Easy → Medium)

--Scenario:
--The university wants to know how many students are returning each term.

--Task:
--Return each term and the number of distinct students enrolled in that term.

SELECT term, COUNT(DISTINCT student_id) AS number_of_students
FROM registrations
GROUP BY term;

--🟡 17. Multi-Term Students (Medium)

--Scenario:
--Some students stay enrolled across multiple terms, and administrators want to track long-term engagement.

--Task:
--Return all student_ids who have enrolled in more than one distinct term.

SELECT student_id
FROM registrations
GROUP BY student_id
HAVING COUNT(DISTINCT term) > 1;

--🟡 18. Course Enrollment Threshold (Medium)

--Scenario:
--Departments want to identify courses that are underperforming.

--Task:
--Return all course_ids that have fewer than 3 students enrolled in 'Spring2026'.

SELECT course_id
FROM registrations
WHERE term = 'Spring2026'
GROUP BY course_id
HAVING COUNT(student_id) < 3;

--🟡 19. Students Taking Same Course Twice in Same Term (Medium)

--Scenario:
--A system bug may allow students to accidentally register for the same course multiple times in the same term.

--Task:
--Find all cases where a student_id is registered for the same course_id more than once within the same term, and return the student_id, course_id, and term.

SELECT student_id, course_id, term
FROM registrations
WHERE term = 'Spring2026'
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- This query is incorrect because SQL requires that every selected column be grouped

SELECT student_id, course_id, term
FROM registrations
WHERE term = 'Spring202'
GROUP BY student_id, course_id, term
HAVING COUNT(*) > 1;

--🔴 20. Most Popular Term (Hard)
--Scenario:

--The university wants deeper insight into enrollment trends—not just the most popular term, but also how it compares to others.

--Task:

--Return the term(s) that have the highest total number of registrations.

SELECT term, COUNT(registration_id) AS total_number_registrations
FROM registrations
GROUP BY term
HAVING MAX(total_number_registrations);


SELECT term, COUNT(registration_id) AS total_number_registrations
FROM registrations
GROUP BY term
HAVING COUNT(registration_id) = (
  SELECT MAX(term_count)
  FROM (
    SELECT COUNT(registration_id) AS term_count
    FROM registrations
    GROUP BY term) AS term_totals
);


-- This works because it returns the results of the total number of registrations per term. It
  -- then selects the term or terms with the maximum total. Lastly, it groups by terms and filters for the 
  -- amount of registrations equal to that maximum total and teturns the total amount of registrations
  -- and term. I'm not sure why that last part isn't redundant though.

-- Revised: The inner query calculates the total number of registrations for each term, then finds
  -- the maximum of those totals. This gives us a single value representing the highest enrollment
  -- across all terms. The outer query then groups registrations by term again and compares term's
  -- total to that maximum value. It filters to only return the term(s) whose registration count matches
  -- the highest total

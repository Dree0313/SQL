--🟢 1. Basic Data Check (Easy)

--Scenario:
--Before investigating the issue, your manager asks you to quickly review the data.

--Task:
--Retrieve all records from the registrations table.
SELECT *
FROM registrations; ✅


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
GROUP BY student_id; ✅

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
HAVING COUNT(DISTINCT term) > 1; ✅

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
HAVING COUNT(*) > 4; ✅

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
GROUP BY term; ✅

--🟡 17. Multi-Term Students (Medium)

--Scenario:
--Some students stay enrolled across multiple terms, and administrators want to track long-term engagement.

--Task:
--Return all student_ids who have enrolled in more than one distinct term.

SELECT student_id
FROM registrations
GROUP BY student_id
HAVING COUNT(DISTINCT term) > 1; ✅

--🟡 18. Course Enrollment Threshold (Medium)

--Scenario:
--Departments want to identify courses that are underperforming.

--Task:
--Return all course_ids that have fewer than 3 students enrolled in 'Spring2026'.

SELECT course_id
FROM registrations
WHERE term = 'Spring2026'
GROUP BY course_id
HAVING COUNT(student_id) < 3; ✅

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
WHERE term = 'Spring2026'
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

--🟢 21. Student Registration by Course (Easy → Medium)

--Scenario:
--The department wants a quick overview of which students are enrolled in each course.

--Task:
--Return each course_id along with a list of distinct student_ids enrolled in that course.

SELECT student_id, course_id
FROM registrations
GROUP BY student_id, course_id;

-- This is incorrect because I returned each row of students and courses. Instead I should be returning
  -- each course and then the list of students that take that course. I also missed the task portion,
  -- so I likely would have used Distinct at least.

SELECT course_id, STRING_AGG(DISTINCT student_id::text, ', ') AS students
FROM registrations
GROUP BY course_id;

-- This works because the query filters the registration table by grouping each individual course and
  -- then filters the student_id based on whether the student is enrolled in the course. It does this by concatenating
  -- each one with a comma and space to create a list.

-- Revised: This works becaus the query groups all rows by course_id, so each group represents a single
  -- course. Then, STRING_AGG combines all distinct student_ids within each group into a single comma-separated
  -- list

--🟡 22. Students Skipping Terms (Medium)

--Scenario:
--Advisors want to identify students who did not register in consecutive terms.

--Task:
--Return all student_ids who were enrolled in Fall2025 but not in Spring2026.

SELECT student_id
FROM registrations
WHERE student_id IN (
  SELECT student_id
  FROM registrations
  WHERE term = 'Fall2025'
)
AND student_id NOT IN (
  SELECT student_id
  FROM registrations
  WHERE term = 'Spring2026'
); ✅

--🟡 23. Students Enrolled in Multiple Departments (Medium → Medium+)

--Scenario:
--Some students are taking courses across multiple departments in a single term.

--Task:
--Return student_id and the number of distinct departments they are enrolled in for Spring2026, including only students in more than 1 department.

SELECT student_id, COUNT(DISTINCT department_id) AS number_of_departments
FROM registrations
WHERE term = 'Spring2026'
GROUP BY student_id
HAVING number_of_departments > 1;

-- This is incorrect because an alias cannot be referenced in HAVING for standard SQL.

SELECT student_id, COUNT(DISTINCT department_id) AS number_of_departments
FROM registrations
WHERE term = 'Spring2026'
GROUP BY student_id
HAVING COUNT(DISTINCT department_id) > 1;

--🔴 24. Courses with Repeated Enrollment Across Terms (Medium → Hard)

--Scenario:
--The university wants to identify courses that have students returning to the same course in different terms.

--Task:
--Return all course_ids along with the student_ids who have enrolled in them more than once across different terms.

SELECT course_id, student_id
FROM registrations
WHERE student_id IN (
  SELECT student_id, course_id
  FROM registrations
  GROUP BY student_id, course_id
  HAVING COUNT(DISTINCT term) > 1
);

-- This is incorrect because SQL doesn't allow selecting multiple columns in an IN subquery. To match
  -- multiple columns, I would have to use a tuple.

SELECT course_id, student_id
FROM registrations
WHERE (student_id, course_id) IN (
  SELECT student_id, course_id
  FROM registrations
  GROUP BY student_id, course_id
  HAVING COUNT(DISTINCT term) > 1
);

--🔴 25. Students with Same Course Load (Hard)

--Scenario:
--Advisors want to identify groups of students taking the exact same set of courses in a given term to analyze patterns or recommend study groups.

--Task:
--Return pairs of student_ids who are enrolled in the same set of courses in Spring2026.

SELECT s1.student_id, s2.student_id
FROM registrations
WHERE term = 'Spring2026'
JOIN

-- I am still unable to recall how to perform a self join. Join must come before WHERE

SELECT s1.student_id, s2.student_id
FROM registrations s1
JOIN registrations s2 ON s1.student_id < s2.student_id
WHERE s1.term = 'Spring2026' AND s2.term = 'Spring2026'
GROUP BY s1.student_id, s2.student_id
HAVING COUNT(DISTINCT s1.course_id) = COUNT(DISTINCT s2.course_id)
  AND COUNT(DISTINCT s1.course_id) = COUNT(DISTINCT CASE
    WHEN s1.course_id = s2.course_id THEN s1.course_id END);

-- This works because the query self joins the student_id column. This makes it possible to compare
  -- 2 different values from the column by ensuring that the two values, s1 and s2, are not equivalent. Then the
  -- query verifies that both s1 and s2 are both enrolled in the Spring2026 term. The query groups the
  -- columns s1 and s2 and filters to ensure that s1 is enrolled in the same amount of distinct courses
  -- as s2, and then verifies that the distinct amount of of course for s1 is equal to the amount of 
  -- distinct cases when s1 and s2 course_ids are equal.

-- Revised: This works becaus the query performs a self-join on the registrations table creating pairs
  -- of different students (s1 and s2) using the condition s1.student_id < s2.studnet_id to avoid duplicate
  -- and self pairs. It then filters both sides to only include registrations from Spring2026. The query
  -- groups by each pair of students, allowing us to compare their course enrollments as sets. The first
  -- HAVING condition ensures both students are enrolled in the same number of distinct courses. The second
  -- HAVING condition ensures both students are enrolled in the same number of distinct courses. Together,
  -- these conditions guarantee that the two students are enrolled in the exact same set of courses.

--🟡 26. Courses With No Enrollments (Medium)

--Scenario:
--The university wants to identify courses that are not attracting any students for a given term.

--Task:
--Return all course_ids from the courses table that have no registrations in Spring2026.

SELECT course_id 
FROM courses
WHERE course_id NOT IN (
  SELECT course_id
  FROM registrations
  WHERE term = 'Spring2026'
); ✅

--🟡 27. Average Courses Per Student (Medium)

--Scenario:
--The registrar wants to understand student workload.

--Task:
--Return the average number of courses per student in Spring2026.

SELECT AVG(course_amount)
FROM registrations
WHERE course_id IN (
  SELECT course_id, student_id, COUNT(course_id) AS number_of_courses
  FROM registrations
  WHERE term = 'Spring2026'
) AS course_amount;

-- This is incorrect because IN only takes one column, this is a two step aggregation problem, not
  -- filtering, and I can't alias a subquery inside WHERE in this way.

SELECT AVG(course_count) AS avg_courses_per_student
FROM (
  SELECT student_id, COUNT(course_id) AS course_count
  FROM registrations
  WHERE term = 'Spring2026'
  GROUP BY student_id
) AS student_courses

-- This works because the inner query uses the registrations table and filters only the rows where
  -- term is equal to 'Spring2026' and then groups by the student_id. It then returns the student_id
  -- column and number of courses for each student. In the outer query, it then places the number of courses for each student
  -- in the aggregate function, AVG(), returning the average amount of courses per student for the Spring2026 term ✅

--🟡 28. Most Recent Term Per Student (Medium)

--Scenario:
--Advisors want to know the last term each student was active.

--Task:
--Return each student_id along with their most recent term.

SELECT student_id, term
FROM (
  SELECT student_id, term
  FROM registrations
  GROUP BY student_id, term
  HAVING MAX(term)
);

-- I seem to have over complicated this query. I cannot use an aggregate function in HAVING without
  -- proper grouping. It also doesn't require a subquery

SELECT student_id, MAX(term) AS most_recent_term
FROM registrations
GROUP BY student_id;

-- This works because it groups the registration table by student_id. It then SELECTS the rows containing
  -- the maximum term value for each student_id ✅


--🟡 29. Courses With Above Average Enrollment (Medium → Medium+)

--Scenario:
--The university wants to highlight popular courses.

--Task:
--Return course_ids that have more registrations than the average number of registrations across all courses.

SELECT course_id, AVG(number_of_courses)
FROM (
  SELECT COUNT(course_id) number_of_courses
  FROM registrations
  GROUP BY student_id, course_id
)
GROUP BY student_id, course_id
HAVING AVG(course_id) > number_of_courses

-- This is incorrect because AVG(number_of_courses) is being used incorrectly. I can't directly compare
  -- a per-course count with AVG(course_id) because I didn't use count to make the input parameter numerical.
  -- The inner query should also calculate the total number os students per course, not per student_id, course_id
  -- because each row is already per student-course. Also the HAVING clause should compare the course's count with
  -- the overall average, and not the course ID.

SELECT course_id, COUNT(*) AS total_registration
FROM registrations
GROUP BY course_id
HAVING COUNT (*) > (
  SELECT AVG(course_count)
  FROM (
    SELECT COUNT(*) AS course_count
    FROM registrations
    GROUP BY course_id) AS course_totals
);

-- This works because the most inner query groups by course_id from the registration table and then returns
  -- the amount of times each course_id occurs. The least inner query then takes the average of those totals.
  -- The outer query then groups by course_id from the registrations table and compares the amount of times
  -- each course occurs to the average of all the courses in total. Then the course_id and count are total
  -- occurances are returned

-- Revised: The innermost query groups the registration table by course_id and counts how many times
  -- each course appears, producing the total registrations per course (course_count). The middle query
  -- takes those counts and calculates the average number of registrations across all courses using
  -- AVG(course_count). The outer query again groups the registrations table by course_id and counts
  -- registrations per course. The HAVING clause filters the results to include only courses where the
  -- total registration are greater than the overall average.
  
--🟡 30. Students Enrolled in All Courses (Medium → Medium+)

--Scenario:
--The university is looking for highly engaged students who take every available course in a term.

--Task:
--Return student_ids who are enrolled in every course offered in Spring2026.

SELECT student_id
FROM registrations
GROUP BY student_id, course_id
HAVING COUNT(DISTINCT course_id) = (
  SELECT COUNT(DISTINCT course_id) AS max_courses
  FROM registrations
  WHERE term = 'Spring2026'
  GROUP BY course_id
);

-- This is incorrect because I grouped by student_id, course_id which disables the ability to count
  -- per student. The subquery is also incorrect. I don't need to group by course_id and I should have
  -- queried the outer query to 'Spring2026'

SELECT student_id
FROM registrations
WHERE term = 'Spring2026'
GROUP BY student_id
HAVING COUNT(DISTINCT course_id) = (
  SELECT COUNT(DISTINCT course_id)
  FROM registrations
  WHERE term = 'Spring2026'
);

-- This works because the inner query filters all rows with a term equal to 'Spring2026' from the registrations
  -- table. It then counts each unique course_id and therefore provides the maximum available courses
  -- for 'Spring2026'. The outer query then filters the registration table for all rows with terms set to 
  -- 'Spring2026' and groups by student_id. After grouping, the query filters the amount of unique courses
  -- for each student is equal to the maximum amount of unique courses. It then returns those student_ids ✅

🟢 31. Student Course Load (Easy → Medium)

Scenario:
The registrar wants to identify students with the heaviest workload in Spring2026.

Task:
Return the student_id(s) who are taking the maximum number of courses in Spring2026.

🟢 32. Courses With Multiple Students (Easy → Medium)

Scenario:
The university wants to identify collaborative courses.

Task:
Return all course_ids that have more than 1 student enrolled in Spring2026.

🟢 33. Students Taking Specific Course (Easy)

Scenario:
Advisors want to find students enrolled in a key course.

Task:
Return all student_ids who are enrolled in 'CS101' in Spring2026.

🟡 34. Courses Offered This Term Only (Medium)

Scenario:
The university wants to identify new or seasonal courses.

Task:
Return course_ids that are offered in Spring2026 but not in Fall2025.

🟡 35. Student Enrollment Count (Medium)

Scenario:
The registrar wants a summary of student activity.

Task:
Return each student_id along with the number of courses they are enrolled in during Spring2026.

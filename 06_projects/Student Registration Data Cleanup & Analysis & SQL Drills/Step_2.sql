--🟢 1. Add New Enrollment (Easy)

--Scenario:
--A student just enrolled in a course for the new term.

--Task:
--Insert a new record for:

--student_id = 101
--course_id = 205
--term = 'Spring2026'

BEGIN TRANSACTION;

INSERT INTO registrations


-- I ended this attempt because I can't seem to recall how to successfully perform a dml.

BEGIN TRANSACTION;

INSERT INTO registrations (student_id, course_id, term)
VALUES (101, 205, 'Spring2026');

COMMIT;

-- This works because it tells the program to insert integer value 101 as student_id, integer 205 as
  -- course_id, and string Spring2026 as term for the registrations table. ✅

--🟡 2. Remove Duplicate Enrollment (Easy → Medium)

--Scenario:
--A system bug caused duplicate enrollments for the same student in the same course and term.

--Task:
--Delete duplicate rows, keeping only one record per:

--student_id
--course_id
--term

BEGIN TRANSACTION;

DELETE FROM registrations (student_id, course_id, term)

-- I ended this attempt because I don't know any tools that can help me do this.

BEGIN TRANSACTION;

DELETE FROM registrations
WHERE id IN (
  SELECT id
  FROM (
    SELECT id, ROW_NUMBER() OVER (PARTITION BY student_id, course_id, term
      ORDER BY id) AS rn
    FROM registrations
  ) t
  WHERE rn > 1
);

COMMIT;

-- This works because it tells the program to locate the id within the following subquery. This subquery
  -- uses an inner subquery table wher it chooses the id, number of the row partitioned by the columns
  -- student id, course_id, and term and then ordered by id (rn), from the registrations table. Once it pulls
  -- the id(s) within the subquery, it then filters for rn greater than one and deletes the returned results. 

-- Revised: This query removes duplicate rows from the registrations table while keeping one unique
  -- record for each combination of student_id, course_id, and term. These groups represent potential
  -- duplicates. The numbering is ordered by id, so the first occurrence in each group receives a row
  -- number of 1. The outer part of the subquery filters for rows where the row number is greater than
  -- 1, which idendifies all duplicate records beyond the first occurrence. The DELECT statement then
  -- removes all rows whose id matches those duplicate records, ensuring that only one unique row per
  -- group remains in the table. 

--🟡 3. Update Term Correction (Medium)

--Scenario:
--Some records incorrectly labeled "Spr2026" instead of "Spring2026".

--Task:
--Update all rows where:

--term = 'Spr2026'

--Change them to:

--term = 'Spring2026'

BEGIN TRANSACTION;

UPDATE regiatrations
WHERE term = 'Spr2026'
TO 'Spring2026';

-- This doesn't work because SET should be used instead of TO

BEGIN TRANSACTION;

UPDATE registrations
SET term = 'Spring2026'
WHERE term = 'Spr2026';

COMMIT;

-- This query has all term values that are equal to Spr2026 changed to Spring2026 in the registrations
  -- table.

-- Revised: This statement updates all rows in the registrations table where the term is 'Spr2026',
  -- changing those values to 'Spring2026'

--🟡 4. Bulk Insert From Another Term (Medium)

--Scenario:
--All students in Fall2025 are automatically enrolled in a new orientation course (course_id = 999) for Spring2026.

--Task:
--Insert rows into registrations for all students who were in Fall2025:

--same student_id
--course_id = 999
--term = 'Spring2026'

BEGIN TRANSACTION;

INSERT INTO registrations (student_id, course_id, term)
WHERE student_id IN (
  SELECT student_id
  FROM registrations
  WHERE term = 'Fall2025'
  )
VALUES (student_id, 999, 'Spring2026');

-- This is not correct because INSERT doesn't use WHERE in this manner, VALUES cannot be mixed with
  -- a subquery in this way, and student_id cannot be used inside VALUES

BEGIN TRANSACTION;

INSERT INTO registrations (student_id, course_id, term)
SELECT student_id, 999, 'Spring2026'
FROM registrations
WHERE term = 'Fall2025';

COMMIT;

-- This query filters for terms that equal 'Fall2025' and inserts the student ids that have this term
  -- value with course_id equal to the integer 999 and term equal to the string 'Spring2026'. This creates
  -- new entries for these students for the spring semester ✅


--🔴 5. Conditional Data Cleanup (Hard)

--Scenario:
--The university wants to clean up inactive students.

--A student is considered inactive if:

--They have no enrollments in Spring2026
--AND
--They had fewer than 2 total enrollments across all terms

--Task:
--Delete those student records from registrations.

BEGIN TRANSACTION;

DELETE FROM registrations
WHERE student_id NOT IN (
  SELECT student_id
  FROM registrations
  WHERE term = 'Spring2026'
  )
AND student_id IN (
  SELECT student_id
  FROM registrations
  GROUP BY student_id
  HAVING COUNT(course_id) < 2
  ); 

COMMIT; ✅

--🟢 6. Simple Delete

--Scenario:
--A course (course_id = 300) was canceled for Spring2026.

--Task:
--Delete all registrations for:

--course_id = 300
--term = 'Spring2026'

BEGIN TRANSACTION;

DELETE FROM registrations
WHERE course_id = 300 AND term = 'Spring2026'; 

COMMIT; ✅


--🟡 7. Update Multiple Students

--Scenario:
--All students enrolled in course 101 during Fall2025 need to be moved to course 102 (same term).

--Task:
--Update:

--course_id from 101 → 102
--Only for term = 'Fall2025'

BEGIN TRANSACTION;

UPDATE registrations
SET course_id = 102
WHERE term = 'Fall2025' AND course_id = 101; ✅

--🟡 8. Insert Missing Students Into a Course

--Scenario:
--Every student in Spring2026 should also be enrolled in course 500, but some already are.

--Task:
--Insert rows for students in Spring2026:

--course_id = 500
--term = 'Spring2026'
--Only if they are NOT already enrolled in course 500 for that term

BEGIN TRANSACTION;

INSERT INTO registrations
SELECT student_id, 500, term
FROM registrations
WHERE term = 'Spring2026' AND student_id NOT IN (
  SELECT student_id
  FROM registrations
  WHERE course_id = 500 AND term = 'Spring2026'
);

COMMIT; ✅

--🟡 9. Delete Based on Count

--Scenario:
--Students who are overloaded (taking more than 5 courses in Spring2026) must drop all their Spring2026 courses.

--Task:
--Delete all Spring2026 registrations for students who have:

--More than 5 courses in that term

BEGIN TRANSACTION;

DELETE FROM registrations
WHERE term = 'Spring2026' AND student_id IN (
  SELECT student_id
  FROM registrations
  WHERE term = 'Spring2026'
  GROUP BY student_id
  HAVING COUNT(course_id) > 5
); 

COMMIT; ✅

--🔴 10. Conditional Update With Aggregate

--Scenario:
--The university wants to flag heavy course loads by renaming the term.

--If a student is taking more than 4 courses in Spring2026, update their records to:

--term = 'Spring2026-Heavy'

--Task:
--Update the table accordingly.

BEGIN TRANSACTION;

UPDATE registrations
SET term = 'Spring2026-Heavy'
WHERE student_id IN (
  SELECT student_id
  FROM registrations
  WHERE term = 'Spring2026'
  GROUP BY student_id
  HAVING COUNT(course_id) > 4
);

COMMIT; ✅

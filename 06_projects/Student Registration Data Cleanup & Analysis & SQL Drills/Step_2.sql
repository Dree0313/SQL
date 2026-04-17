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
  WHERE rn > 1;
);

COMMIT;

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

UPDATE transactions
SET term = 'Spring2026'
WHERE term = 'Spr2026';

COMMIT;

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

-- This is not correct because INSERT doesn't use WHERE in this manner, VALUES cannot be mized with
  -- a subquery in this way, and student_id cannot be used inside VALUES

BEGIN TRANSACTION;

INSERT INTO registrations (student_id, course_id, term)
SELECT student_id, 999, 'Spring2026'
FROM registrations
WHERE term = 'Fall2025'

COMMIT;


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

🟢 1. Add New Enrollment (Easy)

Scenario:
A student just enrolled in a course for the new term.

Task:
Insert a new record for:

student_id = 101
course_id = 205
term = 'Spring2026'
🟡 2. Remove Duplicate Enrollment (Easy → Medium)

Scenario:
A system bug caused duplicate enrollments for the same student in the same course and term.

Task:
Delete duplicate rows, keeping only one record per:

student_id
course_id
term
🟡 3. Update Term Correction (Medium)

Scenario:
Some records incorrectly labeled "Spr2026" instead of "Spring2026".

Task:
Update all rows where:

term = 'Spr2026'

Change them to:

term = 'Spring2026'
🟡 4. Bulk Insert From Another Term (Medium)

Scenario:
All students in Fall2025 are automatically enrolled in a new orientation course (course_id = 999) for Spring2026.

Task:
Insert rows into registrations for all students who were in Fall2025:

same student_id
course_id = 999
term = 'Spring2026'
🔴 5. Conditional Data Cleanup (Hard)

Scenario:
The university wants to clean up inactive students.

A student is considered inactive if:

They have no enrollments in Spring2026
AND
They had fewer than 2 total enrollments across all terms

Task:
Delete those student records from registrations.

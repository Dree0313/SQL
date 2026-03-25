--🟢 1. Basic Data Check (Easy)

--Scenario:
--Before investigating the issue, your manager asks you to quickly review the data.

--Task:
--Retrieve all records from the registrations table.



🟢 2. Focused Filtering (Easy → Medium)

Scenario:
The issue was first noticed in a specific term.

Task:
Find all registrations for a single term (e.g., 'Fall2025').

🟡 3. Enrollment Patterns (Medium)

Scenario:
You want to understand student activity to spot anything unusual.

Task:
Count how many total registrations each student has across all terms.

🟡 4. Duplicate Detection (Medium → Hard)

Scenario:
You suspect duplicates exist but need proof.

Task:
Identify combinations of:

student_id
course_id
term

that appear more than once.

(This is where interviewers start paying close attention.)

🔴 5. Full Duplicate Investigation (Hard)

Scenario:
Now the department wants to see the actual bad data so they can review it.

Task:
Retrieve all rows that are duplicates based on:

student_id
course_id
term

(Not just counts—the actual records.)

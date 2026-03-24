The Objective
Design a relational database for a clinic that tracks Patients, Doctors, and Appointments without data anomalies.

Requirements for the Project
You must build a document (or a series of SQL scripts) that demonstrates the progression from a messy "unnormalized" list to a clean, efficient database.

Phase 1: The "Messy" Table (Unnormalized)
Create an Excel sheet or a markdown table with redundant data.

Example: A single table that lists PatientName, PatientAddress, DoctorName, DoctorSpecialty, and AppointmentDate.

The Problem: If a patient changes their address, you have to update it in 50 rows (Data Anomaly).

Phase 2: 1NF (First Normal Form)
Requirement: Ensure every column contains atomic (indivisible) values and every row is unique.

Action: Create a unique PatientID for every patient.

Phase 3: 2NF (Second Normal Form)
Requirement: Must be in 1NF and have no "partial dependency" (all non-key attributes must depend on the entire primary key).

Action: Move patient info to a Patients table and doctor info to a Doctors table.

Phase 4: 3NF (Third Normal Form)
Requirement: Must be in 2NF and have no "transitive dependency" (non-key columns shouldn't depend on other non-key columns).

Action: Ensure that the DoctorSpecialty does not depend on the PatientID. It should only be linked via the DoctorID.

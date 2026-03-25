-- Phase 1: The "Messy" Table (Unnormalized) Create an Excel sheet or a markdown table with redundant data.

  -- Example: A single table that lists PatientName, PatientAddress, DoctorName, DoctorSpecialty, and AppointmentDate.

  -- The Problem: If a patient changes their address, you have to update it in 50 rows (Data Anomaly).

PatientName	PatientAddress	DoctorName	DoctorSpecialty	AppointmentDate	AppointmentTime
John Smith	123 Main St	    Dr. Adams	  Cardiology	    3/1/2026	      9:00 AM
John Smith	123 Main St	    Dr. Adams	  Cardiology	    3/15/2026	      10:00 AM
John Smith	123 Main St	    Dr. Lee	    Dermatology	    4/1/2026	      1:00 PM
Sarah Brown	456 Oak Ave	    Dr.Adams	  Cardiology	    3/3/2026	      11:00 AM
Sarah Brown	456 Oak Ave    	Dr. Patel	  Pediatrics	    3/20/2026	      2:00 PM
Mike Davis	789 Pine Rd	    Dr. Lee	    Dermatology	    3/10/2026	      9:30 AM
Mike Davis	789 Pine Rd	    Dr. Lee	    Dermatology	    3/25/2026	      3:00 PM
Emily Clark	321 Maple St	  Dr. Patel	  Pediatrics	    3/12/2026	      10:30 AM
Emily Clark	321 Maple St	  Dr.Adams	  Cardiology	    4/2/2026	      12:00 PM

-- Phase 2: 1NF (First Normal Form) Requirement: Ensure every column contains atomic (indivisible) values and every row is unique.

  -- Action: Create a unique PatientID for every patient.

AppointmentID  PatientID FirstName LastName	PatientAddress	DoctorName	DoctorSpecialty	AppointmentDate	AppointmentTime
1              101       John      Smith	  123 Main St	    Dr. Adams	  Cardiology	    3/1/2026	      9:00 AM
2              101       John      Smith	  123 Main St	    Dr. Adams	  Cardiology	    3/15/2026	      10:00 AM
3              101       John      Smith	  123 Main St	    Dr. Lee	    Dermatology	    4/1/2026	      1:00 PM
4              102       Sarah     Brown	  456 Oak Ave	    Dr.Adams	  Cardiology	    3/3/2026	      11:00 AM
5              102       Sarah     Brown	  456 Oak Ave    	Dr. Patel	  Pediatrics	    3/20/2026	      2:00 PM
6              103       Mike      Davis	  789 Pine Rd	    Dr. Lee	    Dermatology	    3/10/2026	      9:30 AM
7              103       Mike      Davis	  789 Pine Rd	    Dr. Lee	    Dermatology	    3/25/2026	      3:00 PM
8              104       Emily     Clark	  321 Maple St	  Dr. Patel	  Pediatrics	    3/12/2026	      10:30 AM
9              104       Emily     Clark	  321 Maple St	  Dr.Adams	  Cardiology	    4/2/2026	      12:00 PM

CREATE TABLE Appointment (
  appointment_id INT PRIMARY KEY,
  patient_id INT NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  patient_address TEXT NOT NULL,
  doctor_name TEXT NOT NULL,
  doctor_specialty TEXT NOT NULL,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL
);

-- Phase 3: 2NF (Second Normal Form) Requirement: Must be in 1NF and have no "partial dependency" (all non-key attributes must depend on the entire primary key).

  -- Action: Move patient info to a Patients table and doctor info to a Doctors table.
Patient
PatientID  FirstName  LastName  Address
101        John       Smith     123 Main St
102        Sarah      Brown     456 Oak Ave
103        Mike       Davis     789 Pine Rd
104        Emily      Clark     321 Maple St

CREATE TABLE Patient (
  patient_id INT PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  address TEXT NOT NULL
);

Doctor
DoctorID  DoctorName  DoctorSpecialty
1001      Dr. Adams   Cardiology
1002      Dr. Lee     Dermatology
1003      Dr. Patel   Pediatrics

CREATE TABLE Doctor (
  doctor_id INT PRIMARY KEY,
  doctor_name TEXT NOT NULL,
  doctor_specialty TEXT NOT NULL
);

CREATE TABLE Appointment (
  appointment_id INT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Phase 4: 3NF (Third Normal Form) Requirement: Must be in 2NF and have no "transitive dependency" (non-key columns shouldn't depend on other non-key columns).

  -- Action: Ensure that the DoctorSpecialty does not depend on the PatientID. It should only be linked via the DoctorID.

-- Since there are no partial dependencies, transitive dependencies, and all relationships are via IDs, 3NF has been achieved

CREATE TABLE Patient (
  patient_id INT PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  address TEXT NOT NULL
);

CREATE TABLE Doctor (
  doctor_id INT PRIMARY KEY,
  doctor_name TEXT NOT NULL,
  doctor_specialty TEXT NOT NULL
);

CREATE TABLE Appointment (
  appointment_id INT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

Project Goal

Design and query a relational database that simulates how Blue Cross Blue Shield might store, process, and analyze member insurance claims.

Your goal is to show:

Strong understanding of relational design

Ability to write real-world queries

Comfort with updates, joins, aggregates, and constraints

Business awareness (costs, approvals, providers)

Database Requirements

You must create at least 6 tables with proper primary keys and foreign keys.

Required Tables

Members

Providers

Plans

Claims

Claim_Items

Payments

Table Criteria (What each must include)
Members

Unique member ID

First name, last name

Date of birth

Gender

Enrollment date

Plan ID (FK)

Status (Active / Inactive)

Plans

Plan ID

Plan name (HMO, PPO, etc.)

Monthly premium

Annual deductible

Out-of-pocket maximum

Providers

Provider ID

Provider name

Specialty

In-network (Yes/No)

City and state

Claims

Claim ID

Member ID (FK)

Provider ID (FK)

Date of service

Date claim submitted

Claim status (Pending, Approved, Denied)

Total billed amount

Claim_Items

(Each claim must have 1+ items)

Claim item ID

Claim ID (FK)

Procedure code

Description

Billed amount

Covered amount

Payments

Payment ID

Claim ID (FK)

Payment date

Amount paid by insurance

Amount paid by member

Payment method

Data Rules & Constraints

A claim cannot exist without a valid member and provider

A claim cannot be approved unless it has at least one claim item

Covered amount cannot exceed billed amount

Members on inactive status cannot submit new claims

Out-of-network providers should result in lower covered amounts

Required SQL Tasks

You must write queries that accomplish ALL of the following:

Basic Queries

List all active members with their plan details

Show all claims for a given member

Retrieve all claims submitted in the last 90 days

JOIN Queries

Show claims with member name and provider name

List claim items with their claim status

Display payments alongside claim totals

Aggregations

Total claims cost per member

Average claim amount per plan

Total amount paid by insurance vs members

Top 5 providers by total billed amount

Conditional Logic

Identify claims that exceed the member’s deductible

Flag claims that are out-of-network

Show denied claims and the total denied amount

UPDATE / DELETE

Update claim status from Pending → Approved

Automatically adjust payment amounts when a claim is denied

Delete claims submitted by inactive members (with caution)

Advanced (Optional but impressive)

Use a CTE to calculate running totals of member out-of-pocket costs

Create a VIEW for approved claims with payment summaries

Write a stored procedure to submit a new claim

Add indexes and explain why you added them

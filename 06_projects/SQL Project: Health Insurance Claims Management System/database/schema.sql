__________________________________________________________________________
## Table: Plans
__________________________________________________________________________

Create Table Plans (
  plan_id Integer PRIMARY KEY,
  plan_name TEXT NOT NULL,
  monthly_premium REAL NOT NULL,
  annual_deductible REAL NOT NULL,
  out_of_pocket_max REAL NOT NULL
);

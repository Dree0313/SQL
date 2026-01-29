-- Purpose: Populate tables with sample data for Member Account & Transactions Dashboard

-- Members Table
INSERT INTO Members (member_id, first_name, last_name, date_of_birth, email, status)
VALUES
(1, 'Alice', 'Johnson', '1988-05-12', 'alice.johnson@example.com', 'Acitve'),
(2, 'Bob', 'Smith', '1975-09-30', 'bob.smith@example.com', 'Active'),
(3, 'Carol', 'Davis', '1992-11-20', 'carol.davis@example.com', 'Inactive'),
(4, 'David', 'Brown', '1985-03-15', 'david.brown@example.com', 'Active'),
(5, 'Eva', 'Miller', '2000-07-07', 'eva.miller@example.com', 'Acitve');

-- Accounts Table
INSERT INTO Accounts (account_id, member_id, account_type, balance, opened_date)
VALUES
(101, 1, 'Checking', 2500.00, '2023-01-10'),
(102, 1, 'Savings', 5000.00, '2022-06-15'),
(103, 2, 'Checking', 1500.00, '2021-03-20'),
(104, 2, 'Savings', 3500.00, '2021-03-20'),
(105, 3, 'Checking', 0.00, '2020-11-11'),
(106, 4, 'Savings' 7800.00, '2024-02-01'),
(107, 5, 'Checking', 1200.00, '2023-12-25');

-- Transactions Table
INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, amount, description)
VALUES
(1001, 101, '2026-01-10', 'Deposit', 1000.00, 'Paycheck'),
(1002, 101, '2026-01-12', 'Withdrawal', 200.00, 'Groceries'),
(1003, 102, '2026-01-05', 'Deposit', 500.00, 'Gift'),
(1004, 103, '2026-01-07', 'Withdrawal', 150.00, 'Gas'),
(1005, 104, '2026-01-08', 'Deposit', 300.00, 'Refund'),
(1006, 104, '2026-01-09', 'Withdrawal', 50.00, 'Coffee'),
(1007, 106, '2026-01-15', 'Deposit', 1000.00, 'Bonus'),
(1008, 107, '2026-01-16', 'Withdrawal', 100.00, 'Restaurant'),
(1009, 101, '2026-01-17', 'Withdrawal', 50.00, 'Subscription'),
(1010, 102, '2026-01-18', 'Deposit', 200.00, 'Freelance Payment');

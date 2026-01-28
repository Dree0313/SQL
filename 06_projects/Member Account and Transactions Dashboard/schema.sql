CREATE TABLE IF NOT EXISTS Members (
    member_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    status TEXT CHECK(status IN ('Active', 'Inactive'))
);

CREATE TABLE IF NOT EXISTS Accounts (
    account_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    account_type TEXT NOT NULL CHECK(account_type IN ('Checking', 'Savings')),
    balance REAL DEFAULT 0,
    open_date TEXT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    transaction_date TEXT NOT NULL,
    amount REAL NOT NULL,
    "description" TEXT,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
-- Create table City
CREATE TABLE City (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50)
);

-- Create table Accounts
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    account_type VARCHAR(10), -- 'Savings' or 'Current'
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES City(city_id)
);

-- Create table Transactions
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(10), -- 'Credit' or 'Debit'
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Inserting data into City table
INSERT INTO City (city_id, city_name) VALUES
(1, 'Delhi'),
(2, 'Lucknow'),
(3, 'Chandigarh'),
(4, 'Jaipur'),
(5, 'Amritsar');

-- Inserting data into Accounts table
INSERT INTO Accounts (account_id, account_type, city_id) VALUES
(101, 'Savings', 1),
(102, 'Current', 2),
(103, 'Savings', 3),
(104, 'Current', 4),
(105, 'Savings', 5)
(106, 'Current', 1),
(107, 'Savings', 2),
(108, 'Current', 3),
(109, 'Savings', 4),
(110, 'Current', 5)
(111, 'Savings', 1),
(112, 'Current', 1),
(113, 'Savings', 2),
(114, 'Current', 3),
(115, 'Savings', 4),
(116, 'Current', 5),
(117, 'Savings', 1),
(118, 'Current', 1),
(119, 'Savings', 2),
(120, 'Current', 3);

-- Inserting data into Transactions table
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES
(1001, 101, 'Credit', 5000.00, '2024-01-01'),
(1002, 101, 'Debit', 2000.00, '2024-01-02'),
(1003, 102, 'Credit', 10000.00, '2024-01-03'),
(1004, 103, 'Debit', 3000.00, '2024-01-04'),
(1005, 104, 'Credit', 7000.00, '2024-01-05'),
(1006, 105, 'Debit', 4000.00, '2024-01-06'),
(1007, 105, 'Credit', 6000.00, '2024-01-07')
(1008, 106, 'Credit', 8000.00, '2024-01-08'),
(1009, 106, 'Debit', 3000.00, '2024-01-09'),
(1010, 107, 'Credit', 9000.00, '2024-01-10'),
(1011, 107, 'Debit', 2500.00, '2024-01-11'),
(1012, 108, 'Credit', 6000.00, '2024-01-12'),
(1013, 108, 'Debit', 3500.00, '2024-01-13'),
(1014, 109, 'Credit', 1000.00, '2024-01-14'),
(1015, 109, 'Debit', 500.00, '2024-01-15'),
(1016, 110, 'Credit', 11000.00, '2024-01-16'),
(1017, 110, 'Debit', 4500.00, '2024-01-17')
(1018, 111, 'Credit', 12000.00, '2024-01-18'),
(1019, 111, 'Credit', 13000.00, '2024-01-19'),
(1020, 112, 'Credit', 15000.00, '2024-01-20'),
(1021, 112, 'Credit', 14000.00, '2024-01-21'),
(1022, 113, 'Debit', 2000.00, '2024-01-22'),
(1023, 114, 'Credit', 11000.00, '2024-01-23'),
(1024, 115, 'Debit', 3000.00, '2024-01-24'),
(1025, 116, 'Credit', 7000.00, '2024-01-25'),
(1026, 117, 'Credit', 16000.00, '2024-01-26'),
(1027, 118, 'Credit', 17000.00, '2024-01-27');;




-- Get all the accounts in Delhi where Savings account has atleast 2 transactions of type Credit
SELECT a.account_id, a.account_type, t.transaction_type, c.city_name
FROM Accounts a
INNER JOIN City c
ON a.city_id = c.city_id
INNER JOIN Transactions t
ON a.account_id = t.account_id
WHERE c.city_name = 'Delhi'
AND a.account_type = 'Savings'
AND t.transaction_type = 'Credit'
GROUP BY a.account_id
HAVING COUNT(t.transaction_id) >= 2;
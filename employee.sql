-- Create Employee Table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dob DATE,
    yoe INT, -- Years of Experience
    mgr_id INT,
    FOREIGN KEY (mgr_id) REFERENCES Employee(emp_id)
);

-- Insert dummy values to the table
INSERT INTO Employee (emp_id, name, dob, yoe, mgr_id) VALUES
(1, 'John Doe', '1980-01-01', 15, NULL),  -- CEO, no manager
(2, 'Jane Smith', '1985-05-15', 12, 1),  -- Reports to CEO
(3, 'Mike Johnson', '1990-02-20', 8, 1), -- Reports to CEO
(4, 'Emily Davis', '1988-08-30', 10, 2), -- Reports to Jane Smith
(5, 'Robert Brown', '1992-09-05', 5, 2), -- Reports to Jane Smith
(6, 'Laura Wilson', '1995-12-12', 3, 3), -- Reports to Mike Johnson
(7, 'David Lee', '1987-07-11', 11, 3),   -- Reports to Mike Johnson
-- Adding more records...
(8, 'Chris Green', '1983-11-20', 14, 2),
(9, 'Ashley White', '1991-01-21', 7, 3),
(10, 'Brandon Clark', '1989-03-10', 9, 4),
(11, 'Olivia Martin', '1996-06-06', 2, 5),
(12, 'Sophia Walker', '1993-04-25', 6, 4),
(13, 'James Hall', '1994-10-30', 4, 6),
(14, 'Ava Harris', '1986-09-19', 13, 7),
(15, 'Isabella Young', '1997-05-02', 1, 7),
-- Ensuring skip-level managers
(16, 'Ethan Allen', '1982-03-12', 16, 1), -- Skip-level manager
(17, 'Mason King', '1984-04-14', 14, 16), -- Reports to Ethan Allen
(18, 'Logan Wright', '1990-07-20', 8, 16), -- Reports to Ethan Allen
(19, 'Lucas Scott', '1987-11-22', 11, 17), -- Reports to Mason King
(20, 'Henry Adams', '1991-08-24', 7, 17), -- Reports to Mason King
(21, 'Jack Baker', '1993-02-28', 6, 18), -- Reports to Logan Wright
(22, 'Benjamin Gonzales', '1992-01-15', 5, 18), -- Reports to Logan Wright
(23, 'Liam Nelson', '1994-09-16', 4, 19), -- Reports to Lucas Scott
(24, 'Alexander Carter', '1995-03-17', 3, 19), -- Reports to Lucas Scott
(25, 'Michael Mitchell', '1996-10-18', 2, 20), -- Reports to Henry Adams
(26, 'Daniel Perez', '1997-12-19', 1, 20), -- Reports to Henry Adams
(27, 'Matthew Roberts', '1989-06-20', 9, 21), -- Reports to Jack Baker
(28, 'Sebastian Turner', '1988-07-21', 10, 22), -- Reports to Benjamin Gonzales
(29, 'Joseph Phillips', '1991-08-22', 7, 23), -- Reports to Liam Nelson
(30, 'Jackson Campbell', '1993-09-23', 6, 24); -- Reports to Alexander Carter


-- Show employee name, manager name and skip level manager name for all the employees
SELECT e1.name AS Employee, e2.name AS Manager, e3.name AS Skip_Level_Manager
FROM Employee e1
INNER JOIN Employee e2 ON e1.mgr_id = e2.emp_id
INNER JOIN Employee e3 ON e2.mgr_id = e3.emp_id;

--1. Employee table — Multiple salaries
CREATE TABLE Employee (
    id INT,
    salary INT
);

INSERT INTO Employee (id, salary)
VALUES
    (1, 100),
    (2, 200),
    (3, 300),
    (4, 300),
    (5, 100);


--Expected data
id	salary
1	   100
2	   200
3	   300
4	   300
5	   100

--Solution 1 — MAX() with Subquery
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);


--Solution 2 — DENSE_RANK()
SELECT MAX(salary) AS SecondHighestSalary
FROM (
    SELECT
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM Employee
) ranked
WHERE salary_rank = 2;

2. Employee_1 table — Only one salary
CREATE TABLE Employee_1 (
    id INT,
    salary INT
);

INSERT INTO Employee_1 (id, salary)
VALUES (1, 100);


--Expected data
id	salary
1	   100
  
--Solution 1 — MAX() with Subquery
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee_1
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee_1
);


--Solution 2 — DENSE_RANK()
SELECT MAX(salary) AS SecondHighestSalary
FROM (
    SELECT
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM Employee_1
) ranked
WHERE salary_rank = 2;


-- Output for both solutions:
SecondHighestSalary
NULL

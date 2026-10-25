CREATE TABLE Employee (
    id INT PRIMARY KEY,
    salary INT
);

INSERT INTO Employee (id, salary)
VALUES (1, 100), (2, 200), (3, 300);

-- MYSQL
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    RETURN (
        SELECT MAX(salary)
        FROM (
            SELECT
                salary,
                DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
            FROM Employee
        ) AS ranked_salaries
        WHERE salary_rank = N
    );
END;

SELECT getNthHighestSalary(2); -- 200
SELECT getNthHighestSalary(4); -- NULL

-- ORACLE PL/SQL

CREATE OR REPLACE FUNCTION getNthHighestSalary(N IN NUMBER)
RETURN NUMBER
IS
    result NUMBER;
BEGIN
    WITH SalaryCTE AS (
        SELECT
            salary,
            DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
        FROM Employee
    )
    SELECT MAX(salary)
    INTO result
    FROM SalaryCTE
    WHERE salary_rank = N;

    RETURN result;
END;

SELECT getNthHighestSalary(2) FROM dual; -- 200
SELECT getNthHighestSalary(4) FROM dual; -- NULL

-- SQL SERVER

CREATE FUNCTION dbo.getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

    SELECT @result = MAX(salary)
    FROM (
        SELECT
            salary,
            DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
        FROM Employee
    ) AS ranked_salaries
    WHERE salary_rank = @N;

    RETURN @result;
END;
GO

SELECT dbo.getNthHighestSalary(2); -- 200
SELECT dbo.getNthHighestSalary(4); -- NULL

-- POSTGRES 
CREATE OR REPLACE FUNCTION getNthHighestSalary(N INTEGER)
RETURNS INTEGER
LANGUAGE SQL
AS $$
    SELECT MAX(salary)
    FROM (
        SELECT
            salary,
            DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
        FROM Employee
    ) AS ranked_salaries
    WHERE salary_rank = N;
$$;

SELECT getNthHighestSalary(2); -- 200
SELECT getNthHighestSalary(4); -- NULL

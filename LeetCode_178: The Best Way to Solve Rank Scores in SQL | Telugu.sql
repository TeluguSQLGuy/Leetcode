-- Create Table

CREATE TABLE Scores (
    id NUMBER,
    score NUMBER(5,2)
);

-- Insert Into

INSERT INTO Scores VALUES (1, 3.50);
INSERT INTO Scores VALUES (2, 3.65);
INSERT INTO Scores VALUES (3, 4.00);
INSERT INTO Scores VALUES (4, 3.85);
INSERT INTO Scores VALUES (5, 4.00);
INSERT INTO Scores VALUES (6, 3.65);

COMMIT;

-- Verify the Data

SELECT *
FROM Scores
ORDER BY id;

-- Solution 

SELECT SCORE,
       DENSE_RANK() OVER (ORDER BY score DESC) AS "rank"
FROM SCORES
ORDER BY SCORE DESC;

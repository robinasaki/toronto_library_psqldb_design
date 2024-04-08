SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q4 CASCADE;

CREATE TABLE q4 (
    most_submitted_submission INT PRIMARY KEY
);

-- All accepted submissions
DROP VIEW IF EXISTS AllAcceptedSubmissions;
CREATE VIEW AllAcceptedSubmissions AS
    SELECT S.submission_id, S.submission_title, S.submission_type, ARRAY[C.person_id] AS authors
    FROM Submissions S
    JOIN Contributes C ON C.submission_id = S.submission_id
    WHERE S.decision = 'accepted'
    GROUP BY S.submission_id, S.submission_title, S.submission_type, ARRAY[C.person_id];

-- All submissions with a list of their authors
DROP VIEW IF EXISTS AllSubmissionsWithAuthors;
CREATE VIEW AllSubmissionsWithAuthors AS
    SELECT S.submission_id, S.submission_title, S.submission_type, ARRAY[C.person_id] AS authors
    FROM Submissions S
    JOIN Contributes C ON C.submission_id = S.submission_id
    GROUP BY S.submission_id, S.submission_title, S.submission_type, ARRAY[C.person_id];

-- The most attemped submission that was eventually accepted
DROP VIEW IF EXISTS AllAttemptsOfAccepted;
CREATE VIEW AllAttemptsOfAccepted AS
    SELECT MAX(AAS.submission_id) as accepted_id, 
           AAS.submission_title, 
           AAS.submission_type, 
           AAS.authors, 
           COUNT(S.submission_id) AS num_attempts
    FROM AllAcceptedSubmissions AAS
    JOIN AllSubmissionsWithAuthors S ON 
        AAS.submission_title = S.submission_title AND
        AAS.submission_type = S.submission_type AND
        -- Compares list of authors, ignoring order
        (AAS.authors <@ S.authors AND AAS.authors @> S.authors)
    GROUP BY AAS.submission_title, AAS.submission_type, AAS.authors
    ORDER BY COUNT(S.submission_id) DESC
    LIMIT 1;

INSERT INTO q4 (most_submitted_submission)
    SELECT DISTINCT accepted_id FROM AllAttemptsOfAccepted;
    
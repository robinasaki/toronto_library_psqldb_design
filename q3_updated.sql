SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q3 CASCADE;

CREATE TABLE q3 (
    first_author INT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT
);

-- Conference with highest number of acceptances
DROP VIEW IF EXISTS ConferenceWithMostAcceptances CASCADE;
CREATE VIEW ConferenceWithMostAcceptances AS
    SELECT C.conf_name, 
           COALESCE(COUNT(S.submission_id), 0) AS accepted_count
    FROM Submissions S
    JOIN Conferences C ON S.conf_id = C.conf_id
    -- Ensure only papers here
    JOIN PaperSubmissions PS ON PS.submission_id = S.submission_id 
    WHERE S.decision = 'accepted'
    GROUP BY C.conf_name
    ORDER BY COALESCE(COUNT(S.submission_id), 0) DESC
    LIMIT 1;

-- First authors of papers accepted in the conf with most acceptances
DROP VIEW IF EXISTS AcceptedPaperAuthors CASCADE;
CREATE VIEW AcceptedPaperAuthors AS
    SELECT CO.person_id, P.first_name, P.last_name
    FROM Conferences C
    JOIN ConferenceWithMostAcceptances CWMA ON CWMA.conf_name = C.conf_name
    JOIN Submissions S ON C.conf_id = S.conf_id
    JOIN PaperSubmissions PS ON PS.submission_id = S.submission_id
    JOIN Contributes CO ON S.submission_id = CO.submission_id
    JOIN People P on P.person_id = CO.person_id
    WHERE CO.author_num = 1
    AND S.decision = 'accepted';

INSERT INTO q3 (first_author, first_name, last_name) 
    SELECT * FROM AcceptedPaperAuthors;
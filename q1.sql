SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q1 CASCADE;
CREATE TABLE q1 (
    conf_id INT NOT NULL,
    year INT NOT NULL,
    acceptance_rate FLOAT NOT NULL,

    PRIMARY KEY (conf_id, year)
);

-- Assumption: we only want the acceptance rate for all paper submissions
-- as poster submissions do not need to be accepted

-- All conferences, year and their accepted submission count
DROP VIEW IF EXISTS ConferenceYearAcceptedSubmissions CASCADE;
CREATE VIEW ConferenceYearAcceptedSubmissions AS
    SELECT C.conf_id, EXTRACT(YEAR FROM C.start_time) AS year, COALESCE(COUNT(S.submission_id), 0) AS accpeted_count
    FROM Submissions S
    JOIN PaperSubmissions PS ON S.submission_id = PS.submission_id
    JOIN Conferences C ON S.conf_id = C.conf_id
    WHERE PS.paper_decision = 'accepted'
    GROUP BY (C.conf_id, EXTRACT(YEAR FROM C.start_time));

-- All conferences, year and their submission count
DROP VIEW IF EXISTS ConferenceYearSubmissions CASCADE;
CREATE VIEW ConferenceYearSubmissions AS
    SELECT C.conf_id, EXTRACT(YEAR FROM C.start_time) AS year, COALESCE(COUNT(S.submission_id), 0) AS accpeted_count
    FROM Submissions S
    JOIN PaperSubmissions PS ON S.submission_id = PS.submission_id
    JOIN Conferences C ON S.conf_id = C.conf_id
    GROUP BY (C.conf_id, EXTRACT(YEAR FROM C.start_time));

-- Calculate acceptance rate
INSERT INTO q1
SELECT CY.conf_id, 
    CY.year, 
    CAST(CASE WHEN CYS.accpeted_count = 0 THEN 0 ELSE CYS.accpeted_count / CY.accpeted_count END AS FLOAT)
FROM ConferenceYearAcceptedSubmissions CYS
JOIN ConferenceYearSubmissions CY ON CYS.conf_id = CY.conf_id AND CYS.year = CY.year;

SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q1 CASCADE;
CREATE TABLE q1 (
    conf_name TEXT NOT NULL,
    year INT NOT NULL,
    acceptance_rate FLOAT NOT NULL,

    PRIMARY KEY (conf_name, year)
);

-- NOTE: A name uniquely identifies a particular conference occuring over multiple years

-- All conferences, year and their ACCEPTED submission count
DROP VIEW IF EXISTS ConferenceYearAcceptedSubmissions CASCADE;
CREATE VIEW ConferenceYearAcceptedSubmissions AS
    SELECT C.conf_name, 
           EXTRACT(YEAR FROM C.start_time) AS year, 
           COALESCE(COUNT(S.submission_id), 0) AS accepted_count
    FROM Submissions S
    JOIN Conferences C ON S.conf_id = C.conf_id
    WHERE S.decision = 'accepted'
    GROUP BY (C.conf_name, EXTRACT(YEAR FROM C.start_time));

-- All conferences, year and their submission count
DROP VIEW IF EXISTS ConferenceYearSubmissions CASCADE;
CREATE VIEW ConferenceYearSubmissions AS
    SELECT C.conf_name, 
           EXTRACT(YEAR FROM C.start_time) AS year, 
           COALESCE(COUNT(S.submission_id), 0) AS accepted_count
    FROM Submissions S
    JOIN Conferences C ON S.conf_id = C.conf_id
    GROUP BY (C.conf_name, EXTRACT(YEAR FROM C.start_time));

-- Calculate acceptance rate
INSERT INTO q1
SELECT CY.conf_name, 
    CY.year, 
    CAST(CASE WHEN CYS.accepted_count = 0 THEN 0 ELSE CYS.accepted_count 
            / CY.accepted_count END AS FLOAT)
FROM ConferenceYearAcceptedSubmissions CYS
JOIN ConferenceYearSubmissions CY ON CYS.conf_name = CY.conf_name AND CYS.year = CY.year;

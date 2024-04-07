SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q5 CASCADE;

-- Assume there can be any number of paper sessions in a conference, but only one poster

CREATE TABLE q4 (
    conf_id INT PRIMARY KEY,
    avg_papers INT,
    avg_posters INT
);

-- Average number of posters 
-- Only one poster session, so average = count
DROP VIEW IF EXISTS AveragePosters CASCADE;
CREATE VIEW AveragePosters AS
    SELECT C.conf_id, COUNT(S.submission_id) AS avg_posters
    FROM PosterSessions PS
    JOIN Conferences C ON C.conf_id = PS.conf_id
    JOIN SessionPresentations SP ON PS.session_id = SP.session_id
    JOIN Submissions S ON S.submission_id = SP.submission_id
    GROUP BY C.conf_id;

-- All paper sessions, with their count of papers
DROP VIEW IF EXISTS NumPapers CASCADE;
CREATE VIEW NumPapers AS
    SELECT C.conf_id, PS.session_id, COUNT(S.submission_id) AS num_papers
    FROM PaperSessions PS
    JOIN Conferences C ON C.conf_id = PS.conf_id
    JOIN SessionPresentations SP ON PS.session_id = SP.session_id
    JOIN Submissions S ON S.submission_id = SP.submission_id
    GROUP BY C.conf_id, PS.session_id;

-- Average number of papers
DROP VIEW IF EXISTS AveragePapers CASCADE;
CREATE VIEW AveragePapers AS
    SELECT conf_id, AVG(num_papers) AS avg_papers
    FROM NumPapers
    GROUP BY conf_id;
    
-- Avg papers and posters of each conference session
DROP VIEW IF EXISTS AveragePapersAndPosters CASCADE;
CREATE VIEW AveragePapersAndPosters AS
    SELECT AveragePosters.conf_id, avg_papers, avg_posters
    FROM AveragePosters
    JOIN AveragePapers ON AveragePapers.conf_id = AveragePosters.conf_id;

INSERT INTO q5 (conf_id, avg_papers, avg_posters)
    SELECT * FROM AveragePapersAndPosters;
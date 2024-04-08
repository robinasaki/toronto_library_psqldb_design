SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q3 CASCADE;

-- Assuming 'Conference' for this question implies a single instance of any repeating conference 
-- (e.g. only 'Conference A 2017' or 'Conference A 2018')

CREATE TABLE q3 (
    first_author INT PRIMARY KEY,
    first_name TEXT,
    middle_name TEXT,
    last_name TEXT
);

DROP VIEW IF EXISTS LargestConferenceAcceptedPaperNumbers CASCADE;
DROP VIEW IF EXISTS FirstAuthorsInLargestConference CASCADE;

CREATE VIEW LargestConferenceAcceptedPaperNumbers AS 
    SELECT Conferences.conf_name, count(PaperSubmission.submission_id) AS num_accepts
    FROM PaperSubmission 
    JOIN Submissions ON PaperSubmission.submission_id = Submissions.submission_id
    JOIN Conferences ON Submissions.conf_id = Conferences.conf_id
    WHERE PaperSubmission.paper_decision = 'accepted'
    GROUP BY Conferences.conf_name
    ORDER BY count(PaperSubmission.submission_id) DESC
    LIMIT 1;

CREATE VIEW FirstAuthorsInLargestConference AS 
    SELECT Contributes.person_id, People.first_name, People.middle_name, People.last_name
    FROM PaperSubmission 
    JOIN Submissions ON PaperSubmission.submission_id = Submissions.submission_id
    JOIN Conferences ON Submissions.conf_id = Conferences.conf_id
    JOIN LargestConferenceAcceptedPaperNumbers l ON l.conf_name = Conferences.conf_name
    JOIN Contributes ON Contributes.submission_id = PaperSubmission.submission_id
    JOIN People ON People.person_id = Contributes.person_id
    WHERE PaperSubmission.paper_decision = 'accepted' AND Contributes.author_num = 1;-- ALSO: Determine if author is FIRST author

INSERT INTO q3 (first_author, first_name, middle_name, last_name)
    SELECT * FROM FirstAuthorsInLargestConference;
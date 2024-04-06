SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q3 CASCADE;

CREATE TABLE q3 (
    first_author INT PRIMARY KEY,
    first_name TEXT,
    middle_name TEXT,
    last_name TEXT
);

DROP VIEW IF EXISTS LargestConferenceAcceptedPaperNumbers CASCADE;
DROP VIEW IF EXISTS FirstAuthorsInLargestConference CASCADE;

CREATE VIEW LargestConferenceAcceptedPaperNumbers AS 
    SELECT conf_id, count(PaperSubmission.submission_id) AS num_accepts
    FROM PaperSubmission JOIN Submissions ON PaperSubmission.submission_id = Submissions.submission_id
    WHERE PaperSubmission.paper_decision = 'accepted'
    GROUP BY conf_id
    ORDER BY num_accepts DESC
    LIMIT 1;

CREATE VIEW FirstAuthorsInLargestConference AS 
    SELECT Contributes.person_id, People.first_name, People.middle_name, People.last_name
    FROM PaperSubmission 
    JOIN Submissions ON PaperSubmission.submission_id = Submissions.submission_id
    JOIN LargestConferenceAcceptedPaperNumbers l ON l.conf_id = Submissions.conf_id
    JOIN Contributes ON Contributes.submission_id = PaperSubmission.submission_id
    JOIN People ON People.person_id = Contributes.person_id
    WHERE PaperSubmission.paper_decision = 'accepted' AND Contributes.author_num = 1;-- ALSO: Determine if author is FIRST author

INSERT INTO q3 (first_author, first_name, middle_name, last_name)
    SELECT * FROM FirstAuthorsInLargestConference;
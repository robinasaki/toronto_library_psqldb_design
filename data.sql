SET SEARCH_PATH TO Conference;

-- Import Data for Conferences
\COPY Conferences FROM 'data/Conferences.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for People
\COPY People FROM 'data/People.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for ConferenceSessions
-- `ConferenceSessions` depends on `Conferences` in SessionTimeCheck()
\COPY ConferenceSessions FROM 'data/ConferenceSessions.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for Workshops
\COPY Workshops FROM 'data/Workshops.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for WorkshopAttendees
\COPY WorkshopAttendees FROM 'data/WorkshopAttendees.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for Attends
\COPY Attends FROM 'data/Attends.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for Contributes
\COPY Contributes FROM 'data/Contributes.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for Submissions
\COPY Submissions FROM 'data/Submissions.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for Reviews
-- `Reviews` depends on `Contributes` in CheckSelfReview(), ReviewCheck() and ReviewEnforceCheck()
-- `Reviews` depends on `Submissions`, `People` in ReviewCheck()
\COPY Reviews FROM 'data/Reviews.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for PaperSubmissions
-- `PaperSubmissions` depends on `Reviews` in CheckAtLeastThreeReviews() and CheckAcceptReview()
\COPY PaperSubmissions FROM 'data/PaperSubmissions.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for SessionPresentations
-- `SessionPresentations` depends on `PaperSubmissions`, `Contributes` in ChairNotAuthor()
\COPY SessionPresentations FROM 'data/SessionPresentations.csv' WITH CSV DELIMITER ',' HEADER;

-- Import Data for SessionChair
-- `SessionChair` depends on `Contributes` and `SessionPresentation` in ChairNotAuthor()
\COPY SessionChair FROM 'data/SessionChair.csv' WITH CSV DELIMITER ',' HEADER;

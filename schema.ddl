DROP SCHEMA IF EXISTS A3Conference CASCADE;
CREATE SCHEMA A3Conference;
SET SEARCH_PATH TO A3Conference;

CREATE TYPE A3Conference.participant_type AS ENUM (
    'student', 'other'
);

CREATE TYPE A3Conference.submission_and_session_type AS ENUM (
    'paper', 'poster'
);

CREATE TYPE A3Conference.decision_type AS ENUM (
    'accept', 'reject'
);  

-- Person
-- personid, First name, last name, email, phone, org, type(student, other)
CREATE TABLE IF NOT EXISTS Person (
    person_id INT PRIMARY KEY,

    first_name TEXT NOT NULL,

    last_name TEXT NOT NULL,

    email TEXT NOT NULL,

    phone CHAR(15) NOT NULL,
    -- A person's associated organization
    org TEXT NOT NULL,

    type participant_type NOT NULL
);

-- Conference
-- conferenceid, name, date, location
CREATE TABLE IF NOT EXISTS Conference (
    conference_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    -- The date and time that the conference starts
    start_time TIMESTAMP NOT NULL,
    -- The date and time that the conference ends
    end_time TIMESTAMP NOT NULL,

    location TEXT NOT NULL,

    UNIQUE (name, date, location) -- Necessary??????
);

CREATE TABLE IF NOT EXISTS ConferenceAttendee (
    conference INT NOT NULL,
    attendee INT NOT NULL,

    PRIMARY KEY (conference, attendee),
    FOREIGN KEY (conference) REFERENCES Conference (conference_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (attendee) REFERENCES Person (person_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Submission
-- submissionid, name, conferenceid, submissiontype(paper, poster), contributor_group(submission_contributors), reviewers_or_reviewer_in_group[ONLY FOR PAPERS]
CREATE TABLE IF NOT EXISTS Submission (
    submission_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    conference_id TEXT NOT NULL,
    submission_type submission_and_session_type NOT NULL,

    FOREIGN KEY (conference_id) REFERENCES Conference(conference_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- submission_contributors (authors?)
-- submissionid, author_order_num, personid, is_reviewer(t or f)
CREATE TABLE IF NOT EXISTS SubmissionContributor (
    submission_id INT NOT NULL,
    contributor INT NOT NULL,
    author_order_num INT NOT NULL,
    is_reviewer BOOLEAN NOT NULL,

    PRIMARY KEY (submission_id, author_order_num),
    FOREIGN KEY (submission_id) REFERENCES Submission (submission_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (contributor) REFERENCES ConferenceAttendee (attendee)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Reviewer
-- personid, submissionid, reviewing_sub_id, decision(accept or reject)
CREATE TABLE IF NOT EXISTS Reviewer (
    -- ID of the reviewer
    person_id INT NOT NULL,
    submission_id INT NOT NULL,
    decision decision_type NOT NULL,

    PRIMARY KEY (person_id, submission_id),
    FOREIGN KEY (person_id) REFERENCES ConferenceAttendee (attendee)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (submission_id) REFERENCES Submission (submission_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ConferenceSession (
    session_id INT PRIMARY KEY,
    conference_id INT NOT NULL,

    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,

    type submission_and_session_type NOT NULL

    FOREIGN KEY (session_id) REFERENCES ConferenceSession (session_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS SessionChair (
    session_id INT NOT NULL,
    chairperson INT NOT NULL,

    PRIMARY KEY (session_id, chairperson),
    FOREIGN KEY (session_id) REFERENCES ConferenceSession (session_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (chairperson) REFERENCES ConferenceAttendee (attendee)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS SessionPresentation (
    submission INT PRIMARY KEY,
    session_id INT NOT NULL,

    start_time TIMESTAMP NOT NULL,

    FOREIGN KEY (submission) REFERENCES Submission (submission_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (session_id) REFERENCES ConferenceSession (session_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF EXISTS Workshop (
    workshop_id INT PRIMARY KEY,
    conference INT NOT NULL,
    facilitator INT NOT NULL,

    FOREIGN KEY (conference) REFERENCES Conference (conference_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (faciliator) REFERENCES ConferenceAttendee (person_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF EXISTS WorkshopAttendee (
    workshop INT NOT NULL,
    attendee INT NOT NULL,

    PRIMARY KEY (workshop, attendee),
    FOREIGN KEY (workshop) REFERENCES Workshop (workshop_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (attendee) REFERENCES ConferenceAttendee (person_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

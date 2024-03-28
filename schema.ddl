DROP SCHEMA IF EXISTS Conference CASCADE;
CREATE SCHEMA Conference;
SET SEARCH_PATH TO Conference;

-- Type of a submission
CREATE TYPE Conference.submission_type AS ENUM('papers', 'posters');

-- Recommendation of a review
CREATE TYPE Conference.review_recommendation_status AS ENUM('accept', 'reject');

-- Final decision on a paper
CREATE TYPE Conference.paper_decision AS ENUM('accept', 'reject', 'pending');

-- Attendee type
CREATE TYPE Conference.attendee_type AS ENUM('student', 'other');

-- Metadata on a conference
CREATE TABLE IF NOT EXISTS Conference (
    conf_id INT NOT NULL, -- conference id
    conf_name TEXT NOT NULL, -- name of the conferennce
    conf_location TEXT NOT NULL, -- location of the conference
    conf_date DATE NOT NULL, -- date of the conference
    has_workshop BOOLEAN NOT NULL, -- if the conference has a workshop

    PRIMARY KEY (conf_location, conf_date)`
);

-- Metadata on submissions
CREATE TABLE IF NOT EXISTS Submission (
    submission_id INT UNIQUE NOT NULL, -- unique submission_id
    submission_name TEXT NOT NULL, -- submission name
    submission_type Conference.submission_type NOT NULL, -- submission type, either a paper or a poster
    sole_author_ids INT[] NOT NULL, -- author_id of the sole authors
    author_ids INT[] NOT NULL, -- author_id of the authors
    final_decision Conference.paper_decision NOT NULL, -- final decision of the submission
    organization TEXT NOT NULL, -- the organization of the submission

    PRIMARY KEY (submission_name, submission_type, author_ids)
);

-- Metadata of the authors
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT NOT NULL, -- unique author_id
    author_name TEXT NOT NULL, -- author name
    organization TEXT NOT NULL, -- organization of the author
    review_ids INT[], -- optional, review_ids of the submissions they reviewed

    PRIMARY KEY (author_id)
);

-- Metadata of the reviews
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT NOT NULL, -- unique review_id
    submission_id INT NOT NULL, -- submission_id of the reviewed submission
    recommendation review_recommendation_status NOT NULL, -- recommended decision of the review
    additional_conflicts TEXT, -- optional, additional conflict declaration

    PRIMARY KEY (review_id),
    FOREIGN KEY (submission_id) REFERENCES Submission(submission_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TODO: Constraint: at least one author on each paper must be a reviewer

-- TODO: Constraint: an author cannot review its own paper

-- TODO: Constraint: an author cannot review papers from the same organization

-- TODO: Constraint: a paper must have 3 reivews before a final decision

-- TODO: Constraint: a paper cannot be accepted without any 'accept' review suggestion


-- Metadata of the poster sessions
CREATE TABLE IF NOT EXISTS PosterSessions (
    conf_id INT NOT NULL,
    submission_id INT[] NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,

    CHECK(start_time < end_time),

    FOREIGN KEY (conf_id) REFERENCES Conference(conf_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (submission_id) REFERENCES Submission(submission_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Metadata of the paper sessions
CREATE TABLE IF NOT EXISTS PaperSessions (
    conf_id INT NOT NULL,
    subsession_id INT[] NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    chair -- TODO

    CHECK(start_time < end_time),

    FOREIGN KEY (conf_id) REFERENCES Conference(conf_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TODO: Constraint: chair not in authors

-- TODO: Constraint (?): chair has no other schedule

-- Subsessions under paper sessions
CREATE TABLE IF NOT EXISTS PaperSubSessions (
    subsession_id INT NOT NULL,
    submission_id INT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL

    CHECK(start_time < end_time),

    PRIMARY KEY (subsession_id),

    FOREIGN KEY (submission_id) REFERENCES Submission(submission_id)
        ON DELETE CASCADE ON UPDATE CASCADE


    -- TODO: Constraint: enforce start_time >= PaperSessions.start_time, end_time <= PaperSessions.end_time
);

-- TODO: Constraint: an author can have 2 presentations at the same time iff
-- 1. having a paper and a presentation at the same time
-- 2. not sole author in either

-- All attendees of all events
CREATE TABLE IF NOT EXISTS Attendees (
    attendee_id INT NOT NULL,
    conf_id INT NOT NULL,
    attendee_type attendee_type NOT NULL,

    PRIMARY KEY (attendee_id, conf_id),

    FOREIGN KEY (conf_id) REFERENCES Conference(conf_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TODO: Constraint: at least one author on every accpeted submission must be an attendee for the conference

CREATE TABLE IF NOT EXISTS Workshops (
    workshop_id INT NOT NULL,
    conf_id INT NOT NULL,
    facilitator TEXT NOT NULL,

    PRIMARY KEY (workshop_id),

    FOREIGN KEY (conf_id) REFERENCES Conference(conf_id)
        ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS WorkshopsAttendees (
    workshop_id INT NOT NULL,
    attendee_id INT NOT NULL,

    PRIMARY KEY (workshop_id, attendee_id),

    FOREIGN KEY (attendee_id) REFERENCES Attendee(attendee_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (workshop_id) REFERENCES Workshops(workshop_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

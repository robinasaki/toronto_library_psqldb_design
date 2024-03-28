DROP SCHEMA IF EXISTS Conference CASCADE;
CREATE SCHEMA Conference;
SET SEARCH_PATH TO Conference;

-- Type of a submission
CREATE TYPE Conference.submission_type AS ENUM('papers', 'posters');

-- Accept status of a paper submission
CREATE TYPE Conference.paper_accept_status AS ENUM('accept', 'reject');

-- Metadata on a conference
CREATE TABLE IF NOT EXISTS Conference (
    conf_name TEXT NOT NULL, -- name of the conferennce
    conf_location TEXT, -- location of the conference
    conf_date NOT NULL, -- date of the conference
    PRIMARY KEY (conf_location, conf_date)
);

-- Metadata on submissions
CREATE TABLE IF NOT EXISTS Submission (
    submission_id INT NOT NULL,
    submission_name TEXT NOT NULL,
    submission_type Conference.submission_type NOT NULL,
    author_ids INT[] NOT NULL,
    PRIMARY KEY (submission_id)
);

-- Metadata of the authors
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT NOT NULL,
    author_name TEXT NOT NULL,
    review_ids INT[], -- optional, review_ids of the submissions they reviewed
    PRIMARY KEY (author_id)
);

-- Metadata of the reviews
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT NOT NULL,
    decision Conference.paper_accept_status NOT NULL
);

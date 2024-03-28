DROP SCHEMA IF EXISTS Conference CASCADE;
CREATE SCHEMA Conference;
SET SEARCH_PATH TO Conference;

-- Accept status of a paper submission
CREATE TYPE Conference.paper_accept_status AS ENUM ('accept', 'reject');

-- Metadata on a conference
CREATE TABLE IF NOT EXISTS Conference (
    conf_name TEXT NOT NULL, -- name of the conferennce
    conf_location TEXT, -- location of the conference
    conf_date NOT NULL, -- date of the conference
    PRIMARY KEY (conf_location, conf_date)
)

-- Metadata on submissions that are "papers"
CREATE TABLE IF NOT EXISTS PaperSubmissions (
    paper_name TEXT NOT NULL, -- name of the paper submission
    paper_authors TEXT NOT NULL, -- authors of the paper
    paper_reviewer TEXT NOT NULL, -- reviewer of the paper
    paper_decision Conference.paper_accept_status NOT NULL -- whether the paper is accepted
)

-- Metadata on submissions that are "posters"
CREATE TABLE IF NOT EXISTS PosterSubmissions (
    poster_name TEXT NOT NULL, -- name of the poster submission
    poster_authors TEXT NOT NULL -- authors of the poster
)



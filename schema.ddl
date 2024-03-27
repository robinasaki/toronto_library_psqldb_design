DROP SCHEMA IF EXISTS Conference CASCADE;
CREATE SCHEMA Conference;
SET SEARCH_PATH TO Conference;

CREATE TABLE IF NOT EXISTS Conference {
    name TEXT NOT NULL,
    location TEXT,
    date NOT NULL,
    PRIMARY KEY (location, date)
}



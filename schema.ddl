DROP SCHEMA IF EXISTS Conference CASCADE;
CREATE SCHEMA Conference;
SET SEARCH_PATH TO Conference;

-- Final decision on a paper
CREATE TYPE Conference.paper_decision AS ENUM('accepted', 'rejected', 'pending');

-- Attendee type
CREATE TYPE Conference.attendee_type AS ENUM('student', 'other');

CREATE TABLE IF NOT EXISTS Conferences (
    conf_id INT UNIQUE NOT NULL,
    conf_name TEXT NOT NULL,
    conf_location TEXT NOT NULL,
    conf_date DATE NOT NULL,
    
    PRIMARY KEY (conf_location, conf_date)
);

CREATE TABLE IF NOT EXISTS Submissions (
    submission_id INT NOT NULL,
    submission_title TEXT NOT NULL,
    organization_id INT NOT NULL,
    author_ids INT[] NOT NULL,
    sole_author_ids INT[] NOT NULL,

    PRIMARY KEY (submission_id),

    FOREIGN KEY (author_ids) REFERENCES Authors(person_id)
    
    -- `sole_author_ids` must be a subset of `author_ids`
    CONSTRAINT sole_subset CHECK (
        author_ids @> sole_author_ids
    )
);

-- Trigger: a paper cannot be accepted without any 'accepted' review suggestion
CREATE OR REPLACE FUNCTION CheckAcceptReview RETURNS TRIGGER AS $$
    IF EXISTS (SELECT 1 FROM Reviews RV WHERE NEW.submission_id = RV.submission_id 
        AND NEW.paper_decision = 'accepted' 
        AND (SELECT COUNT(suggested_decision) FROM Reviews 
            WHERE submission_id = NEW.submission_id
            AND suggested_decision = 'accepted') = 0) THEN
        RAISE EXCEPTION 'A paper cannot be accepted without any accepted review suggestion'
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE IF NOT EXISTS PaperSubmissions (
    submission_id INT NOT NULL,
    paper_decision Conference.paper_decision,
    review_ids INT[]

    PRIMARY KEY (submission_id),

    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id),

    -- a paper must have at least 3 reviews to be accpeted
    CONSTRAINT accepted_cond CHECK (
        (paper_decision != 'accepted')
        OR
        (paper_decision = 'accpeted' AND COUNT(review_ids) >= 3)
    )
);

CREATE TABLE IF NOT EXISTS People (
    person_id INT NOT NULL,
    person_name TEXT NOT NULL,
    phone_num INT NOT NULL,
    email TEXT NOT NULL,

    PRIMARY KEY (person_id)
);

-- Trigger: each author must have at least one submission
CREATE OR REPLACE FUNCTION CheckAuthorExists() RETURNS TRIGGER AS $$
DECLARE
    author_found BOOLEAN;
BEGIN
    -- Check if person_id exists in any author_ids array in the Submissions table
    SELECT EXISTS(SELECT 1 FROM Submissions WHERE person_id = ANY(author_ids))
    INTO author_found;

    IF NOT author_found THEN
        RAISE EXCEPTION 'person_id must be an author in Submissions';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_check_author_before_insert_or_update
BEFORE INSERT OR UPDATE ON Authors
FOR EACH ROW EXECUTE FUNCTION CheckAuthorExists();

CREATE TABLE IF NOT EXISTS Authors (
    person_id INT NOT NULL,
    organization_id INT NOT NULL,

    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

-- Trigger: an author cannot review its own paper
CREATE OR REPLACE FUNCTION ReviewCheck() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Submissions WHERE submission_id = NEW.submission_id AND NEW.person_id = ANY(author_ids)) THEN
        RAISE EXCEPTION 'An author cannot review its own paper';
    END IF;
    ELSIF EXISTS (SELECT 1 FROM Submissions SB WHERE submission_id = NEW.submission_id AND NEW.organization_id = SB.organization_id) THEN
        RAISE EXCEPTION 'Cannot review papers from the same organization';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_review_check
BEFORE INSERT OR UPDATE ON Reviews
FOR EACH ROW EXECUTE FUNCTION ReviewCheck();
CREATE TABLE IF NOT EXISTS Reviews (
    person_id INT NOT NULL,
    review_id INT NOT NULL,
    submission_id INT NOT NULL,
    suggested_decision review_recommendation_status NOT NULL,
    comments TEXT, -- optional, comments on the review
    additional_conflicts TEXT, -- optional, additional conflict declaration

    PRIMARY KEY (review_id),

    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id)
)

-- Constraint: an author cannot review its own paper
CONSTRAINT no_self_review CHECK (
    -- I want person_id NOT IN author_ids (from Submissions)
    SELECT person_id, submission_id FROM Reviews RV
    JOIN Submissions SM ON RV.submission_id = SM.submission_id
)


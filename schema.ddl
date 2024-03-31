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
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    
    PRIMARY KEY (conf_location, start_time, end_time),

    CHECK(start_time < end_time)
);

CREATE TABLE IF NOT EXISTS Submissions (
    submission_id INT NOT NULL,
    submission_title TEXT NOT NULL,
    conf_id INT NOT NULL,
    organization TEXT NOT NULL, -- not necessary related to the authors' organization

    PRIMARY KEY (submission_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id)
);

CREATE TABLE IF NOT EXISTS PaperSubmissions (
    submission_id INT NOT NULL,
    paper_decision Conference.paper_decision,

    PRIMARY KEY (submission_id), 
    -- we could remove the above primary key, but for marking purpose we decided to not to.

    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id)
);

CREATE TABLE IF NOT EXISTS People (
    person_id INT NOT NULL,
    first_name TEXT NOT NULL,
    middle_name TEXT, -- optional, middle name
    last_name TEXT NOT NULL, 
    phone_num INT NOT NULL,
    email TEXT NOT NULL,
    organization TEXT NOT NULL,
    type Conference.attendee_type NOT NULL,

    PRIMARY KEY (person_id)
);

-- Instances of paper contributions.
CREATE TABLE IF NOT EXISTS Contributes (
    submission_id INT NOT NULL,
    person_id INT NOT NULL,
    sole_author BOOLEAN NOT NULL,

    PRIMARY KEY (submission_id, person_id),

    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

CREATE TABLE IF NOT EXISTS Reviews (
    person_id INT NOT NULL,
    review_id INT NOT NULL,
    submission_id INT NOT NULL,
    suggested_decision review_recommendation_status NOT NULL,
    comments TEXT, -- optional, comments on the review
    additional_conflicts TEXT, -- optional, additional conflict declaration

    PRIMARY KEY (review_id),

    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id)
);

-- Trigger: a paper must have at least 3 reviews to be accpeted
CREATE OR REPLACE FUNCTION CheckAtLeastThreeReviews RETURNS TRIGGER AS $$
    IF (NEW.paper_decision = 'accepted') THEN
        IF ((SELECT COUNT(*) FROM Review RV WHERE RV.submission_id = NEW.submission_id) < 3) THEN
            RAISE EXCEPTION 'A paper must have 3 reviews to be accepted';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgCheckAtLeastThreeReviews
BEFORE INSERT OR UPDATE ON PaperSubmissions
FOR EACH ROW EXECUTE FUNCTION CheckAtLeastThreeReviews();

-- Trigger: an author cannot review its own paper
CREATE OR REPLACE FUNCTION CheckSelfReview RETURNS TRIGGER AS $$
    IF EXISTS (SELECT 1 FROM Contributes PC WHERE PC.person_id = NEW.person_id
        AND PC.submission_id = NEW.submission_id) THEN
            RAISE EXCEPTION 'An author cannot review its own paper.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgCheckSelfReview
BEFORE INSERT OR UPDATE ON Reviews
FOR EACH ROW EXECUTE FUNCTION CheckSelfReview();

-- Trigger: a paper cannot be accepted without any 'accepted' review suggestion
CREATE OR REPLACE FUNCTION CheckAcceptReview RETURNS TRIGGER AS $$
    IF EXISTS (SELECT 1 FROM Reviews RV WHERE NEW.submission_id = RV.submission_id 
        AND NEW.paper_decision = 'accepted' 
        AND (SELECT COUNT(suggested_decision) FROM Reviews 
            WHERE submission_id = NEW.submission_id
            AND suggested_decision = 'accepted') = 0) THEN
            RAISE EXCEPTION 'A paper cannot be accepted without any accepted review suggestion.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgCheckAcceptReview
BEFORE INSERT OR UPDATE ON PaperSubmissions
FOR EACH ROW EXECUTE FUNCTION CheckAcceptReview();

-- Trigger: each author must have at least one submission
CREATE OR REPLACE FUNCTION CheckAuthorExists() RETURNS TRIGGER AS $$
DECLARE
    author_found BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM Contributions WHERE person_id = NEW.person_id)
    INTO author_found;

    IF NOT author_found THEN
        RAISE EXCEPTION 'person_id must have at least one submission.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgCheckAuthorExists
BEFORE INSERT OR UPDATE ON Authors
FOR EACH ROW EXECUTE FUNCTION CheckAuthorExists();

-- Trigger: an author cannot review its own paper and papers from its organization
CREATE OR REPLACE FUNCTION ReviewCheck() RETURNS TRIGGER AS $$
BEGIN
    -- an author cannot review its own paper
    IF EXISTS (SELECT 1 FROM Contribtues WHERE submission_id = NEW.submission_id 
        AND Contributes.person_id = NEW.person_id) THEN
            RAISE EXCEPTION 'An author cannot review its own paper.';
    END IF;

    -- cannot review papers from its organization
    ELSIF EXISTS (
        SELECT 1
        FROM Reviews RV
        JOIN People P ON RV.person_id = P.person_id
        JOIN Submissions S ON RV.submission_id = S.submission_id
        WHERE RV.person_id = NEW.person_id
        AND RV.submission_id = NEW.submission_id
        AND P.organization = S.organization
        ) THEN
            RAISE EXCEPTION 'An author cannot review papers from its own organization.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgReviewCheck
BEFORE INSERT OR UPDATE ON Reviews
FOR EACH ROW EXECUTE FUNCTION ReviewCheck();

-- Trigger: at least one author on each paper must be a reviewer
CREATE OR REPLACE FUNCTION ReviewEnforceCheck() RETURN TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Reviews WHERE person_id = NEW.person_id) THEN
        RAISE EXCEPTION 'At least one author on each paper must be a reviewer';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgReviewEnforceCheck
BEFORE INSERT OR UPDATE ON Contributes
FOR EACH ROW EXECUTE FUNCTION ReviewEnforceCheck();

CREATE TABLE IF NOT EXISTS ConferenceSessions (
    conf_id INT NOT NULL,
    session_id INT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,

    PRIMARY KEY (conf_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),

    CHECK (start_time < end_time)
);

-- Trigger: the session's start_time must <= conference's start_time, and end_time
CREATE OR REPLACE FUNCTION SessionTimeCheck() RETURN TRIGGER $$
    IF EXISTS (SELECT 1 FROM Conferences WHERE Conferences.conf_id = NEW.conf_id
        AND Conferences.start_time > NEW.start_time) THEN
            RAISE EXCEPTION 'Session start_time must <= conference start_time';
    END IF;
    ELSIF EXISTS (SELECT 1 FROM Conferences WHERE Conferences.conf_id = NEW.conf_id
        AND Conferneces.end_time < NEW.end_time) THEN
            RAISE EXCEPTION 'Session end_time must > conference end_time';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgSessionTimeCheck
BEFORE INSERT OR UPDATE ON ConferenceSessions
FOR EACH ROW EXECUTE FUNCTION SessionTimeCheck();

CREATE TABLE IF NOT EXISTS SessionChair (
    session_id INT NOT NULL,
    person_id INT NOT NULL,

    PRIMARY KEY (session_id, person_id),

    FOREIGN KEY (session_id) REFERENCES ConferenceSessions(session_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

-- TODO: Constraint: chair has not other schedules (?)

CREATE TABLE IF NOT EXISTS SessionPresentation (
    submission_id INT NOT NULL,
    session_id INT NOT NULL,

    PRIMARY KEY (submission_id, session_id),
    
    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id),
    FOREIGN KEY (session_id) REFERENCES ConferenceSessions(session_id)
);

-- Trigger: chair is not an author in the auduited session
CREATE OR REPLACE FUNCTION ChairNotAuthor() RETURN TRIGGER AS $$
    IF EXISTS (
        SELECT 1
        FROM Contributes C JOIN SessionPresentation SP ON C.submission_id = SP.submission_id
        WHERE NEW.session_id = session_id AND NEW.person_id = person_id
    ) THEN
        RAISE EXCEPTION 'Chair cannot be author in the session';
    END IF;
    RETURN NEW;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgChairNotAuthor
BEFORE INSERT OR UPDATE ON SessionChair
FOR EACH ROW EXECUTE FUNCTION ChairNotAuthor();

-- TODO: Constraint: an author can have 2 presentations at the same time iff
-- 1. having a paper and a poster presentation at the same time
-- 2. not a sole author in either

CREATE TABLE IF NOT EXISTS Workshops (
    workshop_id INT NOT NULL,
    conf_id INT NOT NULL,
    facilitator INT NOT NULL,

    PRIMARY KEY (workshop_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),
    FOREIGN KEY (facilitator) REFERENCES People(person_id) 
);

CREATE TABLE IF NOT EXISTS WorkshopAttendees (
    workshop_id INT NOT NULL,
    person_id INT NOT NULL,
    
    PRIMARY KEY (workshop_id, person_id),

    FOREIGN KEY (workshop_id) REFERENCES Workshops(workshop_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

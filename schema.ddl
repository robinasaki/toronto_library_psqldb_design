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
    FOREIGN KEY (conf_chair) REFERENCES People(person_id)

    CHECK(start_time < end_time)
);

-- The chair(s) of each conference
CREATE TABLE IF NOT EXISTS ConferenceChair (
    conf_id INT NOT NULL,
    chair INT NOT NULL,

    PRIMARY KEY (conf_id, chair),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),
    FOREIGN KEY (chair) REFERENCES People(person_id)
);

-- Members of each conference's committee
CREATE TABLE IF NOT EXISTS ConferenceCommittee (
    conf_id INT NOT NULL,
    committee_member INT NOT NULL,

    PRIMARY KEY (conf_id, committee_member),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),
    FOREIGN KEY (committee_member) REFERENCES People(person_id)
);

-- Trigger: Conferences must have 1+ conference chairs, who must have been on the org committe 
-- 2+ times prior
CREATE OR REPLACE FUNCTION ChairAndCommitteeReq() RETURNS TRIGGER AS $$
BEGIN
    -- Check if a conference has any chair at all
    IF EXISTS (
        SELECT 1
        FROM Conferences JOIN ConferenceChair ON Conferences.conf_id = ConferenceChair.conf_id
        WHERE Conferences.conf_id = NEW.conf_id
    ) THEN
        -- Check if chair has been on org committee of conference 2+ times
        -- Assuming conference name stays same across all iterations/years of conference
        IF EXISTS (
            SELECT Conferences.conf_name, ConferenceCommittee.committee_member, COUNT(Conferences.conf_name)
            FROM Conferences JOIN ConferenceChair ON Conferences.conf_id = ConferenceChair.conf_id
            JOIN ConferenceCommittee ON ConferenceCommittee.conf_id = Conferences.conf_id AND ConferenceCommittee.committee_member = ConferenceChair.chair
            WHERE Conferences.conf_id = NEW.conf_id
            GROUP BY Conferences.conf_name, ConferenceCommittee.committee_member
            HAVING count(Conferences.conf_name) >= 2
        ) THEN
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'Conference chair must have been on committee 2+ time prior';
        END IF;
    ELSE
        RAISE EXCEPTION 'Conference must have at least one chairperson';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgChairAndCommitteeReq
AFTER INSERT OR UPDATE ON Conferences
FOR EACH ROW EXECUTE FUNCTION ChairAndCommitteeReq();

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
    suggested_decision paper_decision NOT NULL,
    comments TEXT, -- optional, comments on the review
    additional_conflicts TEXT, -- optional, additional conflict declaration

    PRIMARY KEY (review_id),

    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id)
);

-- Trigger: a paper must have at least 3 reviews to be accepted
CREATE OR REPLACE FUNCTION CheckAtLeastThreeReviews() RETURNS TRIGGER AS $$
BEGIN
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
CREATE OR REPLACE FUNCTION CheckSelfReview() RETURNS TRIGGER AS $$
BEGIN
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
CREATE OR REPLACE FUNCTION CheckAcceptReview() RETURNS TRIGGER AS $$
BEGIN
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

-- Trigger: an author cannot review its own paper and papers from its organization
CREATE OR REPLACE FUNCTION ReviewCheck() RETURNS TRIGGER AS $$
BEGIN
    -- an author cannot review its own paper
    IF EXISTS (SELECT 1 FROM Contributes WHERE submission_id = NEW.submission_id 
        AND Contributes.person_id = NEW.person_id) THEN
            RAISE EXCEPTION 'An author cannot review its own paper.';
    END IF;

    -- cannot review papers from its organization
    IF EXISTS (
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
CREATE OR REPLACE FUNCTION ReviewEnforceCheck() RETURNS TRIGGER AS $$
DECLARE
    author_reviewer_count INT;
BEGIN
    -- Count how many authors of the paper being reviewed have also been reviewers
    SELECT COUNT(DISTINCT C.person_id)
    INTO author_reviewer_count
    FROM Contributes C
    INNER JOIN Reviews R ON C.person_id = R.person_id
    WHERE C.submission_id = NEW.submission_id;

    IF author_reviewer_count = 0 THEN
        RAISE EXCEPTION 'At least one author on each paper must be a reviewer';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgReviewEnforceCheck
AFTER INSERT OR UPDATE ON Reviews
FOR EACH ROW EXECUTE FUNCTION ReviewEnforceCheck();

CREATE TABLE IF NOT EXISTS ConferenceSessions (
    conf_id INT NOT NULL,
    session_id INT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,

    PRIMARY KEY (session_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),

    CHECK (start_time < end_time)
);

CREATE TABLE IF NOT EXISTS Attends (
    person_id INT NOT NULL,
    conf_id INT NOT NULL,

    PRIMARY KEY (person_id, conf_id),

    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id)
);

-- Trigger: the session's start_time must <= conference's start_time, and end_time
CREATE OR REPLACE FUNCTION SessionTimeCheck() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Conferences WHERE Conferences.conf_id = NEW.conf_id
        AND Conferences.start_time > NEW.start_time) THEN
            RAISE EXCEPTION 'Session start_time must <= conference start_time';
    END IF;
    IF EXISTS (SELECT 1 FROM Conferences WHERE Conferences.conf_id = NEW.conf_id
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

CREATE TABLE IF NOT EXISTS SessionPresentations (
    submission_id INT NOT NULL,
    session_id INT NOT NULL,

    PRIMARY KEY (submission_id, session_id),
    
    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id),
    FOREIGN KEY (session_id) REFERENCES ConferenceSessions(session_id)
);

-- Trigger: chair is not an author in the auduited session
CREATE OR REPLACE FUNCTION ChairNotAuthor() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Contributes C JOIN SessionPresentations SP ON C.submission_id = SP.submission_id
        WHERE NEW.session_id = session_id AND NEW.person_id = person_id
    ) THEN
        RAISE EXCEPTION 'Chair cannot be author in the session';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgChairNotAuthor
BEFORE INSERT OR UPDATE ON SessionChair
FOR EACH ROW EXECUTE FUNCTION ChairNotAuthor();

-- Trigger: an author can have 2 presentations at the same time iff
-- 1. having a paper and a poster presentation at the same time AND
-- 2. not a sole author in either
CREATE OR REPLACE FUNCTION PresentationAvailbilityCheck() RETURNS TRIGGER AS $$
BEGIN
    -- Check if the author is trying to have two presentations at the same time
    IF (SELECT COUNT(*) FROM SessionPresentations WHERE session_id = NEW.session_id AND submission_id = NEW.submission_id) >= 2 THEN
        -- Check if one is a paper and the other is a poster
        IF EXISTS (
            SELECT 1 FROM SessionPresentations SP
            JOIN PaperSubmissions PS ON SP.submission_id = PS.submission_id
            WHERE SP.session_id = NEW.session_id AND PS.paper_decision = 'accepted'
            AND EXISTS (
                SELECT 1 FROM SessionPresentations SP2
                WHERE SP2.session_id = SP.session_id AND SP2.submission_id != SP.submission_id
                -- Assuming there is a way to distinguish between paper and poster
                AND SP2.presentation_type != SP.presentation_type
            )
        ) THEN
            -- Check that the author is not a sole author in either presentation
            IF EXISTS (
                SELECT 1 FROM Contributes C
                WHERE C.submission_id = NEW.submission_id
                AND (SELECT COUNT(*) FROM Contributes C2 WHERE C2.submission_id = C.submission_id) > 1
            ) THEN
                RETURN NEW; -- All conditions met, allow the presentation
            ELSE
                RAISE EXCEPTION 'The author must not be a sole author in either presentation type.';
            END IF;
        ELSE
            RAISE EXCEPTION 'An author can only have a paper and a poster presentation at the same time if they are not the sole author in either.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgPresentationAvailbilityCheck
BEFORE INSERT OR UPDATE ON SessionPresentations
FOR EACH ROW EXECUTE FUNCTION PresentationAvailbilityCheck();

-- TODO: at least one author per accepted submission must attend the conference
CREATE OR REPLACE FUNCTION AtLeastOneRegistered() RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.paper_decision = 'accepted') THEN
        IF EXISTS (
            SELECT 1
            FROM PaperSubmissions JOIN Submissions ON PaperSubmissions.submission_id = Submissions.submission_id
            JOIN Contributes ON Submissions.submission_id = Contributes.submission_id
            JOIN Attends ON Contributes.person_id = Attends.person_id AND Submissions.conf_id = Attends.conf_id
            WHERE PaperSubmissions.paper_decision = 'accepted'
            AND Submissions.submission_id = NEW.submission_id
        ) THEN
            RETURN NEW;
        ELSE 
            RAISE EXCEPTION 'At least one author must be registered at the conference where their paper is accepted';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgAtLeastOneRegistered
BEFORE INSERT OR UPDATE ON PaperSubmissions
FOR EACH ROW EXECUTE FUNCTION AtLeastOneRegistered();


CREATE TABLE IF NOT EXISTS Workshops (
    workshop_id INT NOT NULL,
    conf_id INT NOT NULL,
    -- facilitator INT NOT NULL,

    PRIMARY KEY (workshop_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),
    FOREIGN KEY (facilitator) REFERENCES People(person_id) 
);

CREATE TABLE IF NOT EXISTS WorkshopFacilitator (
    workshop_id INT NOT NULL,
    person_id INT NOT NULL,

    PRIMARY KEY (workshop_id, person_id),

    FOREIGN KEY (workshop_id) REFERENCES Workshops(workshop_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

CREATE TABLE IF NOT EXISTS WorkshopAttendees (
    workshop_id INT NOT NULL,
    person_id INT NOT NULL,
    
    PRIMARY KEY (workshop_id, person_id),

    FOREIGN KEY (workshop_id) REFERENCES Workshops(workshop_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

-- Trigger: All workshops must have one facilitator
CREATE OR REPLACE FUNCTION WorkshopHasFacilitator() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Workshop JOIN WorkshopFacilitator ON Workshop.workshop_id = WorkshopFacilitator.workshop_id
        WHERE Workshop.workshop_id = NEW.workshop_id
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Workshop must have at least one facilitator';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TrgWorkshopHasFacilitator
BEFORE INSERT OR UPDATE ON Workshops
FOR EACH ROW EXECUTE FUNCTION WorkshopHasFacilitator();
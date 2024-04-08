/*
===========
COULD NOT:
- Prevent reviewers from reviewing their own submissions/those of
  co-authors or others in their org. This requires data from multiple tables
  (Reviews, People, Submissions): we would create lists of authors for all 
  submissions and people from the orgs, then compare the person_id of the 
  reviewer against the relevant lists, which is not possible with only
  CHECK and foreign key constraints.
- Require three reviews before accepting, or sub. This requires
  comparisons between two different tables (Reviews and Submissions)
  and so requires a trigger.
- Prevent previously accepted submissions from being submitted again. This 
  would require an trigger to check for the existence of an accepted 
  submission of the same paper/poster.
- Reqire session chairs to attend the conference, not be an author there,
  and not have other things scheduled. We would need to check the potential 
  session chair entry for whether they have registered for that conference 
  (table Attends), whether they have an accepted submission there (conf_id 
  and decision in Submissions), and whether any of activities in other 
  conferences overlap with this conference. This requires a trigger.
- Require 1+ authors to be registered for the conference. This requires 
  checking all accepted submissions in Submissions for their authors, then 
  checking if one or more is registered in Attends; this needs a trigger.
- Require conference chairs to have been on the organizing committee at 
  least twice before being conference chair unless the conference is too new.
  We must check the organizing committee table for the proposed conference
  chair, to see if they've been on it at least twice for that conference
  (taking into account if the conference is less than two years old, which 
  would mean this is not relevant). This requires a trigger.

All the above constraints require either triggers or assertions, as they require
more information than a foreign key constraint or CHECK constraint can manage.

===========
DID NOT:
- Require a workshop to have a faciliator. This could have been enforced by 
  putting the faciliator information inside of Workshops instead of its own 
  table WorkshopFacilitator, but this could have introduced redundancies if 
  a workshop had more than 1 facilitator, which is possible. 
- Prevent anonymous submissions. This would have been possible if we had put 
  the authors for a submissions in the Submissions table, with all the
  other submission information, but since there can be multiple, doing so 
  would have required variable-length arrays/lists, which make it hard to 
  manipulate/do comparisons; placing authors in a separate table, with one 
  author per tuple, also facilitated other constraints and data comparisons. 
- Ensure at least one author on each paper must be a reviewer. Like above, 
  this would be possible if the authors were in the Submissions table, we 
  could have had a list of reviewers in each submission tuple. However, this 
  was not done for the reasons above.

===========
EXTRA CONSTRAINTS:
- Every author of a paper must have an order number, which MUST be
  positive. This order number represents their order on the submission.

===========
ASSUMPTIONS:    
- The name of the conference will uniquely identify a conference occuring 
  over multiple years (e.g. "SE Conference" can occur in 2015, 2016, 2018)
- There is only one chairperson per conference.
- Every organization may have different policies related to what a 'student'
  is, so a 'student' status is not universal for a particular person. 
  'Student' status is thus determined on a conference-by-conference basis.
        
*/

DROP SCHEMA IF EXISTS Conference CASCADE;
CREATE SCHEMA Conference;
SET SEARCH_PATH TO Conference;

-- Final decision on a paper
CREATE TYPE Conference.submission_decision AS ENUM('accepted', 'rejected', 'pending');

-- Attendee type
CREATE TYPE Conference.attendee_type AS ENUM('student', 'other');

CREATE TYPE Conference.submission_type AS ENUM('paper', 'poster');

/*
    Details of all people involved in the conferences 

    (authors, reviewers, chairs, etc.)
    person_id: Unique id identifying person.
    first_name, last_name: Person's name.
    phone_num: Person's phone number.
    email: Person's email.
    organization: The organization the person is associated with.
*/
CREATE TABLE IF NOT EXISTS People (
    person_id INT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL, 
    phone_num INT NOT NULL,
    email TEXT NOT NULL,
    organization TEXT NOT NULL,

    PRIMARY KEY (person_id)
);

/*
    Every conference.

    conf_id: Unique ID for each conference.
    conf_name: Name of the conference.
    conf_location: Location of the conference.
    start_time: Date and time the conference begins.
    end_time: Date and time the conference ends.
*/
CREATE TABLE IF NOT EXISTS Conferences (
    conf_id INT UNIQUE NOT NULL, 
    conf_name TEXT NOT NULL,
    conf_location TEXT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,

    PRIMARY KEY (conf_location, start_time, end_time),

    CHECK(start_time < end_time)
);

/*
    The chair(s) of each conference.

    conf_id: The ID of a conference.
    chair: The chairperson.
*/
CREATE TABLE IF NOT EXISTS ConferenceChair (
    conf_id INT NOT NULL,
    chair INT NOT NULL,

    PRIMARY KEY (conf_id, chair),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),
    FOREIGN KEY (chair) REFERENCES People(person_id)
);

/*
    Member of each conference's committee.

    conf_id: The ID of a conference.
    committee_member: The committee member.
*/
CREATE TABLE IF NOT EXISTS ConferenceCommittee (
    conf_id INT NOT NULL,
    committee_member INT NOT NULL,

    PRIMARY KEY (conf_id, committee_member),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),
    FOREIGN KEY (committee_member) REFERENCES People(person_id)
);

/*
    Paper/poster submissions to every conference.

    submission_id: Unique id identifying the submission.
    submission_title: Title of the submission.
    conf_id: Conference item was submitted to.
    organization: Org that submission is associated with. May be
                  different than the org(s) that its authors are with.
    submission_type: whether the submission is a paper or poster.
    decision: Whether the submission was rejected or accepted.
*/
CREATE TABLE IF NOT EXISTS Submissions (
    submission_id INT NOT NULL,
    submission_title TEXT NOT NULL,
    conf_id INT NOT NULL,

    -- not necessary related to the authors' organization
    organization TEXT NOT NULL, 

    submission_type Conference.submission_type NOT NULL,
    decision Conference.submission_decision,

    PRIMARY KEY (submission_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id)
);



/*
    Authors contributing to each paper/poster.

    submission_id: Submission author is contributing to.
    person_id: The author.
    sole_author: Whether the author is the only one on the submission.
    author_num: The place of this author on the submission's author order (order
                of authors matters for papers in particular)
*/
CREATE TABLE IF NOT EXISTS Contributes (
    submission_id INT NOT NULL,
    person_id INT NOT NULL,
    sole_author BOOLEAN NOT NULL,
    author_num INT NOT NULL,

    PRIMARY KEY (submission_id, person_id),

    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id),

    CHECK (author_num > 0) -- Can't have negative author order
);

/*
    All reviews of submissions.

    person_id: The reviewer.
    review_id: Unique id identifying the review.
    submission_id: Submission the review is for.
    suggested_decision: The decision of the review (accept/reject).
    comments: Review comments. Optional.
    additional_conflicts: Any additional conflicts the reviewer may have. Optional.
*/
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT NOT NULL,
    person_id INT NOT NULL, -- The reviewer
    
    submission_id INT NOT NULL,
    suggested_decision Conference.submission_decision NOT NULL,
    comments TEXT, -- optional, comments on the review
    additional_conflicts TEXT, -- optional, additional conflict declaration

    PRIMARY KEY (review_id),

    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id)
);

/*
    All sessions in each conference.

    conf_id: Conference the session is in.
    session_id: Unique id identifying session.
    start_time: Time and day the session begins.
    end_time: Time and day the session ends.
    session_type: Whether the session is for papers or posters.
*/
CREATE TABLE IF NOT EXISTS Sessions (
    conf_id INT NOT NULL,
    session_id INT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    session_type Conference.submission_type NOT NULL,

    PRIMARY KEY (session_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id),

    CHECK (start_time < end_time)
);

/*
    All people registered for each conference.

    person_id: The person registered for a conference.
    conf_id: The conference the person is registered for.
*/
CREATE TABLE IF NOT EXISTS Attends (
    person_id INT NOT NULL,
    conf_id INT NOT NULL,
    type Conference.attendee_type NOT NULL,

    PRIMARY KEY (person_id, conf_id),

    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id)
);

/*
    All chairpersons for each session.

    session_id: The session.
    person_id: The chairperson for that session.
*/
CREATE TABLE IF NOT EXISTS SessionChair (
    session_id INT NOT NULL,
    person_id INT NOT NULL,

    PRIMARY KEY (session_id, person_id),

    FOREIGN KEY (session_id) REFERENCES Sessions(session_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

/*
    Which session each accepted submission is presented in.

    submission_id: The accepted submission.
    session_id: Session the submission will be presented in.
*/
CREATE TABLE IF NOT EXISTS SessionPresentations (
    submission_id INT NOT NULL,
    session_id INT NOT NULL,

    PRIMARY KEY (submission_id, session_id),
    
    FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id),
    FOREIGN KEY (session_id) REFERENCES Sessions(session_id)
);

/*
    All conference workshops.

    workshop_id: Unique id identifying the workshop.
    conf_id: Conference the workshop is a part of.
*/
CREATE TABLE IF NOT EXISTS Workshops (
    workshop_id INT NOT NULL,
    conf_id INT NOT NULL,

    PRIMARY KEY (workshop_id),

    FOREIGN KEY (conf_id) REFERENCES Conferences(conf_id)
);

/*
    Facilitator(s) for each workshop.

    workshop_id: Workshop the faciliator is a part of.
    person_id: The facilitator.
*/
CREATE TABLE IF NOT EXISTS WorkshopFacilitator (
    workshop_id INT NOT NULL,
    person_id INT NOT NULL,

    PRIMARY KEY (workshop_id, person_id),

    FOREIGN KEY (workshop_id) REFERENCES Workshops(workshop_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

/*
    Registered attendees for each workshop.

    workshop_id: The workshop being registered for.
    person_id: The registered attendee.
*/
CREATE TABLE IF NOT EXISTS WorkshopAttendees (
    workshop_id INT NOT NULL,
    person_id INT NOT NULL,
    
    PRIMARY KEY (workshop_id, person_id),

    FOREIGN KEY (workshop_id) REFERENCES Workshops(workshop_id),
    FOREIGN KEY (person_id) REFERENCES People(person_id)
);

SET SEARCH_PATH TO Conference, public;

DROP TABLE IF EXISTS q2 CASCADE;
CREATE TABLE q2 (
    person_id INT NOT NULL,
    conference_count INT NOT NULL  
);

SELECT DISTINCT person_id, COUNT(DISTINCT conf_id) AS conference_count
INTO q2
FROM Attends;

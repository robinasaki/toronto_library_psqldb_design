SET SEARCH_PATH TO Conference;

-- Import Data for People
INSERT INTO People VALUES (1, 'Michelle', 'Craig', 1234567890, 'mcragge@imperialcollege.com', 'Imperial College London');
INSERT INTO People VALUES (2, 'Jennifer', 'Campbell', 1234567890, 'jenny@utoronto.ca', 'University of Waterloo');
INSERT INTO People VALUES (3, 'Sadia', 'Sharmin', 1234567890, 'abdul@kfu.edu.sa', 'King Faisal University');
INSERT INTO People VALUES (4, 'Jonathan', 'Calver', 1234567890, 'abdul@kfu.edu.sa', 'King Faisal University');
INSERT INTO People VALUES (5, 'Larry Yueli', 'Zhang', 1234567890, 'abdul@kfu.edu.sa', 'King Faisal University');
INSERT INTO People VALUES (6, 'Diane', 'Horton', 1234567890, 'abdul@kfu.edu.sa', 'King Faisal University');
INSERT INTO People VALUES (7, 'Daniel', 'Zingaro', 1234567890, 'abdul@kfu.edu.sa', 'King Faisal University');
INSERT INTO People VALUES (8, 'Danny', 'Heap', 1234567890, 'abdul@kfu.edu.sa', 'King Faisal University');

-- Import Data for Conferences
INSERT INTO Conferences VALUES (1, 'SIGCSE TS', 'Toronto', '2010-10-19 10:00:00', '2010-10-19 18:00:00');
INSERT INTO Conferences VALUES (2, 'SIGCSE TS', 'Toronto', '2011-10-19 10:00:00', '2011-10-19 18:00:00');
INSERT INTO Conferences VALUES (3, 'SIGCSE TS', 'Toronto', '2012-10-19 10:00:00', '2012-10-19 18:00:00');
INSERT INTO Conferences VALUES (4, 'SIGCSE TS', 'Toronto', '2013-10-19 10:00:00', '2013-10-19 18:00:00');
INSERT INTO Conferences VALUES (5, 'SIGCSE TS', 'Toronto', '2014-10-19 10:00:00', '2014-10-19 18:00:00');
INSERT INTO Conferences VALUES (6, 'SIGCSE TS', 'Toronto', '2015-10-19 10:00:00', '2015-10-19 18:00:00');
INSERT INTO Conferences VALUES (7, 'SIGCSE TS', 'Toronto', '2016-10-19 10:00:00', '2016-10-19 18:00:00');
INSERT INTO Conferences VALUES (8, 'SIGCSE TS', 'Toronto', '2017-10-19 10:00:00', '2017-10-19 18:00:00');
INSERT INTO Conferences VALUES (9, 'SIGCSE TS', 'Toronto', '2018-10-19 10:00:00', '2018-10-19 18:00:00');
INSERT INTO Conferences VALUES (10, 'SIGCSE TS', 'Toronto', '2019-10-19 10:00:00', '2019-10-19 18:00:00');
INSERT INTO Conferences VALUES (11, 'SIGCSE TS', 'Toronto', '2020-10-19 10:00:00', '2020-10-19 18:00:00');
INSERT INTO Conferences VALUES (12, 'SIGCSE TS', 'Toronto', '2021-10-19 10:00:00', '2021-10-19 18:00:00');
INSERT INTO Conferences VALUES (13, 'SIGCSE TS', 'Toronto', '2022-10-19 10:00:00', '2022-10-19 18:00:00');
INSERT INTO Conferences VALUES (14, 'SIGCSE TS', 'Toronto', '2023-10-19 10:00:00', '2023-10-19 18:00:00');
INSERT INTO Conferences VALUES (15, 'SIGCSE TS', 'Toronto', '2024-10-19 10:00:00', '2024-10-19 18:00:00');
INSERT INTO Conferences VALUES (16, 'SIGCSE TS', 'Toronto', '2025-10-19 10:00:00', '2025-10-19 18:00:00');

INSERT INTO Conferences VALUES (17, 'CompEd', 'Toronto', '2019-10-21 10:00:00', '2019-10-21 18:00:00');
INSERT INTO Conferences VALUES (18, 'CompEd', 'Toronto', '2021-10-21 10:00:00', '2021-10-21 18:00:00');
INSERT INTO Conferences VALUES (19, 'CompEd', 'Toronto', '2023-10-21 10:00:00', '2023-10-21 18:00:00');
INSERT INTO Conferences VALUES (20, 'CompEd', 'Toronto', '2025-10-21 10:00:00', '2025-10-21 18:00:00');

INSERT INTO Conferences VALUES (21, 'JoeClub', 'Silesia', '2006-10-10 10:00:00', '2006-10-11 10:00:00');
INSERT INTO Conferences VALUES (22, 'HelloWorld', 'Toronto', '2004-10-21 10:00:00', '2004-10-21 18:00:00');
INSERT INTO Conferences VALUES (23, 'TomClancyClub', 'Toronto', '2005-10-21 10:00:00', '2005-10-21 18:00:00');

-- Import Data for ConferenceChair
INSERT INTO ConferenceChair VALUES (1, 1);
INSERT INTO ConferenceChair VALUES (2, 1);
INSERT INTO ConferenceChair VALUES (3, 1);
INSERT INTO ConferenceChair VALUES (4, 1);
INSERT INTO ConferenceChair VALUES (5, 1);
INSERT INTO ConferenceChair VALUES (6, 1);
INSERT INTO ConferenceChair VALUES (7, 1);
INSERT INTO ConferenceChair VALUES (8, 1);
INSERT INTO ConferenceChair VALUES (9, 1);
INSERT INTO ConferenceChair VALUES (10, 1);
INSERT INTO ConferenceChair VALUES (11, 1);
INSERT INTO ConferenceChair VALUES (12, 1);
INSERT INTO ConferenceChair VALUES (13, 1);
INSERT INTO ConferenceChair VALUES (14, 1);
INSERT INTO ConferenceChair VALUES (15, 1);
INSERT INTO ConferenceChair VALUES (16, 1);
INSERT INTO ConferenceChair VALUES (17, 1);
INSERT INTO ConferenceChair VALUES (18, 1);
INSERT INTO ConferenceChair VALUES (19, 1);
INSERT INTO ConferenceChair VALUES (20, 1);
INSERT INTO ConferenceChair VALUES (21, 4);
INSERT INTO ConferenceChair VALUES (22, 4);
INSERT INTO ConferenceChair VALUES (23, 4);

-- Import Data for ConferenceCommittee
INSERT INTO ConferenceCommittee VALUES (1, 1);
INSERT INTO ConferenceCommittee VALUES (2, 1);
INSERT INTO ConferenceCommittee VALUES (3, 1);
INSERT INTO ConferenceCommittee VALUES (4, 1);
INSERT INTO ConferenceCommittee VALUES (5, 1);
INSERT INTO ConferenceCommittee VALUES (6, 1);
INSERT INTO ConferenceCommittee VALUES (7, 1);
INSERT INTO ConferenceCommittee VALUES (8, 1);
INSERT INTO ConferenceCommittee VALUES (9, 1);
INSERT INTO ConferenceCommittee VALUES (10, 1);
INSERT INTO ConferenceCommittee VALUES (11, 1);
INSERT INTO ConferenceCommittee VALUES (12, 1);
INSERT INTO ConferenceCommittee VALUES (13, 1);
INSERT INTO ConferenceCommittee VALUES (14, 1);
INSERT INTO ConferenceCommittee VALUES (15, 1);
INSERT INTO ConferenceCommittee VALUES (16, 1);
INSERT INTO ConferenceCommittee VALUES (17, 1);
INSERT INTO ConferenceCommittee VALUES (18, 1);
INSERT INTO ConferenceCommittee VALUES (19, 1);
INSERT INTO ConferenceCommittee VALUES (20, 1);
INSERT INTO ConferenceCommittee VALUES (21, 4);
INSERT INTO ConferenceCommittee VALUES (22, 4);
INSERT INTO ConferenceCommittee VALUES (23, 4);

-- Import Data for Submissions
INSERT INTO Submissions VALUES (1, 'Student Perspectives on Optional Groups', 14, 'University of Alberta', 'paper', 'accepted');
INSERT INTO Submissions VALUES (2, 'Experience Report on the Use of Breakout Rooms', 13, 'Harvard University', 'paper', 'accepted');

INSERT INTO Submissions VALUES (3, 'Introducing and Evaluating Exam Wrappers in CS2', 1, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (4, 'Introducing and Evaluating Exam Wrappers in CS2', 2, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (5, 'Introducing and Evaluating Exam Wrappers in CS2', 3, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (6, 'Introducing and Evaluating Exam Wrappers in CS2', 4, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (7, 'Introducing and Evaluating Exam Wrappers in CS2', 5, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (8, 'Introducing and Evaluating Exam Wrappers in CS2', 6, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (9, 'Introducing and Evaluating Exam Wrappers in CS2', 21, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (10, 'Introducing and Evaluating Exam Wrappers in CS2', 22, 'University of Counter Strike', 'paper', 'rejected');
INSERT INTO Submissions VALUES (11, 'Introducing and Evaluating Exam Wrappers in CS2', 7, 'University of Counter Strike', 'paper', 'accepted');

INSERT INTO Submissions VALUES (12, 'sadsd', 1, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (13, 'sadsd', 2, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (14, 'sadsd', 3, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (15, 'sadsd', 4, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (16, 'sadsd', 5, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (17, 'sadsd', 6, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (18, 'sadsd', 7, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (19, 'sadsd', 8, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (20, 'sadsd', 9, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (21, 'sadsd', 10, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (22, 'sadsd', 11, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (23, 'sadsd', 12, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (24, 'sadsd', 13, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (25, 'sadsd', 14, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (26, 'sadsd', 15, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (27, 'sadsd', 16, 'asdas', 'paper', 'pending');

INSERT INTO Submissions VALUES (28, '1', 1, '1', 'paper', 'accepted');
INSERT INTO Submissions VALUES (29, '2', 2, '2', 'paper', 'accepted');
INSERT INTO Submissions VALUES (30, '3', 3, '3', 'paper', 'accepted');
INSERT INTO Submissions VALUES (31, '4', 4, '4', 'paper', 'accepted');
INSERT INTO Submissions VALUES (32, '5', 5, '5', 'paper', 'accepted');
INSERT INTO Submissions VALUES (33, '6', 6, '6', 'paper', 'accepted');
INSERT INTO Submissions VALUES (34, '7', 7, '7', 'paper', 'pending');


INSERT INTO Submissions VALUES (35, '8', 8, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (36, '9', 9, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (37, '10', 10, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (38, '11', 11, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (39, '12', 12, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (40, '13', 13, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (41, '14', 14, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (42, '15', 15, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (43, '16', 16, 'asdas', 'paper', 'pending');

INSERT INTO Submissions VALUES (44, '8a', 8, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (45, '9a', 9, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (46, '10a', 10, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (47, '11a', 11, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (48, '12a', 12, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (49, '13a', 13, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (50, '14a', 14, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (51, '15a', 15, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (52, '16a', 15, 'asdas', 'paper', 'rejected');

INSERT INTO Submissions VALUES (53, '8ab', 8, 'asdas', 'paper', 'accepted');--michelle,jennifer
INSERT INTO Submissions VALUES (54, '9ab', 9, 'asdas', 'paper', 'accepted'); --sole
INSERT INTO Submissions VALUES (55, '10ab', 10, 'asdas', 'paper', 'accepted');--sole
INSERT INTO Submissions VALUES (56, '11ab', 11, 'asdas', 'paper', 'accepted');--sole
INSERT INTO Submissions VALUES (57, '12ab', 12, 'asdas', 'paper', 'accepted'); --michelle,jennifer
INSERT INTO Submissions VALUES (58, '15ab', 15, 'asdas', 'paper', 'accepted');--michelle,jennifer
INSERT INTO Submissions VALUES (59, '16ab', 15, 'asdas', 'paper', 'accepted');--michelle, jennifer

INSERT INTO Submissions VALUES (60, '17', 17, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (61, '18', 18, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (62, '19', 19, 'asdas', 'paper', 'rejected');

INSERT INTO Submissions VALUES (63, '17a', 17, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (64, '18a', 18, 'asdas', 'paper', 'rejected');
INSERT INTO Submissions VALUES (65, '19a', 19, 'asdas', 'paper', 'rejected');

INSERT INTO Submissions VALUES (66, '17b', 17, 'asdas', 'poster', 'accepted'); -- sole
INSERT INTO Submissions VALUES (67, '18b', 18, 'asdas', 'paper', 'accepted');
INSERT INTO Submissions VALUES (68, '19b', 19, 'asdas', 'paper', 'accepted');

-- Import Data for Contributes
INSERT INTO Contributes VALUES (1, 4, 'f', 1);
INSERT INTO Contributes VALUES (1, 2, 'f', 2);
INSERT INTO Contributes VALUES (1, 1, 'f', 3);

INSERT INTO Contributes VALUES (2, 3, 'f', 1);
INSERT INTO Contributes VALUES (2, 5, 'f', 2);

INSERT INTO Contributes VALUES (3, 1, 'f', 1);
INSERT INTO Contributes VALUES (3, 6, 'f', 2);
INSERT INTO Contributes VALUES (3, 7, 'f', 3);
INSERT INTO Contributes VALUES (3, 8, 'f', 4);
INSERT INTO Contributes VALUES (4, 1, 'f', 1);
INSERT INTO Contributes VALUES (4, 6, 'f', 2);
INSERT INTO Contributes VALUES (4, 7, 'f', 3);
INSERT INTO Contributes VALUES (4, 8, 'f', 4);
INSERT INTO Contributes VALUES (5, 1, 'f', 1);
INSERT INTO Contributes VALUES (5, 6, 'f', 2);
INSERT INTO Contributes VALUES (5, 7, 'f', 3);
INSERT INTO Contributes VALUES (5, 8, 'f', 4);
INSERT INTO Contributes VALUES (6, 1, 'f', 1);
INSERT INTO Contributes VALUES (6, 6, 'f', 2);
INSERT INTO Contributes VALUES (6, 7, 'f', 3);
INSERT INTO Contributes VALUES (6, 8, 'f', 4);
INSERT INTO Contributes VALUES (7, 1, 'f', 1);
INSERT INTO Contributes VALUES (7, 6, 'f', 2);
INSERT INTO Contributes VALUES (7, 7, 'f', 3);
INSERT INTO Contributes VALUES (7, 8, 'f', 4);
INSERT INTO Contributes VALUES (8, 1, 'f', 1);
INSERT INTO Contributes VALUES (8, 6, 'f', 2);
INSERT INTO Contributes VALUES (8, 7, 'f', 3);
INSERT INTO Contributes VALUES (8, 8, 'f', 4);
INSERT INTO Contributes VALUES (9, 1, 'f', 1);
INSERT INTO Contributes VALUES (9, 6, 'f', 2);
INSERT INTO Contributes VALUES (9, 7, 'f', 3);
INSERT INTO Contributes VALUES (9, 8, 'f', 4);
INSERT INTO Contributes VALUES (10, 1, 'f', 1);
INSERT INTO Contributes VALUES (10, 6, 'f', 2);
INSERT INTO Contributes VALUES (10, 7, 'f', 3);
INSERT INTO Contributes VALUES (10, 8, 'f', 4);
INSERT INTO Contributes VALUES (11, 1, 'f', 1);
INSERT INTO Contributes VALUES (11, 6, 'f', 2);
INSERT INTO Contributes VALUES (11, 7, 'f', 3);
INSERT INTO Contributes VALUES (11, 8, 'f', 4);

INSERT INTO Contributes VALUES (12, 4, 't', 1);
INSERT INTO Contributes VALUES (13, 4, 't', 1);
INSERT INTO Contributes VALUES (14, 4, 't', 1);
INSERT INTO Contributes VALUES (15, 4, 't', 1);
INSERT INTO Contributes VALUES (16, 4, 't', 1);
INSERT INTO Contributes VALUES (17, 4, 't', 1);
INSERT INTO Contributes VALUES (18, 4, 't', 1);
INSERT INTO Contributes VALUES (19, 4, 't', 1);
INSERT INTO Contributes VALUES (20, 4, 't', 1);
INSERT INTO Contributes VALUES (21, 4, 't', 1);
INSERT INTO Contributes VALUES (22, 4, 't', 1);
INSERT INTO Contributes VALUES (23, 4, 't', 1);
INSERT INTO Contributes VALUES (24, 4, 't', 1);
INSERT INTO Contributes VALUES (25, 4, 't', 1);
INSERT INTO Contributes VALUES (26, 4, 't', 1);
INSERT INTO Contributes VALUES (27, 4, 't', 1);
INSERT INTO Contributes VALUES (28, 4, 't', 1);
INSERT INTO Contributes VALUES (29, 4, 't', 1);
INSERT INTO Contributes VALUES (30, 4, 't', 1);
INSERT INTO Contributes VALUES (31, 4, 't', 1);
INSERT INTO Contributes VALUES (32, 4, 't', 1);
INSERT INTO Contributes VALUES (33, 4, 't', 1);
INSERT INTO Contributes VALUES (34, 4, 't', 1);
INSERT INTO Contributes VALUES (35, 4, 't', 1);
INSERT INTO Contributes VALUES (36, 4, 't', 1);
INSERT INTO Contributes VALUES (37, 4, 't', 1);
INSERT INTO Contributes VALUES (38, 4, 't', 1);
INSERT INTO Contributes VALUES (39, 4, 't', 1);
INSERT INTO Contributes VALUES (40, 4, 't', 1);
INSERT INTO Contributes VALUES (41, 4, 't', 1);
INSERT INTO Contributes VALUES (42, 4, 't', 1);
INSERT INTO Contributes VALUES (43, 4, 't', 1);
INSERT INTO Contributes VALUES (44, 4, 't', 1);
INSERT INTO Contributes VALUES (45, 4, 't', 1);
INSERT INTO Contributes VALUES (46, 4, 't', 1);
INSERT INTO Contributes VALUES (47, 4, 't', 1);
INSERT INTO Contributes VALUES (48, 4, 't', 1);
INSERT INTO Contributes VALUES (49, 4, 't', 1);
INSERT INTO Contributes VALUES (50, 4, 't', 1);
INSERT INTO Contributes VALUES (51, 4, 't', 1);
INSERT INTO Contributes VALUES (52, 4, 't', 1);

INSERT INTO Contributes VALUES (53, 1, 'f', 1);
INSERT INTO Contributes VALUES (53, 2, 'f', 2);

INSERT INTO Contributes VALUES (54, 3, 't', 1);
INSERT INTO Contributes VALUES (55, 3, 't', 1);
INSERT INTO Contributes VALUES (56, 3, 't', 1);

INSERT INTO Contributes VALUES (57, 1, 'f', 1);
INSERT INTO Contributes VALUES (57, 2, 'f', 2);


INSERT INTO Contributes VALUES (58, 1, 'f', 1);
INSERT INTO Contributes VALUES (58, 2, 'f', 2);


INSERT INTO Contributes VALUES (59, 1, 'f', 1);
INSERT INTO Contributes VALUES (59, 2, 'f', 2);

INSERT INTO Contributes VALUES (60, 4, 't', 1);
INSERT INTO Contributes VALUES (61, 4, 't', 1);
INSERT INTO Contributes VALUES (62, 4, 't', 1);
INSERT INTO Contributes VALUES (63, 4, 't', 1);
INSERT INTO Contributes VALUES (64, 4, 't', 1);
INSERT INTO Contributes VALUES (65, 4, 't', 1);
INSERT INTO Contributes VALUES (66, 3, 't', 1);
INSERT INTO Contributes VALUES (67, 4, 't', 1);
INSERT INTO Contributes VALUES (68, 4, 't', 1);

-- Import Data for Reviews
INSERT INTO Reviews VALUES (1, 7, 1, 'accepted', '', '');
INSERT INTO Reviews VALUES (2, 1, 1, 'accepted', '', '');
INSERT INTO Reviews VALUES (3, 1, 1, 'accepted', '', '');
INSERT INTO Reviews VALUES (4, 2, 2, 'accepted', '', '');
INSERT INTO Reviews VALUES (5, 8, 2, 'accepted', '', '');
INSERT INTO Reviews VALUES (6, 8, 2, 'accepted', '', '');
INSERT INTO Reviews VALUES (7, 4, 3, 'rejected', '', '');
INSERT INTO Reviews VALUES (8, 6, 3, 'rejected', '', '');
INSERT INTO Reviews VALUES (9, 2, 3, 'rejected', '', '');
INSERT INTO Reviews VALUES (10, 5, 4, 'rejected', '', '');
INSERT INTO Reviews VALUES (11, 5, 4, 'rejected', '', '');
INSERT INTO Reviews VALUES (12, 8, 4, 'rejected', '', '');
INSERT INTO Reviews VALUES (13, 7, 5, 'rejected', '', '');
INSERT INTO Reviews VALUES (14, 3, 5, 'rejected', '', '');
INSERT INTO Reviews VALUES (15, 7, 5, 'rejected', '', '');
INSERT INTO Reviews VALUES (16, 7, 6, 'rejected', '', '');
INSERT INTO Reviews VALUES (17, 1, 6, 'rejected', '', '');
INSERT INTO Reviews VALUES (18, 3, 6, 'rejected', '', '');
INSERT INTO Reviews VALUES (19, 2, 7, 'rejected', '', '');
INSERT INTO Reviews VALUES (20, 5, 7, 'rejected', '', '');
INSERT INTO Reviews VALUES (21, 5, 7, 'rejected', '', '');
INSERT INTO Reviews VALUES (22, 6, 8, 'rejected', '', '');
INSERT INTO Reviews VALUES (23, 2, 8, 'rejected', '', '');
INSERT INTO Reviews VALUES (24, 4, 8, 'rejected', '', '');
INSERT INTO Reviews VALUES (25, 6, 9, 'rejected', '', '');
INSERT INTO Reviews VALUES (26, 7, 9, 'rejected', '', '');
INSERT INTO Reviews VALUES (27, 8, 9, 'rejected', '', '');
INSERT INTO Reviews VALUES (28, 3, 10, 'rejected', '', '');
INSERT INTO Reviews VALUES (29, 8, 10, 'rejected', '', '');
INSERT INTO Reviews VALUES (30, 3, 10, 'rejected', '', '');
INSERT INTO Reviews VALUES (31, 7, 11, 'accepted', '', '');
INSERT INTO Reviews VALUES (32, 1, 11, 'accepted', '', '');
INSERT INTO Reviews VALUES (33, 3, 11, 'accepted', '', '');
INSERT INTO Reviews VALUES (34, 8, 12, 'rejected', '', '');
INSERT INTO Reviews VALUES (35, 6, 12, 'rejected', '', '');
INSERT INTO Reviews VALUES (36, 5, 12, 'rejected', '', '');
INSERT INTO Reviews VALUES (37, 2, 13, 'rejected', '', '');
INSERT INTO Reviews VALUES (38, 4, 13, 'rejected', '', '');
INSERT INTO Reviews VALUES (39, 3, 13, 'rejected', '', '');
INSERT INTO Reviews VALUES (40, 2, 14, 'rejected', '', '');
INSERT INTO Reviews VALUES (41, 4, 14, 'rejected', '', '');
INSERT INTO Reviews VALUES (42, 3, 14, 'rejected', '', '');
INSERT INTO Reviews VALUES (43, 1, 15, 'rejected', '', '');
INSERT INTO Reviews VALUES (44, 7, 15, 'rejected', '', '');
INSERT INTO Reviews VALUES (45, 8, 15, 'rejected', '', '');
INSERT INTO Reviews VALUES (46, 7, 16, 'rejected', '', '');
INSERT INTO Reviews VALUES (47, 2, 16, 'rejected', '', '');
INSERT INTO Reviews VALUES (48, 2, 16, 'rejected', '', '');
INSERT INTO Reviews VALUES (49, 4, 17, 'rejected', '', '');
INSERT INTO Reviews VALUES (50, 6, 17, 'rejected', '', '');
INSERT INTO Reviews VALUES (51, 5, 17, 'rejected', '', '');
INSERT INTO Reviews VALUES (52, 6, 18, 'rejected', '', '');
INSERT INTO Reviews VALUES (53, 6, 18, 'rejected', '', '');
INSERT INTO Reviews VALUES (54, 1, 18, 'rejected', '', '');
INSERT INTO Reviews VALUES (55, 1, 19, 'rejected', '', '');
INSERT INTO Reviews VALUES (56, 7, 19, 'rejected', '', '');
INSERT INTO Reviews VALUES (57, 6, 19, 'rejected', '', '');
INSERT INTO Reviews VALUES (58, 6, 20, 'rejected', '', '');
INSERT INTO Reviews VALUES (59, 7, 20, 'rejected', '', '');
INSERT INTO Reviews VALUES (60, 1, 20, 'rejected', '', '');
INSERT INTO Reviews VALUES (61, 5, 21, 'rejected', '', '');
INSERT INTO Reviews VALUES (62, 6, 21, 'rejected', '', '');
INSERT INTO Reviews VALUES (63, 1, 21, 'rejected', '', '');
INSERT INTO Reviews VALUES (64, 6, 22, 'rejected', '', '');
INSERT INTO Reviews VALUES (65, 7, 22, 'rejected', '', '');
INSERT INTO Reviews VALUES (66, 7, 22, 'rejected', '', '');
INSERT INTO Reviews VALUES (67, 1, 23, 'rejected', '', '');
INSERT INTO Reviews VALUES (68, 2, 23, 'rejected', '', '');
INSERT INTO Reviews VALUES (69, 7, 23, 'rejected', '', '');
INSERT INTO Reviews VALUES (70, 3, 24, 'rejected', '', '');
INSERT INTO Reviews VALUES (71, 2, 24, 'rejected', '', '');
INSERT INTO Reviews VALUES (72, 3, 24, 'rejected', '', '');
INSERT INTO Reviews VALUES (73, 8, 25, 'rejected', '', '');
INSERT INTO Reviews VALUES (74, 6, 25, 'rejected', '', '');
INSERT INTO Reviews VALUES (75, 6, 25, 'rejected', '', '');
INSERT INTO Reviews VALUES (76, 5, 26, 'rejected', '', '');
INSERT INTO Reviews VALUES (77, 6, 26, 'rejected', '', '');
INSERT INTO Reviews VALUES (78, 8, 26, 'rejected', '', '');
INSERT INTO Reviews VALUES (79, 3, 27, 'rejected', '', '');
INSERT INTO Reviews VALUES (80, 4, 27, 'rejected', '', '');
INSERT INTO Reviews VALUES (81, 1, 27, 'rejected', '', '');
INSERT INTO Reviews VALUES (82, 5, 28, 'accepted', '', '');
INSERT INTO Reviews VALUES (83, 2, 28, 'accepted', '', '');
INSERT INTO Reviews VALUES (84, 8, 28, 'accepted', '', '');
INSERT INTO Reviews VALUES (85, 2, 29, 'accepted', '', '');
INSERT INTO Reviews VALUES (86, 7, 29, 'accepted', '', '');
INSERT INTO Reviews VALUES (87, 1, 29, 'accepted', '', '');
INSERT INTO Reviews VALUES (88, 4, 30, 'accepted', '', '');
INSERT INTO Reviews VALUES (89, 1, 30, 'accepted', '', '');
INSERT INTO Reviews VALUES (90, 2, 30, 'accepted', '', '');
INSERT INTO Reviews VALUES (91, 4, 31, 'accepted', '', '');
INSERT INTO Reviews VALUES (92, 3, 31, 'accepted', '', '');
INSERT INTO Reviews VALUES (93, 6, 31, 'accepted', '', '');
INSERT INTO Reviews VALUES (94, 5, 32, 'accepted', '', '');
INSERT INTO Reviews VALUES (95, 4, 32, 'accepted', '', '');
INSERT INTO Reviews VALUES (96, 6, 32, 'accepted', '', '');
INSERT INTO Reviews VALUES (97, 7, 33, 'accepted', '', '');
INSERT INTO Reviews VALUES (98, 3, 33, 'accepted', '', '');
INSERT INTO Reviews VALUES (99, 2, 33, 'accepted', '', '');
INSERT INTO Reviews VALUES (100, 2, 34, 'rejected', '', '');
INSERT INTO Reviews VALUES (101, 8, 34, 'rejected', '', '');
INSERT INTO Reviews VALUES (102, 5, 34, 'rejected', '', '');
INSERT INTO Reviews VALUES (103, 6, 35, 'rejected', '', '');
INSERT INTO Reviews VALUES (104, 4, 35, 'rejected', '', '');
INSERT INTO Reviews VALUES (105, 7, 35, 'rejected', '', '');
INSERT INTO Reviews VALUES (106, 8, 36, 'rejected', '', '');
INSERT INTO Reviews VALUES (107, 2, 36, 'rejected', '', '');
INSERT INTO Reviews VALUES (108, 6, 36, 'rejected', '', '');
INSERT INTO Reviews VALUES (109, 1, 37, 'rejected', '', '');
INSERT INTO Reviews VALUES (110, 4, 37, 'rejected', '', '');
INSERT INTO Reviews VALUES (111, 2, 37, 'rejected', '', '');
INSERT INTO Reviews VALUES (112, 5, 38, 'rejected', '', '');
INSERT INTO Reviews VALUES (113, 4, 38, 'rejected', '', '');
INSERT INTO Reviews VALUES (114, 3, 38, 'rejected', '', '');
INSERT INTO Reviews VALUES (115, 1, 39, 'rejected', '', '');
INSERT INTO Reviews VALUES (116, 1, 39, 'rejected', '', '');
INSERT INTO Reviews VALUES (117, 7, 39, 'rejected', '', '');
INSERT INTO Reviews VALUES (118, 4, 40, 'rejected', '', '');
INSERT INTO Reviews VALUES (119, 5, 40, 'rejected', '', '');
INSERT INTO Reviews VALUES (120, 3, 40, 'rejected', '', '');
INSERT INTO Reviews VALUES (121, 6, 41, 'rejected', '', '');
INSERT INTO Reviews VALUES (122, 2, 41, 'rejected', '', '');
INSERT INTO Reviews VALUES (123, 8, 41, 'rejected', '', '');
INSERT INTO Reviews VALUES (124, 5, 42, 'rejected', '', '');
INSERT INTO Reviews VALUES (125, 5, 42, 'rejected', '', '');
INSERT INTO Reviews VALUES (126, 6, 42, 'rejected', '', '');
INSERT INTO Reviews VALUES (127, 1, 43, 'rejected', '', '');
INSERT INTO Reviews VALUES (128, 4, 43, 'rejected', '', '');
INSERT INTO Reviews VALUES (129, 3, 43, 'rejected', '', '');
INSERT INTO Reviews VALUES (130, 8, 44, 'rejected', '', '');
INSERT INTO Reviews VALUES (131, 1, 44, 'rejected', '', '');
INSERT INTO Reviews VALUES (132, 5, 44, 'rejected', '', '');
INSERT INTO Reviews VALUES (133, 2, 45, 'rejected', '', '');
INSERT INTO Reviews VALUES (134, 7, 45, 'rejected', '', '');
INSERT INTO Reviews VALUES (135, 6, 45, 'rejected', '', '');
INSERT INTO Reviews VALUES (136, 8, 46, 'rejected', '', '');
INSERT INTO Reviews VALUES (137, 4, 46, 'rejected', '', '');
INSERT INTO Reviews VALUES (138, 1, 46, 'rejected', '', '');
INSERT INTO Reviews VALUES (139, 4, 47, 'rejected', '', '');
INSERT INTO Reviews VALUES (140, 5, 47, 'rejected', '', '');
INSERT INTO Reviews VALUES (141, 5, 47, 'rejected', '', '');
INSERT INTO Reviews VALUES (142, 7, 48, 'rejected', '', '');
INSERT INTO Reviews VALUES (143, 1, 48, 'rejected', '', '');
INSERT INTO Reviews VALUES (144, 5, 48, 'rejected', '', '');
INSERT INTO Reviews VALUES (145, 8, 49, 'rejected', '', '');
INSERT INTO Reviews VALUES (146, 6, 49, 'rejected', '', '');
INSERT INTO Reviews VALUES (147, 3, 49, 'rejected', '', '');
INSERT INTO Reviews VALUES (148, 6, 50, 'rejected', '', '');
INSERT INTO Reviews VALUES (149, 5, 50, 'rejected', '', '');
INSERT INTO Reviews VALUES (150, 6, 50, 'rejected', '', '');
INSERT INTO Reviews VALUES (151, 3, 51, 'rejected', '', '');
INSERT INTO Reviews VALUES (152, 8, 51, 'rejected', '', '');
INSERT INTO Reviews VALUES (153, 2, 51, 'rejected', '', '');
INSERT INTO Reviews VALUES (154, 7, 52, 'rejected', '', '');
INSERT INTO Reviews VALUES (155, 7, 52, 'rejected', '', '');
INSERT INTO Reviews VALUES (156, 7, 52, 'rejected', '', '');
INSERT INTO Reviews VALUES (157, 7, 53, 'accepted', '', '');
INSERT INTO Reviews VALUES (158, 6, 53, 'accepted', '', '');
INSERT INTO Reviews VALUES (159, 8, 53, 'accepted', '', '');
INSERT INTO Reviews VALUES (160, 7, 54, 'accepted', '', '');
INSERT INTO Reviews VALUES (161, 2, 54, 'accepted', '', '');
INSERT INTO Reviews VALUES (162, 3, 54, 'accepted', '', '');
INSERT INTO Reviews VALUES (163, 1, 55, 'accepted', '', '');
INSERT INTO Reviews VALUES (164, 5, 55, 'accepted', '', '');
INSERT INTO Reviews VALUES (165, 8, 55, 'accepted', '', '');
INSERT INTO Reviews VALUES (166, 6, 56, 'accepted', '', '');
INSERT INTO Reviews VALUES (167, 6, 56, 'accepted', '', '');
INSERT INTO Reviews VALUES (168, 6, 56, 'accepted', '', '');
INSERT INTO Reviews VALUES (169, 7, 57, 'accepted', '', '');
INSERT INTO Reviews VALUES (170, 3, 57, 'accepted', '', '');
INSERT INTO Reviews VALUES (171, 4, 57, 'accepted', '', '');
INSERT INTO Reviews VALUES (172, 8, 58, 'accepted', '', '');
INSERT INTO Reviews VALUES (173, 4, 58, 'accepted', '', '');
INSERT INTO Reviews VALUES (174, 8, 58, 'accepted', '', '');
INSERT INTO Reviews VALUES (175, 1, 59, 'accepted', '', '');
INSERT INTO Reviews VALUES (176, 7, 59, 'accepted', '', '');
INSERT INTO Reviews VALUES (177, 3, 59, 'accepted', '', '');
INSERT INTO Reviews VALUES (178, 4, 60, 'rejected', '', '');
INSERT INTO Reviews VALUES (179, 2, 60, 'rejected', '', '');
INSERT INTO Reviews VALUES (180, 1, 60, 'rejected', '', '');
INSERT INTO Reviews VALUES (181, 5, 61, 'rejected', '', '');
INSERT INTO Reviews VALUES (182, 4, 61, 'rejected', '', '');
INSERT INTO Reviews VALUES (183, 6, 61, 'rejected', '', '');
INSERT INTO Reviews VALUES (184, 1, 62, 'rejected', '', '');
INSERT INTO Reviews VALUES (185, 2, 62, 'rejected', '', '');
INSERT INTO Reviews VALUES (186, 2, 62, 'rejected', '', '');
INSERT INTO Reviews VALUES (187, 4, 63, 'rejected', '', '');
INSERT INTO Reviews VALUES (188, 6, 63, 'rejected', '', '');
INSERT INTO Reviews VALUES (189, 1, 63, 'rejected', '', '');
INSERT INTO Reviews VALUES (190, 5, 64, 'rejected', '', '');
INSERT INTO Reviews VALUES (191, 6, 64, 'rejected', '', '');
INSERT INTO Reviews VALUES (192, 2, 64, 'rejected', '', '');
INSERT INTO Reviews VALUES (193, 7, 65, 'rejected', '', '');
INSERT INTO Reviews VALUES (194, 4, 65, 'rejected', '', '');
INSERT INTO Reviews VALUES (195, 7, 65, 'rejected', '', '');
INSERT INTO Reviews VALUES (196, 5, 66, 'accepted', '', '');
INSERT INTO Reviews VALUES (197, 3, 66, 'accepted', '', '');
INSERT INTO Reviews VALUES (198, 5, 66, 'accepted', '', '');
INSERT INTO Reviews VALUES (199, 6, 67, 'accepted', '', '');
INSERT INTO Reviews VALUES (200, 2, 67, 'accepted', '', '');
INSERT INTO Reviews VALUES (201, 1, 67, 'accepted', '', '');
INSERT INTO Reviews VALUES (202, 2, 68, 'accepted', '', '');
INSERT INTO Reviews VALUES (203, 3, 68, 'accepted', '', '');
INSERT INTO Reviews VALUES (204, 5, 68, 'accepted', '', '');

-- Import Data for Sessions
INSERT INTO Sessions VALUES (1, 1, '2010-10-19 10:00:00', '2010-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (1, 2, '2010-10-19 12:00:00', '2010-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (2, 3, '2011-10-19 10:00:00', '2011-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (2, 4, '2011-10-19 12:00:00', '2011-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (3, 5, '2012-10-19 10:00:00', '2012-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (3, 6, '2012-10-19 12:00:00', '2012-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (4, 7, '2013-10-19 10:00:00', '2013-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (4, 8, '2013-10-19 12:00:00', '2013-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (5, 9, '2014-10-19 10:00:00', '2014-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (5, 10, '2014-10-19 12:00:00', '2014-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (6, 11, '2015-10-19 10:00:00', '2015-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (6, 12, '2015-10-19 12:00:00', '2015-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (7, 13, '2016-10-19 10:00:00', '2016-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (7, 14, '2016-10-19 12:00:00', '2016-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (8, 15, '2017-10-19 10:00:00', '2017-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (8, 16, '2017-10-19 12:00:00', '2017-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (9, 17, '2018-10-19 10:00:00', '2018-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (9, 18, '2018-10-19 12:00:00', '2018-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (10, 19, '2019-10-19 10:00:00', '2019-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (10, 20, '2019-10-19 12:00:00', '2019-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (11, 21, '2020-10-19 10:00:00', '2020-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (11, 22, '2020-10-19 12:00:00', '2020-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (12, 23, '2021-10-19 10:00:00', '2021-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (12, 24, '2021-10-19 12:00:00', '2021-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (13, 25, '2022-10-19 10:00:00', '2022-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (13, 26, '2022-10-19 12:00:00', '2022-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (14, 27, '2023-10-19 10:00:00', '2023-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (14, 28, '2023-10-19 12:00:00', '2023-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (15, 29, '2024-10-19 10:00:00', '2024-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (15, 30, '2024-10-19 12:00:00', '2024-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (16, 31, '2025-10-19 10:00:00', '2025-10-19 11:00:00', 'paper');
INSERT INTO Sessions VALUES (16, 32, '2025-10-19 12:00:00', '2025-10-19 13:00:00', 'poster');

INSERT INTO Sessions VALUES (17, 33, '2019-10-21 10:00:00', '2019-10-21 11:00:00', 'paper');
INSERT INTO Sessions VALUES (17, 34, '2019-10-21 12:00:00', '2019-10-21 13:00:00', 'poster');

INSERT INTO Sessions VALUES (18, 35, '2021-10-21 12:00:00', '2021-10-21 13:00:00', 'paper');
INSERT INTO Sessions VALUES (18, 36, '2021-10-21 12:00:00', '2021-10-21 13:00:00', 'poster');

INSERT INTO Sessions VALUES (19, 37, '2023-10-21 12:00:00', '2023-10-21 13:00:00', 'paper');
INSERT INTO Sessions VALUES (19, 38, '2023-10-21 12:00:00', '2023-10-21 13:00:00', 'poster');

INSERT INTO Sessions VALUES (20, 39, '2025-10-21 12:00:00', '2025-10-21 13:00:00', 'paper');
INSERT INTO Sessions VALUES (20, 40, '2025-10-21 12:00:00', '2025-10-21 13:00:00', 'poster');

-- Import Data for Attends
INSERT INTO Attends VALUES (1, 1, 'other');
INSERT INTO Attends VALUES (1, 2, 'other');
INSERT INTO Attends VALUES (1, 3, 'other');
INSERT INTO Attends VALUES (1, 4, 'other');
INSERT INTO Attends VALUES (1, 5, 'other');
INSERT INTO Attends VALUES (1, 6, 'other');
INSERT INTO Attends VALUES (1, 7, 'other');
INSERT INTO Attends VALUES (1, 8, 'other');
INSERT INTO Attends VALUES (1, 9, 'other');
INSERT INTO Attends VALUES (1, 10, 'other');
INSERT INTO Attends VALUES (1, 11, 'other');
INSERT INTO Attends VALUES (1, 12, 'other');
INSERT INTO Attends VALUES (1, 13, 'other');
INSERT INTO Attends VALUES (1, 14, 'other');
INSERT INTO Attends VALUES (1, 15, 'other');
INSERT INTO Attends VALUES (1, 16, 'other');
INSERT INTO Attends VALUES (1, 17, 'other');
INSERT INTO Attends VALUES (1, 18, 'other');
INSERT INTO Attends VALUES (1, 19, 'other');
INSERT INTO Attends VALUES (1, 20, 'other');
INSERT INTO Attends VALUES (1, 21, 'other');
INSERT INTO Attends VALUES (1, 22, 'other');

INSERT INTO Attends VALUES (2, 6, 'other');
INSERT INTO Attends VALUES (2, 7, 'other');
INSERT INTO Attends VALUES (2, 8, 'other');
INSERT INTO Attends VALUES (2, 9, 'other');
INSERT INTO Attends VALUES (2, 10, 'other');
INSERT INTO Attends VALUES (2, 11, 'other');
INSERT INTO Attends VALUES (2, 12, 'other');
INSERT INTO Attends VALUES (2, 13, 'other');
INSERT INTO Attends VALUES (2, 15, 'other');
INSERT INTO Attends VALUES (2, 16, 'other');

INSERT INTO Attends VALUES (3, 17, 'other');
INSERT INTO Attends VALUES (3, 9, 'other');
INSERT INTO Attends VALUES (3, 10, 'other');
INSERT INTO Attends VALUES (3, 11, 'other');

INSERT INTO Attends VALUES (4, 1, 'other');
INSERT INTO Attends VALUES (4, 2, 'other');
INSERT INTO Attends VALUES (4, 3, 'other');
INSERT INTO Attends VALUES (4, 4, 'other');
INSERT INTO Attends VALUES (4, 5, 'other');
INSERT INTO Attends VALUES (4, 6, 'other');
INSERT INTO Attends VALUES (4, 7, 'other');
INSERT INTO Attends VALUES (4, 8, 'other');
INSERT INTO Attends VALUES (4, 9, 'other');
INSERT INTO Attends VALUES (4, 10, 'other');
INSERT INTO Attends VALUES (4, 11, 'other');
INSERT INTO Attends VALUES (4, 12, 'other');
INSERT INTO Attends VALUES (4, 13, 'other');
INSERT INTO Attends VALUES (4, 14, 'other');
INSERT INTO Attends VALUES (4, 15, 'other');
INSERT INTO Attends VALUES (4, 16, 'other');
INSERT INTO Attends VALUES (4, 17, 'other');
INSERT INTO Attends VALUES (4, 18, 'other');
INSERT INTO Attends VALUES (4, 19, 'other');
INSERT INTO Attends VALUES (4, 20, 'other');
INSERT INTO Attends VALUES (4, 21, 'other');
INSERT INTO Attends VALUES (4, 22, 'other');
INSERT INTO Attends VALUES (4, 23, 'other');

INSERT INTO Attends VALUES (5, 1, 'other');
INSERT INTO Attends VALUES (5, 2, 'other');
INSERT INTO Attends VALUES (5, 3, 'other');
INSERT INTO Attends VALUES (5, 4, 'other');
INSERT INTO Attends VALUES (5, 5, 'other');
INSERT INTO Attends VALUES (5, 6, 'other');
INSERT INTO Attends VALUES (5, 7, 'other');
INSERT INTO Attends VALUES (5, 8, 'other');
INSERT INTO Attends VALUES (5, 9, 'other');
INSERT INTO Attends VALUES (5, 10, 'other');
INSERT INTO Attends VALUES (5, 11, 'other');
INSERT INTO Attends VALUES (5, 12, 'other');
INSERT INTO Attends VALUES (5, 13, 'other');
INSERT INTO Attends VALUES (5, 14, 'other');
INSERT INTO Attends VALUES (5, 15, 'other');
INSERT INTO Attends VALUES (5, 16, 'other');
INSERT INTO Attends VALUES (5, 17, 'other');
INSERT INTO Attends VALUES (5, 18, 'other');
INSERT INTO Attends VALUES (5, 19, 'other');
INSERT INTO Attends VALUES (5, 20, 'other');
INSERT INTO Attends VALUES (5, 21, 'other');
INSERT INTO Attends VALUES (5, 22, 'other');
INSERT INTO Attends VALUES (5, 23, 'other');

INSERT INTO Attends VALUES (6, 1, 'other');
INSERT INTO Attends VALUES (6, 2, 'other');
INSERT INTO Attends VALUES (6, 3, 'other');
INSERT INTO Attends VALUES (6, 4, 'other');
INSERT INTO Attends VALUES (6, 5, 'other');
INSERT INTO Attends VALUES (6, 6, 'other');
INSERT INTO Attends VALUES (6, 7, 'other');
INSERT INTO Attends VALUES (6, 8, 'other');
INSERT INTO Attends VALUES (6, 9, 'other');
INSERT INTO Attends VALUES (6, 10, 'other');
INSERT INTO Attends VALUES (6, 11, 'other');
INSERT INTO Attends VALUES (6, 12, 'other');
INSERT INTO Attends VALUES (6, 13, 'other');
INSERT INTO Attends VALUES (6, 14, 'other');
INSERT INTO Attends VALUES (6, 15, 'other');
INSERT INTO Attends VALUES (6, 16, 'other');
INSERT INTO Attends VALUES (6, 17, 'other');
INSERT INTO Attends VALUES (6, 18, 'other');
INSERT INTO Attends VALUES (6, 19, 'other');
INSERT INTO Attends VALUES (6, 20, 'other');
INSERT INTO Attends VALUES (6, 21, 'other');
INSERT INTO Attends VALUES (6, 22, 'other');
INSERT INTO Attends VALUES (6, 23, 'other');

INSERT INTO Attends VALUES (7, 1, 'other');
INSERT INTO Attends VALUES (7, 2, 'other');
INSERT INTO Attends VALUES (7, 3, 'other');
INSERT INTO Attends VALUES (7, 4, 'other');
INSERT INTO Attends VALUES (7, 5, 'other');
INSERT INTO Attends VALUES (7, 6, 'other');
INSERT INTO Attends VALUES (7, 7, 'other');
INSERT INTO Attends VALUES (7, 8, 'other');
INSERT INTO Attends VALUES (7, 9, 'other');
INSERT INTO Attends VALUES (7, 10, 'other');
INSERT INTO Attends VALUES (7, 11, 'other');
INSERT INTO Attends VALUES (7, 12, 'other');
INSERT INTO Attends VALUES (7, 13, 'other');
INSERT INTO Attends VALUES (7, 14, 'other');
INSERT INTO Attends VALUES (7, 15, 'other');
INSERT INTO Attends VALUES (7, 16, 'other');
INSERT INTO Attends VALUES (7, 17, 'other');
INSERT INTO Attends VALUES (7, 18, 'other');
INSERT INTO Attends VALUES (7, 19, 'other');
INSERT INTO Attends VALUES (7, 20, 'other');
INSERT INTO Attends VALUES (7, 21, 'other');
INSERT INTO Attends VALUES (7, 22, 'other');
INSERT INTO Attends VALUES (7, 23, 'other');

INSERT INTO Attends VALUES (8, 1, 'other');
INSERT INTO Attends VALUES (8, 2, 'other');
INSERT INTO Attends VALUES (8, 3, 'other');
INSERT INTO Attends VALUES (8, 4, 'other');
INSERT INTO Attends VALUES (8, 5, 'other');
INSERT INTO Attends VALUES (8, 6, 'other');
INSERT INTO Attends VALUES (8, 7, 'other');
INSERT INTO Attends VALUES (8, 8, 'other');
INSERT INTO Attends VALUES (8, 9, 'other');
INSERT INTO Attends VALUES (8, 10, 'other');
INSERT INTO Attends VALUES (8, 11, 'other');
INSERT INTO Attends VALUES (8, 12, 'other');
INSERT INTO Attends VALUES (8, 13, 'other');
INSERT INTO Attends VALUES (8, 14, 'other');
INSERT INTO Attends VALUES (8, 15, 'other');
INSERT INTO Attends VALUES (8, 16, 'other');
INSERT INTO Attends VALUES (8, 17, 'other');
INSERT INTO Attends VALUES (8, 18, 'other');
INSERT INTO Attends VALUES (8, 19, 'other');
INSERT INTO Attends VALUES (8, 20, 'other');
INSERT INTO Attends VALUES (8, 21, 'other');
INSERT INTO Attends VALUES (8, 22, 'other');
INSERT INTO Attends VALUES (8, 23, 'other');

-- Import Data for SessionChair
INSERT INTO SessionChair VALUES (1, 4);
INSERT INTO SessionChair VALUES (2, 4);
INSERT INTO SessionChair VALUES (3, 4);
INSERT INTO SessionChair VALUES (4, 4);
INSERT INTO SessionChair VALUES (5, 4);
INSERT INTO SessionChair VALUES (6, 4);
INSERT INTO SessionChair VALUES (7, 4);
INSERT INTO SessionChair VALUES (8, 4);
INSERT INTO SessionChair VALUES (9, 4);
INSERT INTO SessionChair VALUES (10, 4);
INSERT INTO SessionChair VALUES (11, 4);
INSERT INTO SessionChair VALUES (12, 4);
INSERT INTO SessionChair VALUES (13, 4);
INSERT INTO SessionChair VALUES (14, 4);
INSERT INTO SessionChair VALUES (15, 4);
INSERT INTO SessionChair VALUES (16, 4);
INSERT INTO SessionChair VALUES (17, 4);
INSERT INTO SessionChair VALUES (18, 4);
INSERT INTO SessionChair VALUES (19, 4);
INSERT INTO SessionChair VALUES (20, 4);
INSERT INTO SessionChair VALUES (21, 4);
INSERT INTO SessionChair VALUES (22, 4);
INSERT INTO SessionChair VALUES (23, 4);
INSERT INTO SessionChair VALUES (24, 4);
INSERT INTO SessionChair VALUES (25, 4);
INSERT INTO SessionChair VALUES (26, 4);
INSERT INTO SessionChair VALUES (27, 4);
INSERT INTO SessionChair VALUES (28, 4);
INSERT INTO SessionChair VALUES (29, 4);
INSERT INTO SessionChair VALUES (30, 4);
INSERT INTO SessionChair VALUES (31, 4);
INSERT INTO SessionChair VALUES (32, 4);
INSERT INTO SessionChair VALUES (33, 4);
INSERT INTO SessionChair VALUES (34, 4);
INSERT INTO SessionChair VALUES (35, 4);
INSERT INTO SessionChair VALUES (36, 4);
INSERT INTO SessionChair VALUES (37, 4);
INSERT INTO SessionChair VALUES (38, 4);
INSERT INTO SessionChair VALUES (39, 4);
INSERT INTO SessionChair VALUES (40, 4);

-- Import Data for SessionPresentations
INSERT INTO SessionPresentations VALUES (1, 27);
INSERT INTO SessionPresentations VALUES (2, 25);
INSERT INTO SessionPresentations VALUES (11, 13); --paper
INSERT INTO SessionPresentations VALUES (28, 1);
INSERT INTO SessionPresentations VALUES (29, 3);
INSERT INTO SessionPresentations VALUES (30, 5);
INSERT INTO SessionPresentations VALUES (31, 7);
INSERT INTO SessionPresentations VALUES (32, 9);
INSERT INTO SessionPresentations VALUES (33, 11);
INSERT INTO SessionPresentations VALUES (53, 15);
INSERT INTO SessionPresentations VALUES (54, 17);
INSERT INTO SessionPresentations VALUES (55, 19);
INSERT INTO SessionPresentations VALUES (56, 21);
INSERT INTO SessionPresentations VALUES (57, 23);
INSERT INTO SessionPresentations VALUES (58, 29);
INSERT INTO SessionPresentations VALUES (59, 29);
INSERT INTO SessionPresentations VALUES (66, 34); --poster
INSERT INTO SessionPresentations VALUES (67, 35);
INSERT INTO SessionPresentations VALUES (68, 37);


-- Import Data for Workshops
INSERT INTO Workshops VALUES (1, 6);
INSERT INTO Workshops VALUES (2, 7);

-- Import Data for WorkshopFacilitator
INSERT INTO WorkshopFacilitator VALUES (1, 5);
INSERT INTO WorkshopFacilitator VALUES (2, 5);

-- Import Data for WorkshopAttendees
INSERT INTO WorkshopAttendees VALUES (1, 2);
INSERT INTO WorkshopAttendees VALUES (2, 2);
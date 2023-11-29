SET SEARCH_PATH TO recording;

-- Insert data into Studio Table
INSERT INTO 
    Studio (name, address, manager_id) 
VALUES 
    ('Pawnee Recording Studio', '123 Valley Spring Lane, Pawnee, Indiana', 1233),
    ('Pawnee Sound', '353 Western Ave, Pawnee, Indiana', 1233),
    ('Eagleton Recording Studio', '829 Division, Eagleton, Indiana', 1232);

-- Insert data into Person Table
-- Adding managers, engineers, and band members
INSERT INTO 
    Person (person_id, name, email, phone_number, is_engineer, certification)
VALUES 
    (1231, 'April Ludgate', 'april@email.com', '111-111-1111', false, ''),
    (1234, 'Tom Haverford', 'tom@email.com', '222-222-2222', false, ''),
    (1233, 'Donna Meagle', 'donna@email.com', '333-333-3333', false, ''),
    (1232, 'Leslie Knope', 'leslie@email.com', '123-123-4444', false, ''),

    (5678, 'Ben Wayatt', 'ben@email.com', '444-444-4444', true, 'ABCDEFGH-123I JKLMNOPQ-456R'),
    (9942, 'Ann Perkins', 'Ann@email.com', '5555-555-5555', true, 'SOUND-123-AUDIO'),
    (6521, 'Chris Treager', 'chris@email.com', '666-666-6666', true, ''),

    (6754, 'Andy Dwyer', 'andy@email.com', '777-777-7777', false, ''),
    (4523, 'Andrew Burlinson', 'andrew@email.com', '888-888-8888', false, ''),
    (2224, 'Micheal Chang', 'micheal@email.com', '999-999-9999', false, ''),
    (7832, 'James Pierson', 'james@email.com', '000-000-0000', false, ''),

    (1000, 'Duke Silver', 'duke@email.com', '010-010-1111', false, '');

INSERT INTO 
    MANAGES (manager_id, studio_id, start_time)
VALUES 
    (1233, 1, DATE('2018-12-02')),
    (1234, 1, DATE('2017-01-13')),
    (1231, 1, DATE('2008-03-21')),
    
    (1233, 2, DATE('2011-09-07')),

    (1232, 3, DATE('2020-09-05')),
    (1234, 3, DATE('2016-09-05')),
    (1232, 3, DATE('2010-09-05'));

-- Insert data into Band Table
INSERT INTO 
    Band (name)
VALUES 
    ('Mouse Rat');

-- Insert data into BandMember Table
INSERT INTO 
    BandMember (band_id, person_id)
VALUES
    (1, 6754), -- Assuming Mouse Rat's band_id is 1
    (1, 4523),
    (1, 2224),
    (1, 7832);
-- Other band members are inserted similarly...

-- Insert data into Session Table
-- Sessions for 'Mouse Rat' at 'Pawnee Recording Studio'
INSERT INTO
    Session (studio_id, engineer_1, engineer_2, engineer_3, session_start, session_end, session_fee) 
VALUES
    (1, 5678, 9942, null, '2023-01-08 10:00', '2023-01-08 15:00', 1500),
    (1, 5678, 9942, null, '2023-01-10 13:00', '2023-01-11 14:00', 1500),
    (1, 5678, 9942, null, '2023-01-12 18:00', '2023-01-13 10:00', 1500),

    (1, 5678, null, null, '2023-03-10 11:00', '2023-03-10 23:00', 2000),
    (1, 5678, null, null, '2023-03-11 13:00', '2023-03-12 15:00', 2000),

    (1, 6521, null, null, '2023-03-13 10:00', '2023-03-14 20:00', 1000),

    (3, 5678, null, null, '2023-09-25 11:00', '2023-09-26 23:00', 1000),
    (3, 5678, null, null, '2023-09-29 11:00', '2023-09-30 23:00', 1000);

INSERT INTO 
    Participation (session_id, person_id)
VALUES
    (1, 6754),
    (1, 4523),
    (1, 2224),
    (1, 7832),
    (1, 1000),
    (2, 6754),
    (2, 4523),
    (2, 2224),
    (2, 7832),
    (2, 1000),
    (3, 6754),
    (3, 4523),
    (3, 2224),
    (3, 7832),
    (3, 1000),

    (4, 6754),
    (4, 4523),
    (4, 2224),
    (4, 7832),
    (5, 6754),
    (5, 4523),
    (5, 2224),
    (5, 7832),

    (6, 1234),
    (6, 6754),

    (7, 6754),
    (8, 6754);

-- Insert data into RecordingSegment Table
-- Segments from the first session of 'Mouse Rat'
INSERT INTO
    RecordingSegment (session_id, length_seconds, format1)
VALUES
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'),
    (1, 60, 'WAV'), -- duke and mouse rat session 1

    (2, 60, 'WAV'), --11
    (2, 60, 'WAV'),
    (2, 60, 'WAV'),
    (2, 60, 'WAV'),
    (2, 60, 'WAV'), -- duke and mouse rat session 2 -- 15

    (3, 60, 'WAV'), --16
    (3, 60, 'WAV'),
    (3, 60, 'WAV'),
    (3, 60, 'WAV'), -- duke and mouse rat session 3 --19

    (4, 120, 'WAV'), --20
    (4, 120, 'WAV'), -- band mouse session 4 --21

    (6, 60, 'WAV'), --22
    (6, 60, 'WAV'),
    (6, 60, 'WAV'),
    (6, 60, 'WAV'),
    (6, 60, 'WAV'), -- andy drawyer session 6 --26

    (7, 180, 'WAV'), --27
    (7, 180, 'WAV'),
    (7, 180, 'WAV'),
    (7, 180, 'WAV'),
    (7, 180, 'WAV'),
    (7, 180, 'WAV'), -- may song, another awesome album --32
    (7, 180, 'WAV'), --33
    (7, 180, 'WAV'), --andy dwyer session 7 -- the pit, another awesome album --34
    (7, 180, 'WAV'), --35

    (8, 180, 'WAV'), -- remember, another awesome album --36
    (8, 180, 'WAV'), -- remember, another awesome album --37
    (8, 180, 'WAV'), -- the way you look tn, another awesome album --38
    (8, 180, 'WAV'), -- the way u look tn, another awesome album --39
    (8, 180, 'WAV'), -- another song, another awesome album --40
    (8, 180, 'WAV'); -- another song, another awesome album --41
-- Other segments are inserted similarly...

-- Insert data into Album Table
INSERT INTO 
    Album (album_id, name, release_date)
VALUES 
    (1, 'The Awesome Album', DATE('2023-05-25')),
    (2, 'Another Awesome Album', DATE('2023-10-29'));

-- Insert data into Track Table
-- Tracks for 'The Awesome Album'
INSERT INTO 
    Track (name) 
VALUES 
    ('5,000 Candles in the Wind'), -- the awesome album
    ('Catch Your Dream'), -- the awesome album
    ('May Song'), -- another awesome album
    ('The Pit'), -- another awesome album
    ('Remember'), -- another awesome album
    ('The Way You Look Tonight'), -- another awesome album
    ('Another Song'); -- another awesome album
-- Other tracks are inserted similarly...

-- Insert data into TrackAlbumAssociation Table
INSERT INTO 
    TrackAlbumAssociation (track_id, album_id)
VALUES 
    (1, 1), -- Assuming track_id 1 is '5,000 Candles in the Wind'
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 2),
    (6, 2),
    (7, 2);
     
-- Other track-album associations are inserted similarly...

-- Insert data into SegmentTrackAssociation Table
-- Associations for segments in tracks
INSERT INTO
    SegmentTrackAssociation (segment_id, track_id)
VALUES 
    (11, 1), -- Assuming segment_id 1 belongs to the first session
    (12, 1),
    (13, 1),
    (14, 1),
    (15, 1),

    (16, 2),
    (17, 2),
    (18, 2),
    (19, 2),

    (20, 2),
    (21, 2),

    (22, 1),
    (23, 1),
    (24, 1),
    (25, 1),
    (26, 1),
    (22, 2),
    (23, 2),
    (24, 2),
    (25, 2),
    (26, 2),

    (32, 3),
    (33, 3),
    (34, 4),
    (35, 4),

    (36, 5),
    (37, 5),
    (38, 6),
    (39, 6),
    (40, 7),
    (41, 7);


-- Other segment-track associations are inserted similarly...

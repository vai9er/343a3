SET SEARCH_PATH TO recording;

-- Insert sample data into Studio table
INSERT INTO Studio (name, address, manager_id) VALUES
    ('Studio A', '123 Main Street', 1),
    ('Studio B', '456 Oak Avenue', 2),
    ('Studio C', '789 Pine Boulevard', 3);

-- Insert sample data into Person table
INSERT INTO Person (name, email, phone_number, is_engineer, certification) VALUES
    ('John Doe', 'john@example.com', '555-1234', true, 'Audio Engineer'),
    ('Jane Smith', 'jane@example.com', '555-5678', false, NULL),
    ('Bob Johnson', 'bob@example.com', '555-9876', false, NULL);

-- Insert sample data into MANAGES table
INSERT INTO MANAGES (manager_id, studio_id, start_time) VALUES
    (1, 1, '2023-01-01 08:00:00'),
    (2, 2, '2023-01-01 09:00:00'),
    (3, 3, '2023-01-01 10:00:00');

-- Insert sample data into Session table
INSERT INTO Session (studio_id, session_start, session_end, session_fee, engineer_1, engineer_2, engineer_3) VALUES
    (1, '2023-01-02 10:00:00', '2023-01-02 12:00:00', 500.00, 1, NULL, NULL),
    (2, '2023-01-03 14:00:00', '2023-01-03 16:00:00', 600.00, 1, NULL, NULL),
    (3, '2023-01-04 11:00:00', '2023-01-04 13:00:00', 700.00, 1, NULL, NULL);

-- Insert sample data into EngineerSessionAssociation table
/*
INSERT INTO EngineerSessionAssociation (engineer_id, session_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3);
    */

-- Insert sample data into Band table
INSERT INTO Band (name) VALUES
    ('Band1'),
    ('Band2');

-- Insert sample data into BandMember table
INSERT INTO BandMember (band_id, person_id) VALUES
    (1, 1),
    (1, 2),
    (2, 3);

-- Insert sample data into Participation table
INSERT INTO Participation (session_id, person_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Insert sample data into RecordingSegment table
INSERT INTO RecordingSegment (session_id, segment_id, length_seconds, format1) VALUES
    (1, 1, 180, 'WAV'),
    (2, 2, 240, 'MP3'),
    (3, 3, 300, 'FLAC');

-- Insert sample data into Track table
INSERT INTO Track (name) VALUES
    ('Track1'),
    ('Track2');

-- Insert sample data into Album table
INSERT INTO Album (name, release_date) VALUES
    ('Album1', '2023-01-10'),
    ('Album2', '2023-02-15');

-- Insert sample data into TrackAlbumAssociation table
INSERT INTO TrackAlbumAssociation (track_id, album_id) VALUES
    (1, 1),
    (2, 1),
    (1, 2),
    (2, 2);

-- Insert sample data into SegmentTrackAssociation table
INSERT INTO SegmentTrackAssociation (segment_id, track_id) VALUES
    (1, 1),
    (2, 2),
    (3, 1);

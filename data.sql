-- Insert data into Studio Table
INSERT INTO Studio (name, address, manager_id) VALUES ('Pawnee Recording Studio', '123 Valley Spring Lane, Pawnee, Indiana', 1233);
INSERT INTO Studio (name, address, manager_id) VALUES ('Pawnee Sound', '353 Western Ave, Pawnee, Indiana', 1233);
INSERT INTO Studio (name, address, manager_id) VALUES ('Eagleton Recording Studio', '829 Division, Eagleton, Indiana', 1232);

-- Insert data into Person Table
-- Adding managers, engineers, and band members
INSERT INTO Person (person_id, name, email, phone_number, is_engineer) VALUES (1231, 'April Ludgate', 'april@email.com', '123-456-7890', FALSE);
-- Other persons are inserted similarly...

-- Insert data into Band Table
INSERT INTO Band (name) VALUES ('Mouse Rat');

-- Insert data into BandMember Table
INSERT INTO BandMember (band_id, person_id) VALUES (1, 6754); -- Assuming Mouse Rat's band_id is 1
-- Other band members are inserted similarly...

-- Insert data into Session Table
-- Sessions for 'Mouse Rat' at 'Pawnee Recording Studio'
INSERT INTO Session (studio_id, engineer_id, session_start, session_end, session_fee) 
VALUES (1, 5678, '2023-01-08 10:00', '2023-01-08 15:00', 1500);
-- Other sessions are inserted similarly...

-- Insert data into RecordingSegment Table
-- Segments from the first session of 'Mouse Rat'
INSERT INTO RecordingSegment (session_id, length_seconds, format) VALUES (1, 60, 'WAV');
-- Other segments are inserted similarly...

-- Insert data into Album Table
INSERT INTO Album (album_id, name, release_date) VALUES (1, 'The Awesome Album', '2023-05-25');
INSERT INTO Album (album_id, name, release_date) VALUES (2, 'Another Awesome Album', '2023-10-29');

-- Insert data into Track Table
-- Tracks for 'The Awesome Album'
INSERT INTO Track (name) VALUES ('5,000 Candles in the Wind');
-- Other tracks are inserted similarly...

-- Insert data into TrackAlbumAssociation Table
INSERT INTO TrackAlbumAssociation (track_id, album_id) VALUES (1, 1); -- Assuming track_id 1 is '5,000 Candles in the Wind'
-- Other track-album associations are inserted similarly...

-- Insert data into SegmentTrackAssociation Table
-- Associations for segments in tracks
INSERT INTO SegmentTrackAssociation (segment_id, track_id) VALUES (1, 1); -- Assuming segment_id 1 belongs to the first session
-- Other segment-track associations are inserted similarly...

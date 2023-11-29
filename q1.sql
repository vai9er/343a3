-- You must not change the next 2 lines or the table definition.
SET search_path TO recording;
DROP TABLE IF EXISTS q1 CASCADE;

CREATE TABLE q1 (
    studio_id INTEGER NOT NULL,
	manager_id INTEGER NOT NULL,
	name VARCHAR(255) NOT NULL,
    num INTEGER NOT NULL
);

-- Do this for each of the views that define your intermediate steps.
-- (But give them better names!) The IF EXISTS avoids generating an error
-- the first time this file is imported.
DROP VIEW IF EXISTS StudioManager CASCADE;
DROP VIEW IF EXISTS StudioSessionAlbum CASCADE;
DROP VIEW IF EXISTS num_albums CASCADE;
DROP VIEW IF EXISTS Answer CASCADE;

-- Define views for your intermediate steps here:
CREATE VIEW StudioManager AS 
Select Studio.studio_id, Studio.manager_id, person.name
from Studio join Person 
on Studio.manager_id = Person.person_id;

CREATE VIEW StudioSessionAlbum AS
Select distinct Session.studio_id, TrackAlbumAssociation.album_id
from 
    TrackAlbumAssociation Join SegmentTrackAssociation
    on SegmentTrackAssociation.track_id=TrackAlbumAssociation.track_id
    JOIN RecordingSegment 
    on RecordingSegment.segment_id = SegmentTrackAssociation.segment_id
    JOIN Session
    on RecordingSegment.session_id = Session.session_id;

Create VIEW num_albums AS
Select studio_id, count(studio_id) as num
from StudioSessionAlbum
group by studio_id;

Create View Answer AS
Select StudioManager.studio_id, manager_id, name, COALESCE(num, 0) as num
from StudioManager left join num_albums
on StudioManager.studio_id = num_albums.studio_id;

-- Your query that answers the question goes below the "insert into" line:
INSERT INTO q1(studio_id, manager_id, name, num)
select studio_id, manager_id, name, num
from Answer;

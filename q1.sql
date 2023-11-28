-- You must not change the next 2 lines or the table definition.
SET search_path TO recording;
DROP TABLE IF EXISTS q1 CASCADE;

CREATE TABLE q1 (
	manager_id INTEGER NOT NULL,
	name VARCHAR(255) NOT NULL,
    num INTEGER NOT NULL
);

-- Do this for each of the views that define your intermediate steps.
-- (But give them better names!) The IF EXISTS avoids generating an error
-- the first time this file is imported.
DROP VIEW IF EXISTS StudioManager CASCADE;
DROP VIEW IF EXISTS SegmentAlbum CASCADE;
DROP VIEW IF EXISTS SessionSegmentStudio CASCADE;
DROP VIEW IF EXISTS num_albums CASCADE;
DROP VIEW IF EXISTS Answer CASCADE;

-- Define views for your intermediate steps here:
CREATE VIEW StudioManager AS 
Select Studio.studio_id, Studio.manager_id, person.name
from Studio join Person 
on Studio.manager_id = Person.person_id;

CREATE VIEW SegmentAlbum AS
Select a.album_id, s.segment_id
from TrackAlbumAssociation a
join SegmentTrackAssociation s
on a.track_id=s.segment_id;

CREATE VIEW SessionSegmentStudio AS
Select s.studio_id, r.segment_id, r.session_id
from RecordingSegment r
join Session s
on r.session_id = s.session_id;

CREATE VIEW num_albums AS
Select SessionSegmentStudio.studio_id, count(SegmentAlbum.album_id) as num
from SegmentAlbum join SessionSegmentStudio
on SegmentAlbum.segment_id = SessionSegmentStudio.segment_id
group by SessionSegmentStudio.studio_id;

Create View Answer AS
Select manager_id, name, num
from StudioManager join num_albums
on StudioManager.studio_id = num_albums.studio_id;

-- Your query that answers the question goes below the "insert into" line:
INSERT INTO q1(manager_id, name, num)
select manager_id, name, num
from Answer;

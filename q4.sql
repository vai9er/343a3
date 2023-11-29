-- You must not change the next 2 lines or the table definition.
SET search_path TO recording;
DROP TABLE IF EXISTS q4 CASCADE;

CREATE TABLE q4 (
    album_id INTEGER NOT NULL,
	name VARCHAR(255) NOT NULL,
    num_sessions INTEGER NOT NULL,
    num_people INTEGER NOT NULL
);

-- Do this for each of the views that define your intermediate steps.
-- (But give them better names!) The IF EXISTS avoids generating an error
-- the first time this file is imported.
DROP VIEW IF EXISTS SegmentTrackAlbum CASCADE;
DROP VIEW IF EXISTS AlbumSession CASCADE;
DROP VIEW IF EXISTS count_segment CASCADE;
DROP VIEW IF EXISTS album_player CASCADE;
DROP VIEW IF EXISTS Answer CASCADE;

-- Define views for your intermediate steps here:
CREATE VIEW SegmentTrackAlbum AS
Select A.name, A.album_id, STA.track_id, STA.segment_id
from Album A
JOIN TrackAlbumAssociation TAA
on A.album_id = TAA.album_id
JOIN SegmentTrackAssociation STA
on TAA.track_id = STA.track_id;

CREATE VIEW AlbumSession AS
Select distinct name, album_id, session_id
from SegmentTrackAlbum
JOIN RecordingSegment
on SegmentTrackAlbum.segment_id = RecordingSegment.segment_id;

CREATE VIEW count_segment AS
Select 
    AlbumSession.name, 
    AlbumSession.album_id, 
    count(AlbumSession.album_id) as num
from AlbumSession
group by (AlbumSession.name, AlbumSession.album_id)
Order by num desc
limit 1;

CREATE VIEW album_player AS
Select distinct count_segment.album_id, person_id
from AlbumSession 
join Participation
on AlbumSession.session_id = Participation.session_id
join count_segment
on count_segment.album_id = AlbumSession.album_id;

CREATE VIEW Answer AS
Select 
    count_segment.name, 
    album_player.album_id,
    count_segment.num as num_sessions,
    count(album_player.album_id) as num_people
from count_segment
JOIN album_player
on count_segment.album_id = album_player.album_id
group by (count_segment.name, album_player.album_id, count_segment.num);

-- Your query that answers the question goes below the "insert into" line:
INSERT INTO q4(album_id, name, num_sessions, num_people)
select album_id, name, num_sessions, num_people
from Answer;

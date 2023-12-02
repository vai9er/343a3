SET search_path TO recording;
DROP TABLE IF EXISTS q3 CASCADE;

CREATE TABLE q3 (
    session_id INTEGER NOT NULL,
	person_id INTEGER NOT NULL,
	name VARCHAR(255) NOT NULL
);

DROP VIEW IF EXISTS SessionSum CASCADE;
DROP VIEW IF EXISTS players CASCADE;

CREATE VIEW SessionSum AS 
Select session_id, sum(length_seconds) as len
from RecordingSegment
group by session_id
Order by len desc
limit 1;

CREATE View players AS
Select pa.session_id, p.person_id, p.name
from Participation pa
join SessionSum s
on pa.session_id = s.session_id
join Person p
on pa.person_id = p.person_id;

INSERT INTO q3(session_id, person_id, name)
select session_id, person_id, name
from players;

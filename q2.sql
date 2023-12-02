SET search_path TO recording;
DROP TABLE IF EXISTS q2 CASCADE;

CREATE TABLE q2 (
	person_id INTEGER NOT NULL,
    num INTEGER NOT NULL
);

DROP VIEW IF EXISTS PlayerParticipation CASCADE;
DROP VIEW IF EXISTS non_participants CASCADE;
DROP VIEW IF EXISTS Answer CASCADE;

CREATE VIEW PlayerParticipation AS 
Select person_id, count(person_id) as num
from Participation
group by person_id;

Create VIEW non_participants AS
Select person_id, 0 as num
from Person
Where not EXISTS ( 
    Select 1
    From PlayerParticipation 
    Where PlayerParticipation.person_id = Person.person_id
);

Create View Answer AS
Select person_id, num from PlayerParticipation
UNION ALL
Select person_id, num from non_participants;

INSERT INTO q2(person_id, num)
select person_id, num
from Answer
Order by num desc;
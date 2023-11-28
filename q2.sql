-- You must not change the next 2 lines or the table definition.
SET search_path TO recording;
DROP TABLE IF EXISTS q2 CASCADE;

CREATE TABLE q2 (
	person_id INTEGER NOT NULL,
    num INTEGER NOT NULL
);

-- Do this for each of the views that define your intermediate steps.
-- (But give them better names!) The IF EXISTS avoids generating an error
-- the first time this file is imported.
DROP VIEW IF EXISTS PlayerParticipation CASCADE;
DROP VIEW IF EXISTS Engineer_id CASCADE;
DROP VIEW IF EXISTS EngineerParticipation CASCADE;
DROP VIEW IF EXISTS ManagerSession CASCADE;
DROP VIEW IF EXISTS ManagerParticipation CASCADE;
DROP VIEW IF EXISTS Coallated CASCADE;
DROP VIEW IF EXISTS Coallated_nums CASCADE;
DROP VIEW IF EXISTS non_participants CASCADE;
DROP VIEW IF EXISTS Answer CASCADE;

-- Define views for your intermediate steps here:

CREATE VIEW PlayerParticipation AS 
Select person_id, count(person_id) as num
from Participation
group by person_id;

Create VIEW Engineer_id AS
Select
    engineer_1 as person_id
from Session
UNION ALL
Select
    engineer_2 as person_id
from Session
UNION ALL
Select
    engineer_3 as person_id
from Session;

Create VIEW EngineerParticipation AS
Select 
    person_id, count(person_id)
from Engineer_id
where person_id is not null
group by (person_id);

Create VIEW ManagerSession AS
Select m.manager_id, s.session_id
from MANAGES m join Session s
on m.studio_id = s.studio_id
where 
    m.start_time <= s.session_start
    AND NOT EXISTS ( -- reference gpt
        SELECT 1
        FROM MANAGES M2
        WHERE
            M2.studio_id = M.studio_id
            AND M2.start_time > M.start_time
            AND M2.start_time <= S.session_start
    );

Create VIEW ManagerParticipation AS
Select manager_id as person_id, count(manager_id) as num
from ManagerSession
group by manager_id;

Create VIEW Coallated AS
(Select * from PlayerParticipation) 
UNION ALL (Select * from EngineerParticipation)
UNION ALL (Select * from ManagerSession);

Create VIEW Coallated_nums AS
Select person_id, sum(num) as num
from Coallated
Group By person_id;

Create VIEW non_participants AS
Select person_id, 0 as num
from Person
Where not EXISTS ( 
    Select 1
    From Coallated
    Where Coallated.person_id = Person.person_id
);

Create View Answer AS
Select * from Coallated_nums
UNION ALL
Select * from non_participants;

-- Your query that answers the question goes below the "insert into" line:
INSERT INTO q2(person_id, num)
select person_id, num
from Answer;

--- Q6 : IPL Matches --- 

drop table if exists teams;
create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');

SELECT * FROM teams;

WITH CTE AS
	(SELECT ROW_NUMBER() OVER(ORDER BY team_code) id, t.* FROM teams t)
SELECT team.team_name team, opponent.team_name opponent 
FROM CTE team
JOIN CTE opponent ON team.id < opponent.id
ORDER BY team;

WITH CTE AS
	(SELECT ROW_NUMBER() OVER(ORDER BY team_code) id, t.* FROM teams t)
SELECT team.team_name team, opponent.team_name opponent 
FROM CTE team
JOIN CTE opponent ON team.id <> opponent.id
ORDER BY team;
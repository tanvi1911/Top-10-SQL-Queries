--- Q4 : Convert the given input to expected output --- 

drop table if exists src_dest_distance;
create table src_dest_distance
(
    source          varchar(20),
    destination     varchar(20),
    distance        int
);
insert into src_dest_distance values ('Bangalore', 'Hyderbad', 400);
insert into src_dest_distance values ('Hyderbad', 'Bangalore', 400);
insert into src_dest_distance values ('Mumbai', 'Delhi', 400);
insert into src_dest_distance values ('Delhi', 'Mumbai', 400);
insert into src_dest_distance values ('Chennai', 'Pune', 400);
insert into src_dest_distance values ('Pune', 'Chennai', 400);

select CTID, * from src_dest_distance;

WITH CTE AS 
	(SELECT *, ROW_NUMBER() OVER() AS rn
	FROM src_dest_distance)
SELECT t1.source, t1.destination, t1.distance
FROM CTE t1
JOIN CTE t2
		ON t1.rn >t2.rn
		AND t1.source = t2.destination
		AND t1.destination = t2.source;
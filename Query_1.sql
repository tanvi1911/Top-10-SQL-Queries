--- Q1: Delete duplicate data --- 

drop table if exists cars;
create table cars
(
	model_id		int primary key,
	model_name		varchar(100),
	color			varchar(100),
	brand			varchar(100)
);
insert into cars values(1,'Leaf', 'Black', 'Nissan');
insert into cars values(2,'Leaf', 'Black', 'Nissan');
insert into cars values(3,'Model S', 'Black', 'Tesla');
insert into cars values(4,'Model X', 'White', 'Tesla');
insert into cars values(5,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(6,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(7,'Ioniq 6', 'White', 'Hyundai');

select CTID, * from cars;

--Solution-1--

DELETE FROM cars
	WHERE model_id NOT IN (SELECT MIN(model_id)
						 	FROM cars
						  	GROUP BY model_name, brand);
							
							
--Solution-2--

DELETE FROM cars
WHERE CTID IN (SELECT MAX(CTID)
				FROM cars
				GROUP BY model_name, brand
				HAVING COUNT(1) > 1);

--Solution-3--

DELETE FROM cars
WHERE model_id IN (SELECT model_id 
FROM (SELECT *, 
	  ROW_NUMBER() OVER(PARTITION BY model_name, brand ORDER BY model_id) AS rn
	  FROM cars) x
	  WHERE x.rn > 1);



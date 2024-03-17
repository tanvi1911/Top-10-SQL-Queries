--- Q5 : Ungroup the given input data --- 

drop table if exists travel_items;
create table travel_items
(
	id              int,
	item_name       varchar(50),
	total_count     int
);
insert into travel_items values (1, 'Water Bottle', 2);
insert into travel_items values (2, 'Tent', 1);
insert into travel_items values (3, 'Apple', 4);

SELECT * FROM travel_items;

WITH recursive CTE AS
	(SELECT id, item_name, total_count, 1 AS level
	 FROM travel_items t
	 UNION ALL
	 SELECT CTE.id, CTE.item_name, CTE.total_count - 1, level+1 AS level
	 FROM CTE
	 JOIN travel_items t ON t.id = CTE.id
	 WHERE CTE.total_count > 1)

SELECT id, item_name, level
FROM CTE
ORDER BY 3;
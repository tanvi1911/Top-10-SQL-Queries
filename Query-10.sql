--- Q10: Pizza Delivery Status --- 

drop table if exists cust_orders;
create table cust_orders
(
cust_name   varchar(50),
order_id    varchar(10),
status      varchar(50)
);

insert into cust_orders values ('John', 'J1', 'DELIVERED');
insert into cust_orders values ('John', 'J2', 'DELIVERED');
insert into cust_orders values ('David', 'D1', 'SUBMITTED');
insert into cust_orders values ('David', 'D2', 'DELIVERED'); -- This record is missing in question
insert into cust_orders values ('David', 'D3', 'CREATED');
insert into cust_orders values ('Smith', 'S1', 'SUBMITTED');
insert into cust_orders values ('Krish', 'K1', 'CREATED');

SELECT * FROM cust_orders;

SELECT DISTINCT cust_name AS customer_name, 'COMPLETED' AS status
FROM cust_orders D
WHERE D.status = 'DELIVERED'
AND NOT EXISTS (SELECT 1 FROM cust_orders D2
			   WHERE D2.cust_name = D.cust_name
			   AND status IN ('SUBMITTED','CREATED'))
		
UNION
SELECT DISTINCT cust_name AS customer_name, 'IN PROGRESS' AS status
FROM cust_orders D
WHERE D.status = 'DELIVERED'
AND EXISTS (SELECT 1 FROM cust_orders D2
			   WHERE D2.cust_name = D.cust_name
			   AND status IN ('SUBMITTED','CREATED'))
			   
UNION
SELECT DISTINCT cust_name AS customer_name, 'AWAITING PROGRESS' AS status
FROM cust_orders D
WHERE D.status = 'SUBMITTED'
AND NOT EXISTS (SELECT 1 FROM cust_orders D2
			   WHERE D2.cust_name = D.cust_name
			   AND status IN ('DELIVERED','CREATED'))

UNION
SELECT DISTINCT cust_name AS customer_name, 'AWAITING STATUS' AS status
FROM cust_orders D
WHERE D.status = 'CREATED'
AND NOT EXISTS (SELECT 1 FROM cust_orders D2
			   WHERE D2.cust_name = D.cust_name
			   AND status IN ('SUBMITTED','DELIVERED'));
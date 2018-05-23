-- CRIMSON CUSTOMER MOVEMENT
use rcbill_my;
set @reportdate='2017-12-02';
SET @rundate='2017-12-02';

/*
select * from rcbill_my.crimsoncustomerjourney
where 
clientcode in 
(
select distinct o_clientcode, count(*) from rcbill_my.salestoactive
where o_servicetype in ('Crimson','Crimson Corporate')
group by 1
order by 2 desc

)
;


select * from rcbill_my.crimsoncustomerjourney
where 
clientcode not in 
(
select o_clientcode from rcbill_my.salestoactive
where o_servicetype in ('Crimson','Crimson Corporate')

)
;
select * from rcbill_my.salestoactive
where o_servicetype in ('Crimson','Crimson Corporate')
order by o_num
;
*/

select o_orderday as salesdate, a.o_clientcode as clientcode, b.clientname, a.o_clientclass as origclientclass, a.o_servicetype as origpackage, a.o_ordertype as ordertype, a.firstactivedateforclient, a.lastactivedateforclient,
b.clientclass as lastclientclass, b.contractcode, b.package as package, b.firstcontractdate, b.lastcontractdate, b.durationforcontract,b.activedaysforcontract,b.currentstatus
-- , b.activedaysforclient
, rcbill_my.GetActiveDaysForClient(a.o_clientcode) as ActiveDaysForClient
, b.dayssincelastactive, b.activitystatus
from 
(
select * from rcbill_my.salestoactive
where o_servicetype in ('Crimson','Crimson Corporate')
) a
left join
(

-- select * from rcbill_my.crimsoncustomerjourney

	select a.*,
	case 
	when a.dayssincelastactive=0 then '1. Alive' 
	when a.dayssincelastactive>0 and a.dayssincelastactive<=7 then '2. Snoozing'
	when a.dayssincelastactive>7 and a.dayssincelastactive<=30 then '3. Asleep'
	when a.dayssincelastactive>30 and a.dayssincelastactive<=90 then '4. Comatose'
	when a.dayssincelastactive>90 then '5. Dead'
	end as `ActivityStatus` 
	 from 
	(
	SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.crimsoncustomerjourney t1
	  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.crimsoncustomerjourney GROUP BY clientcode) t2
		ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
	) a

) b
on
a.o_clientcode=b.clientcode
;


/*
select a.*,
case 
when a.dayssincelastactive=0 then '1. Alive' 
when a.dayssincelastactive>0 and a.dayssincelastactive<=7 then '2. Snoozing'
when a.dayssincelastactive>7 and a.dayssincelastactive<=30 then '3. Asleep'
when a.dayssincelastactive>30 and a.dayssincelastactive<=90 then '4. Comatose'
when a.dayssincelastactive>90 then '5. Dead'
end as `ActivityStatus` 
 from 
(
SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.crimsoncustomerjourney t1
  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.crimsoncustomerjourney GROUP BY clientcode) t2
    ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
) a
;

*/
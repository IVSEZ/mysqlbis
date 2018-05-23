-- CRIMSON CUSTOMER MOVEMENT
use rcbill_my;
set @reportdate='2017-12-31';
SET @rundate='2017-12-31';

drop table if exists rcbill_my.crimsoncustomeractivity;

create table rcbill_my.crimsoncustomeractivity
as
(
		
		-- select a.*,b.clientname, b.clientclass
		-- from 
		-- (
			select a.* 
				-- , rcbill_my.GetActiveDaysForContract(clientcode,contractcode,package) as ActiveDaysForContract
				-- , rcbill_my.GetActiveDaysForClient(clientcode) as ActiveDaysForClient            
            from 
            (
				select distinct clientcode, clientname, clientclass, contractcode, package
                , min(period) as firstcontractdate
				, max(period) as lastcontractdate
				, (sum(ACTIVECOUNT)/count(period)) as activecount
				, (datediff(max(period),min(period))+1) as DurationForContract
				, rcbill_my.GetActiveDaysForContract(clientcode,contractcode,package) as ActiveDaysForContract
				-- , rcbill_my.GetActiveDaysForClient(clientcode) as ActiveDaysForClient
				-- , count(period) as activedays 
				,
					case when max(period) = @reportdate then 'Active' 
					else 'Not Active'
					end as `CurrentStatus`
				from rcbill_my.customercontractactivity 
				where package in ('Crimson','Crimson Corporate') and period>='2017-03-25'
				group by clientcode, contractcode, package
				ORDER BY clientcode, 4
			-- ) a
			-- inner join
			-- (
			-- 	select distinct clientcode, clientname, clientclass from rcbill_my.clientstats 
			-- ) b
			-- on a.clientcode=b.clientcode
			-- order by a.clientcode, a.firstcontractdate
			) a 
        

);

select * from rcbill_my.crimsoncustomeractivity;

-- GET CUSTOMERS WHOSE STATUS IS NOT ACTIVE
-- select * from rcbill_my.crimsoncustomeractivity where currentstatus='Not Active';

-- FIND OUT WHERE THEY WENT AFTER LASTCONTRACTDATE
/*
select a.clientcode, a.contractcode, a.package, a.firstcontractdate, a.lastcontractdate, a.duration, a.activedays, a.clientname, a.clientclass
,
b.contractcode, b.package, 
*/
drop table if exists rcbill_my.postcrimsoncustomeractivity;

create table rcbill_my.postcrimsoncustomeractivity as
(
			select distinct a.clientcode,a.clientname, a.clientclass, a.contractcode, a.package
            , min(a.period) as firstcontractdate
            , max(a.period) as lastcontractdate
            , (sum(ACTIVECOUNT)/count(period)) as activecount
            , (datediff(max(a.period),min(a.period))+1) as DurationForContract
            -- , count(distinct a.period) as activedays 
			, rcbill_my.GetActiveDaysForContract(a.clientcode,a.contractcode,a.package) as ActiveDaysForContract
			,
				case when max(a.period) = @reportdate then 'Active' 
				else 'Not Active'
				end as `CurrentStatus`
			from rcbill_my.customercontractactivity a
            inner join
            (
				select clientcode, contractcode, lastcontractdate from rcbill_my.crimsoncustomeractivity where currentstatus='Not Active'
            ) b
            on
            a.clientcode=b.clientcode and a.contractcode=b.contractcode -- and a.period>b.lastcontractdate
            where a.servicecategory='Internet'
			-- where (clientcode, period) in () 
			group by a.clientcode, a.contractcode, a.package
			ORDER BY a.clientcode, 4
);

-- select * from rcbill_my.postcrimsoncustomeractivity;
-- select * from rcbill_my.crimsoncustomeractivity;


-- PRE CRIMSON ACTIVITY
-- Get previous activity for customers who are currently on Crimson
drop table if exists rcbill_my.precrimsoncustomeractivity;
-- duration 953.390 sec

create table rcbill_my.precrimsoncustomeractivity as
(
			select distinct a.clientcode,a.clientname, a.clientclass, a.contractcode, a.package
            , min(a.period) as firstcontractdate
            , max(a.period) as lastcontractdate
            , (sum(ACTIVECOUNT)/count(period)) as activecount
            , (datediff(max(a.period),min(a.period))+1) as DurationForContract
            -- , count(distinct a.period) as activedays 
			, rcbill_my.GetActiveDaysForContract(a.clientcode,a.contractcode,a.package) as ActiveDaysForContract
			,
				case when max(a.period) = @reportdate then 'Active' 
				else 'Not Active'
				end as `CurrentStatus`
			from rcbill_my.customercontractactivity a
            inner join
            (
				-- select clientcode, contractcode, firstcontractdate from rcbill_my.crimsoncustomeractivity where currentstatus='Active'
                select distinct clientcode, min(firstcontractdate) as firstcontractdate from rcbill_my.crimsoncustomeractivity group by clientcode
            ) b
            on
            a.clientcode=b.clientcode and a.period<b.firstcontractdate
            where a.servicecategory='Internet'
			-- where (clientcode, period) in () 
			group by a.clientcode, a.contractcode, a.package
			ORDER BY a.clientcode, 4
);

-- select * from rcbill_my.precrimsoncustomeractivity;


-- CRIMSON CUSTOMER JOURNEY
drop table if exists rcbill_my.crimsoncustomerjourney;

-- duration 793.375 sec

create table rcbill_my.crimsoncustomerjourney
as
(
	-- select a.*, b.ClientName, b.ClientClass
	-- from 
	-- (
		select *
        -- , rcbill_my.GetActiveDaysForClient(a.clientcode) as ActiveDaysForClient 
        from 
        (
			select distinct a.clientcode, a.clientname, a.clientclass, a.contractcode, a.package, a.firstcontractdate, a.lastcontractdate, a.activecount
            , a.DurationForContract, a.ActiveDaysForContract
            , a.currentstatus
			from 
			rcbill_my.crimsoncustomeractivity a
			union distinct
			( select a.clientcode,a.clientname, a.clientclass, a.contractcode, a.package, a.firstcontractdate, a.lastcontractdate, a.activecount
            , a.DurationForContract, a.ActiveDaysForContract
            , a.currentstatus 
			from rcbill_my.postcrimsoncustomeractivity a) 
			union distinct
			( select a.clientcode,a.clientname, a.clientclass, a.contractcode, a.package, a.firstcontractdate, a.lastcontractdate, a.activecount
            , a.DurationForContract, a.ActiveDaysForContract
            , a.currentstatus 
			from rcbill_my.precrimsoncustomeractivity a) 
			order by clientcode, firstcontractdate
        ) a
	-- ) a
	-- inner join
	-- (
	-- 	select distinct clientcode, clientname, clientclass from rcbill_my.clientstats 
	-- ) b
	-- on a.clientcode=b.clientcode
	-- order by a.clientcode, a.firstcontractdate
)
;

select * from rcbill_my.crimsoncustomeractivity;
select * from rcbill_my.precrimsoncustomeractivity;
select * from rcbill_my.postcrimsoncustomeractivity;

select * from rcbill_my.crimsoncustomerjourney;

-- select distinct clientclass from rcbill_my.crimsoncustomerjourney ;
-- select distinct clientcode from rcbill_my.crimsoncustomerjourney ;

-- select * from rcbill_my.crimsoncustomerjourney where currentstatus='Currently Active' and package in ('Crimson','Crimson Corporate');
-- select distinct clientcode from rcbill_my.crimsoncustomerjourney where currentstatus='Currently Active' and package in ('Crimson','Crimson Corporate');
-- select * from rcbill_my.crimsoncustomerjourney where activedaysforclient=activedaysforcontract;

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

select ActivityStatus, count(*), count(distinct clientcode)
from (
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
) a 
group by ActivityStatus
with rollup
;
/*
select distinct clientcode from 
(
SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.crimsoncustomerjourney t1
  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.crimsoncustomerjourney GROUP BY clientcode) t2
    ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
) a
where a.currentstatus='Not Active'
;

select distinct clientcode from 
(
SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.crimsoncustomerjourney t1
  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.crimsoncustomerjourney GROUP BY clientcode) t2
    ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
) a
where a.currentstatus='Currently Active'
;

select a.currentstatus, a.package, a.clientclass, count(distinct a.contractcode) as contracts , count(distinct a.clientcode) as uniqueaccounts from 
(
SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.crimsoncustomerjourney t1
  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.crimsoncustomerjourney GROUP BY clientcode) t2
    ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
) a
-- where a.currentstatus='Currently Active'
group by a.currentstatus, a.package, a.clientclass
-- with rollup
;
*/


/*
select distinct clientcode from rcbill_my.crimsoncustomerjourney where clientclass not in ('Employee','Intelvision Office');
select distinct clientcode from rcbill_my.crimsoncustomerjourney where currentstatus='Currently Active' and package in ('Crimson','Crimson Corporate');

select * from rcbill_my.clientstats where clientcode in (
select distinct clientcode from rcbill_my.crimsoncustomerjourney where currentstatus='Currently Active' and package='Crimson');

select clientclass, package, count(distinct clientcode), sum(activecount) from rcbill_my.customercontractactivity where period=@rundate 
and package in ('Crimson','Crimson Corporate')
and servicecategory='Internet' 
and clientcode in (select distinct clientcode from rcbill_my.crimsoncustomerjourney where currentstatus='Currently Active' and package in ('Crimson','Crimson Corporate'))
group by clientclass, package
with rollup
;

*/
/*
select distinct a.*,
b.contractcode as b_contractcode, b.package as b_package, b.firstcontractdate as b_firstcontractdate, b.lastcontractdate as b_lastcontractdate
, b.duration as b_duration, b.activedays as b_activedays, b.currentstatus as b_currentstatus
from 
rcbill_my.crimsoncustomeractivity a 
left join 
rcbill_my.postcrimsoncustomeractivity b 
on a.clientcode=b.clientcode
order by 
a.clientcode, firstcontractdate, b_firstcontractdate;
*/
select * from rcbill.clientcontractdevices 
where 
-- ClientCode='I19567' 
-- and 
ServiceType='NEXTTV'
and mac is not null and length(mac)>0
;

-- select * from rcbill.rcb_livetvtelemetry where DEVICE='0c.56.5c.7d.11.a1';
-- select * from rcbill.rcb_tstelemetry where DEVICE='0c.56.5c.7d.11.97';
 
 select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0;
 select ContractCode from rcbill_my.customercontractsnapshot where package='DualView';
 
select * from rcbill.rcb_livetvtelemetry where DEVICE in 
( select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0)
;


select resource, sum(duration) as timewatched, count(distinct DEVICE) as devices from 
(
	select * from rcbill.rcb_livetvtelemetry where DEVICE in 
	( select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0)

) a 
group by resource
order by 2 desc
;

-- select * from rcbill.rcb_livetvtelemetry limit 100;
-- option1
drop temporary table if exists a;
create temporary table a as
(
		select a.mac from 
		(
			select *
			, (select a.clientclass from rcbill_my.rep_allcust a where a.ClientCode=b.ClientCode) as ClientClass
			from rcbill.clientcontractdevices b where ServiceType='NEXTTV' and mac is not null and length(mac)>0
        ) a where a.clientclass not in ('INTELVISION OFFICE')
);
drop temporary table if exists b;
create temporary table b as 
(
	select * from rcbill.rcb_livetvtelemetry where DEVICE in 
	( 
    -- select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0
		select a.mac from a
    )
    and date(SESSIONSTART)>='2019-01-01'
);

select resource, sum(duration) as timewatched, count(distinct DEVICE) as devices from 
b 
group by resource
order by 2 desc
;
drop temporary table if exists a;
drop temporary table if exists b;


-- option2
	select date(sessionstart) as view_date, day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year
    , upper(trim(resource)) as resource, count(*) as sessions
	, sum(duration) as duration_sec
	-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
	-- , TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
	from 
    rcbill.clientlivetvstats
	where device in
    (
			select distinct mac from rcbill.clientcontractdevices
			where contractcode in 
			(
			  select ContractCode from rcbill_my.customercontractsnapshot where package='DualView'

			)
			and ServiceType='NEXTTV'
			and mac is not null    
    )
	group by 1,2,3,4,5
	-- order by 3 desc,2 desc,1 desc,5 desc
    order by 1 asc
    ;
use rcbill;
###################################
-- show index from rcbill.rcb_ipusage1
-- show index from rcbill.clientcontractdevices

-- select * from rcbill.rcb_ipusage1 limit 1000;
-- select * from rcbill.clientcontractdevices limit 1000;

drop table if exists rcbill.rcb_ipusage;
create table rcbill.rcb_ipusage as 
(
	select 
	a.*
	,
	-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
	case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
	else INET_NTOA(a.clientip)
	end as PROCESSEDCLIENTIP 
	, (a.octets)/(1024.0*1024.0) as MB_USED
	,b.clientcode as CLIENTCODE, b.clientid as CLIENTID, b.clientname as CLIENTNAME, b.contractcode as CONTRACTCODE
	from 
	rcbill.rcb_ipusage1 a 
	inner join
	rcbill.clientcontractdevices b 
	on 	
	a.cid=b.contractid and a.csid=b.CSID
)
;

	CREATE INDEX idxrcbipu1
	ON rcbill.rcb_ipusage (deviceid);

	CREATE INDEX idxrcbipu2
	ON rcbill.rcb_ipusage (cid);

	CREATE INDEX idxrcbipu3
	ON rcbill.rcb_ipusage (csid);

	CREATE INDEX idxrcbipu4
	ON rcbill.rcb_ipusage (usagedate);
	
    CREATE INDEX idxrcbipu5
	ON rcbill.rcb_ipusage (clientcode);
    
    CREATE INDEX idxrcbipu6
	ON rcbill.rcb_ipusage (contractcode);
    
    CREATE INDEX idxrcbipu7
	ON rcbill.rcb_ipusage (processedclientip);
    
    CREATE INDEX idxrcbipu8
	ON rcbill.rcb_ipusage (clientid);
    
    -- CREATE INDEX idxrcbipu9 
    -- on rcbill.rcb_ipusage (CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE, USAGEDIRECTION);

select count(*) as ipusage from rcbill.rcb_ipusage;

-- select * from rcbill.rcb_ipusage order by usagedate desc limit 100;

########################################################
drop table if exists rcbill.clientcontractip;
create table rcbill.clientcontractip as 
(
	select distinct CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE from rcbill.rcb_ipusage
 --   group by CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE
-- where processedclientip=@ip;
-- where USAGEDATE>='2018-01-01' 

);

create index IDXccip1 on rcbill.clientcontractip (PROCESSEDCLIENTIP);
create index IDXccip2 on rcbill.clientcontractip (USAGEDATE);
create index IDXccip3 on rcbill.clientcontractip (CLIENTCODE);
create index IDXccip4 on rcbill.clientcontractip (CONTRACTCODE);
create index IDXccip5 on rcbill.clientcontractip (clientid);

select count(*) as clientcontractip from rcbill.clientcontractip;
###########################################################
-- set @kod3='I.000000852';


drop table if exists rcbill.clientcontractipusage_stg;
-- create table rcbill.clientcontractipusage_stg(index idxcciu1(clientcode),index idxcciu2(contractcode),index idxcciu3(CLIENT_ID),index idxcciu4(CONTRACT_ID), index idxcciu5(PROCESSEDCLIENTIP), index idxcciu6(USAGEDATE)) as 
create table rcbill.clientcontractipusage_stg(index idxcciu6(USAGEDATE)) as 
(
	select * from rcbill.clientcontractipusage
)
;

select count(*) as clientcontractipusage_stg from rcbill.clientcontractipusage_stg;


select count(*) as clientcontractipusage_beforeinsert from rcbill.clientcontractipusage;

insert into rcbill.clientcontractipusage
(
	select CLIENTCODE, CLIENTID as CLIENT_ID, CID as CONTRACT_ID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE
	, ifnull(sum(MB_UL),0) as MB_UL, ifnull(sum(MB_DL),0) as MB_DL, (ifnull(sum(MB_UL),0) + ifnull(sum(MB_DL),0)) as MB_TOTAL
    -- , (rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, USAGEDATE)) as PACKAGE 
    , ifnull(rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, USAGEDATE),rcbill_my.GetPackageFromSnapshot(CLIENTCODE, CONTRACTCODE)) as PACKAGE 
	from 
	(
		select a.*
		, case when a.USAGEDIRECTION='O' then MB_USED end as MB_UL
		, case when a.USAGEDIRECTION='I' then MB_USED end as MB_DL

		from 
		(
			select i1.CLIENTCODE, i1.CLIENTID, i1.CID, i1.CONTRACTCODE, i1.CLIENTIP, i1.PROCESSEDCLIENTIP, i1.USAGEDATE
            -- , i1.TRAFFICTYPE
            , (select name from rcbill.rcb_traffictypes tt where tt.TRAFFICID=i1.TRAFFICTYPE) as TRAFFICTYPE
				, i1.USAGEDIRECTION, SUM(i1.MB_USED) as MB_USED 
			from 
            (
				select * from rcbill.rcb_ipusage i1
				where 0=0
				-- and CLIENTCODE=@kod3
				-- and date(USAGEDATE)<>date(now())
				-- and i1.USAGEDATE<date(now())
                and (USAGEDATE>(select max(usagedate) from rcbill.clientcontractipusage_stg) and USAGEDATE<date(now()) )
             ) i1
             group by 1,2,3,4,5,6,7,8,9
		) a
	) a 
	group by CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE
	
)    
;





/*
drop table if exists rcbill.clientcontractipusage;
create table rcbill.clientcontractipusage(index idxcciu1(clientcode),index idxcciu2(contractcode),index idxcciu3(CLIENT_ID),index idxcciu4(CONTRACT_ID), index idxcciu5(PROCESSEDCLIENTIP) , index idxcciu6(USAGEDATE)) as 
(
	select CLIENTCODE, CLIENTID as CLIENT_ID, CID as CONTRACT_ID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE
	, ifnull(sum(MB_UL),0) as MB_UL, ifnull(sum(MB_DL),0) as MB_DL, (ifnull(sum(MB_UL),0) + ifnull(sum(MB_DL),0)) as MB_TOTAL
	from 
	(
		select a.*
		, case when a.USAGEDIRECTION='O' then MB_USED end as MB_UL
		, case when a.USAGEDIRECTION='I' then MB_USED end as MB_DL

		from 
		(
			select CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, (select name from rcbill.rcb_traffictypes tt where tt.TRAFFICID=i1.TRAFFICTYPE) as TRAFFICTYPE, USAGEDIRECTION, SUM(MB_USED) as MB_USED 
            from rcbill.rcb_ipusage i1
            where 0=0
			-- and CLIENTCODE=@kod3
            -- and date(USAGEDATE)<>date(now())
            and USAGEDATE<>date(now())
			group by CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE, USAGEDIRECTION
		) a
	) a 
	group by CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE

)
;

show index from rcbill.clientcontractipusage;
create index idxcciu7 on rcbill.clientcontractipusage (PACKAGE);

ALTER TABLE rcbill.clientcontractipusage ADD COLUMN PACKAGE varchar(255);


####update all null packages
-- select * from rcbill.clientcontractipusage where package is null;
set sql_safe_updates=0;

update rcbill.clientcontractipusage
set Package=ifnull(rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, USAGEDATE),rcbill_my.GetPackageFromSnapshot(CLIENTCODE, CONTRACTCODE))
where package is null;

*/
-- create index idxcciu6 on rcbill.clientcontractipusage(USAGEDATE);


select count(*) as clientcontractipusage_afterinsert from rcbill.clientcontractipusage;

set sql_safe_updates=0;

select 'updating null packages' as info;

update rcbill.clientcontractipusage
set Package=ifnull(rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, USAGEDATE),rcbill_my.GetPackageFromSnapshot(CLIENTCODE, CONTRACTCODE))
where package is null;


select usagedate, count(*) from rcbill.clientcontractipusage
group by usagedate
order by usagedate desc
limit 15
;
###########################################################



drop table if exists rcbill.clientcontractipmonth;
create table rcbill.clientcontractipmonth as 
(
/*
select DISTINCT
CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, MONTH(USAGEDATE) AS USAGE_MTH, YEAR(USAGEDATE) AS USAGE_YR, count(USAGEDATE) as IPINSTANCES
from rcbill.clientcontractip
group by 
CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, 7, 8
*/

	select DISTINCT
	CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, MONTH(USAGEDATE) AS USAGE_MTH
	, YEAR(USAGEDATE) AS USAGE_YR, min(USAGEDATE) as FROM_DATE, max(USAGEDATE) as TO_DATE,  count(USAGEDATE) as IPINSTANCES
	from rcbill.clientcontractip
	group by 
	CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, 7, 8
)
;

create index IDXccipm1 on rcbill.clientcontractipmonth (PROCESSEDCLIENTIP);
create index IDXccipm3 on rcbill.clientcontractipmonth (CLIENTCODE);
create index IDXccipm4 on rcbill.clientcontractipmonth (CONTRACTCODE);
create index IDXccipm2 on rcbill.clientcontractipmonth (USAGE_MTH);
create index IDXccipm5 on rcbill.clientcontractipmonth (USAGE_YR);
create index IDXccipm6 on rcbill.clientcontractipmonth (FROM_DATE);
create index IDXccipm7 on rcbill.clientcontractipmonth (TO_DATE);


select count(*) as clientcontractipmonth from rcbill.clientcontractipmonth;

######################################################################

-- select * from rcbill.clientcontractipusage where processedclientip='154.70.178.123' limit 1000;


drop table if exists rcbill_my.rep_dailypackageusage2021;

create table rcbill_my.rep_dailypackageusage2021(index idxrdpu1(usagedate), index idxrdpu2(package)) as
(
	select USAGEDATE, upper(PACKAGE) as PACKAGE, upper(TRAFFICTYPE) as TRAFFICTYPE
	, count(distinct clientcode) as CLIENTS
	, count(distinct contractcode) as CONTRACTS
	, count(*) as RECORDS
	, round(sum(MB_UL),2) as MB_UL, round(sum(MB_DL),2) as MB_DL, round(sum(MB_TOTAL),2) as MB_TOTAL 
	, round((sum(MB_UL)/1024),2) as GB_UL, round((sum(MB_DL)/1024),2) as GB_DL, round((sum(MB_TOTAL)/1024),2) as GB_TOTAL 

	from rcbill.clientcontractipusage where year(USAGEDATE)=2021
	group by 1,2,3
	order by 1 desc

)
;

select count(*) as rep_dailypackageusage2021 from rcbill_my.rep_dailypackageusage2021;

######################################################################

/*

drop table if exists rcbill_my.rep_dailypackageusage2018;

create table rcbill_my.rep_dailypackageusage2018(index idxrdpu1(usagedate), index idxrdpu2(package)) as
(
	select USAGEDATE, upper(PACKAGE) as PACKAGE, upper(TRAFFICTYPE) as TRAFFICTYPE
	, count(distinct clientcode) as CLIENTS
	, count(distinct contractcode) as CONTRACTS
	, count(*) as RECORDS
	, round(sum(MB_UL),2) as MB_UL, round(sum(MB_DL),2) as MB_DL, round(sum(MB_TOTAL),2) as MB_TOTAL 
	, round((sum(MB_UL)/1024),2) as GB_UL, round((sum(MB_DL)/1024),2) as GB_DL, round((sum(MB_TOTAL)/1024),2) as GB_TOTAL 

	from rcbill.clientcontractipusage where year(USAGEDATE)=2018
	group by 1,2,3
	order by 1 desc

)
;

select count(*) as rep_dailypackageusage2018 from rcbill_my.rep_dailypackageusage2018;

drop table if exists rcbill_my.rep_dailypackageusage2019;

create table rcbill_my.rep_dailypackageusage2019(index idxrdpu1(usagedate), index idxrdpu2(package)) as
(
	select USAGEDATE, upper(PACKAGE) as PACKAGE, upper(TRAFFICTYPE) as TRAFFICTYPE
	, count(distinct clientcode) as CLIENTS
	, count(distinct contractcode) as CONTRACTS
	, count(*) as RECORDS
	, round(sum(MB_UL),2) as MB_UL, round(sum(MB_DL),2) as MB_DL, round(sum(MB_TOTAL),2) as MB_TOTAL 
	, round((sum(MB_UL)/1024),2) as GB_UL, round((sum(MB_DL)/1024),2) as GB_DL, round((sum(MB_TOTAL)/1024),2) as GB_TOTAL 

	from rcbill.clientcontractipusage where year(USAGEDATE)=2019
	group by 1,2,3
	order by 1 desc

)
;

select count(*) as rep_dailypackageusage2019 from rcbill_my.rep_dailypackageusage2019;

drop table if exists rcbill_my.rep_dailypackageusage2020;

create table rcbill_my.rep_dailypackageusage2020(index idxrdpu1(usagedate), index idxrdpu2(package)) as
(
	select USAGEDATE, upper(PACKAGE) as PACKAGE, upper(TRAFFICTYPE) as TRAFFICTYPE
	, count(distinct clientcode) as CLIENTS
	, count(distinct contractcode) as CONTRACTS
	, count(*) as RECORDS
	, round(sum(MB_UL),2) as MB_UL, round(sum(MB_DL),2) as MB_DL, round(sum(MB_TOTAL),2) as MB_TOTAL 
	, round((sum(MB_UL)/1024),2) as GB_UL, round((sum(MB_DL)/1024),2) as GB_DL, round((sum(MB_TOTAL)/1024),2) as GB_TOTAL 

	from rcbill.clientcontractipusage where year(USAGEDATE)=2020
	group by 1,2,3
	order by 1 desc

)
;

select count(*) as rep_dailypackageusage2020 from rcbill_my.rep_dailypackageusage2020;


*/


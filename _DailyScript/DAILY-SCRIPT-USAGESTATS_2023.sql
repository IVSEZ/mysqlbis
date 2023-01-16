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
    , 0 as OCTETS, 0 as OCTETS_ADDON, 0 as MB_ADDON
   
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
show columns from rcbill.clientcontractipusage;

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

ALTER TABLE rcbill.clientcontractipusage ADD COLUMN OCTETS bigint(25);
ALTER TABLE rcbill.clientcontractipusage ADD COLUMN OCTETS_ADDON bigint(25);
ALTER TABLE rcbill.clientcontractipusage ADD COLUMN MB_ADDON decimal(65,4);


####update all null packages
-- select * from rcbill.clientcontractipusage where package is null;
set sql_safe_updates=0;

update rcbill.clientcontractipusage
set Package=ifnull(rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, USAGEDATE),rcbill_my.GetPackageFromSnapshot(CLIENTCODE, CONTRACTCODE))
where package is null;

### 21/09/2022
##### update all negative octets and MB_TOTAL and move them to MB_ADDON

### first make a copy
-- create table rcbill.clientcontractipusage1 LIKE rcbill.clientcontractipusage;
-- INSERT INTO rcbill.clientcontractipusage1 SELECT * FROM rcbill.clientcontractipusage;

update rcbill.clientcontractipusage set MB_ADDON=MB_TOTAL where MB_TOTAL<0;
update rcbill.clientcontractipusage set MB_TOTAL=0 where MB_TOTAL<0;
update rcbill.clientcontractipusage set MB_DL=0 where MB_DL<0;

-- select * from rcbill.clientcontractipusage where clientcode='I.000011750' order by usagedate desc limit 100;

*/
-- create index idxcciu6 on rcbill.clientcontractipusage(USAGEDATE);


select count(*) as clientcontractipusage_afterinsert from rcbill.clientcontractipusage;

set sql_safe_updates=0;

select 'updating null packages' as info;

update rcbill.clientcontractipusage
set Package=ifnull(rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, USAGEDATE),rcbill_my.GetPackageFromSnapshot(CLIENTCODE, CONTRACTCODE))
where package is null;

select 'moving and updating addon information' as info;
update rcbill.clientcontractipusage set MB_ADDON=MB_TOTAL where MB_TOTAL<0;
update rcbill.clientcontractipusage set MB_TOTAL=0 where MB_TOTAL<0;
update rcbill.clientcontractipusage set MB_DL=0 where MB_DL<0;


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
-- select * from rcbill.clientcontractipmonth where processedclientip='154.70.178.123' limit 1000;
-- select * from rcbill.clientcontractipusage where clientcode='I.000011750' order by usagedate desc limit 1000;


drop table if exists rcbill_my.rep_dailypackageusage2023;

create table rcbill_my.rep_dailypackageusage2023(index idxrdpu1(usagedate), index idxrdpu2(package)) as
(
	select USAGEDATE, upper(PACKAGE) as PACKAGE, upper(TRAFFICTYPE) as TRAFFICTYPE
	, count(distinct clientcode) as CLIENTS
	, count(distinct contractcode) as CONTRACTS
	, count(*) as RECORDS
	, round(sum(MB_UL),2) as MB_UL, round(sum(MB_DL),2) as MB_DL, round(sum(MB_TOTAL),2) as MB_TOTAL 
	, round((sum(MB_UL)/1024),2) as GB_UL, round((sum(MB_DL)/1024),2) as GB_DL, round((sum(MB_TOTAL)/1024),2) as GB_TOTAL 

	from rcbill.clientcontractipusage where year(USAGEDATE)=2023
	group by 1,2,3
	order by 1 desc

)
;

select count(*) as rep_dailypackageusage2023 from rcbill_my.rep_dailypackageusage2023;


set sql_safe_updates=0;

## deleting the three dates where there was no data

-- delete from rcbill_my.rep_dailypackageusage2022 where USAGEDATE='2022-04-30';
-- delete from rcbill_my.rep_dailypackageusage2022 where USAGEDATE='2022-05-01';
-- delete from rcbill_my.rep_dailypackageusage2022 where USAGEDATE='2022-05-02';

-- select count(*) as rep_dailypackageusage2021 from rcbill_my.rep_dailypackageusage2021;

######################################################################

set sql_safe_updates=0;

## THIS TABLE HAS BEEN CREATED IN DAILY-SCRIPT-USAGESTATS.SQL

### DELETE CURRENT YEARS RECORDS
delete from rcbill_my.rep_dailypackageusage where YEAR(USAGEDATE)=year(NOW());

## INSERT CURRENT YEARS RECORDS
insert into rcbill_my.rep_dailypackageusage
(
		select a.USAGEDATE, a.PACKAGE

		, count(distinct CLIENTCODE) as CLIENTS
		, count(distinct CONTRACTCODE) as CONTRACTS
		, count(*) as RECORDS

		##MB TOTAL
		, sum(MB_UL_DEFAULT) as MB_UL_DEFAULT
		, sum(MB_DL_DEFAULT) as MB_DL_DEFAULT
		, sum(MB_TOTAL_DEFAULT) as MB_TOTAL_DEFAULT

		, sum(MB_UL_FREE) as MB_UL_FREE
		, sum(MB_DL_FREE) as MB_DL_FREE
		, sum(MB_TOTAL_FREE) as MB_TOTAL_FREE

		, sum(MB_UL_LOCAL) as MB_UL_LOCAL
		, sum(MB_DL_LOCAL) as MB_DL_LOCAL
		, sum(MB_TOTAL_LOCAL) as MB_TOTAL_LOCAL

		, sum(MB_UL_DEFAULTEX) as MB_UL_DEFAULTEX
		, sum(MB_DL_DEFAULTEX) as MB_DL_DEFAULTEX
		, sum(MB_TOTAL_DEFAULTEX) as MB_TOTAL_DEFAULTEX

		, sum(MB_UL_TEMP) as MB_UL_TEMP
		, sum(MB_DL_TEMP) as MB_DL_TEMP
		, sum(MB_TOTAL_TEMP) as MB_TOTAL_TEMP

		, sum(MB_ADDON) as MB_ADDON

		##GB TOTAL	
		, ifnull(round((sum(MB_UL_DEFAULT))/1024,2),0) as GB_UL_DEFAULT
		, ifnull(round((sum(MB_DL_DEFAULT))/1024,2),0) as GB_DL_DEFAULT
		, ifnull(round((sum(MB_TOTAL_DEFAULT))/1024,2),0) as GB_TOTAL_DEFAULT

		, ifnull(round((sum(MB_UL_FREE))/1024,2),0) as GB_UL_FREE
		, ifnull(round((sum(MB_DL_FREE))/1024,2),0) as GB_DL_FREE
		, ifnull(round((sum(MB_TOTAL_FREE))/1024,2),0) as GB_TOTAL_FREE

		, ifnull(round((sum(MB_UL_LOCAL))/1024,2),0) as GB_UL_LOCAL
		, ifnull(round((sum(MB_DL_LOCAL))/1024,2),0) as GB_DL_LOCAL
		, ifnull(round((sum(MB_TOTAL_LOCAL))/1024,2),0) as GB_TOTAL_LOCAL

		, ifnull(round((sum(MB_UL_DEFAULTEX))/1024,2),0) as GB_UL_DEFAULTEX
		, ifnull(round((sum(MB_DL_DEFAULTEX))/1024,2),0) as GB_DL_DEFAULTEX
		, ifnull(round((sum(MB_TOTAL_DEFAULTEX))/1024,2),0) as GB_TOTAL_DEFAULTEX

		, ifnull(round((sum(MB_UL_TEMP))/1024,2),0) as GB_UL_TEMP
		, ifnull(round((sum(MB_DL_TEMP))/1024,2),0) as GB_DL_TEMP
		, ifnull(round((sum(MB_TOTAL_TEMP))/1024,2),0) as GB_TOTAL_TEMP

		, ifnull(round((sum(MB_ADDON))/1024,2),0) as GB_ADDON



		from 
		(
			select USAGEDATE, clientcode, contractcode, upper(c.PACKAGE) as PACKAGE
					
					-- , count(distinct clientcode) as CLIENTS
					-- , count(distinct contractcode) as CONTRACTS
					-- , count(*) as RECORDS
					/*
						Default
						Free
						Local
						Default-Ex
						temporary_speed
					*/
					, case when upper(TRAFFICTYPE)='DEFAULT' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_DEFAULT
					, case when upper(TRAFFICTYPE)='DEFAULT' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_DEFAULT
					, case when upper(TRAFFICTYPE)='DEFAULT' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_DEFAULT

					, case when upper(TRAFFICTYPE)='FREE' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_FREE
					, case when upper(TRAFFICTYPE)='FREE' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_FREE
					, case when upper(TRAFFICTYPE)='FREE' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_FREE

					, case when upper(TRAFFICTYPE)='LOCAL' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_LOCAL
					, case when upper(TRAFFICTYPE)='LOCAL' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_LOCAL
					, case when upper(TRAFFICTYPE)='LOCAL' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_LOCAL

					, case when upper(TRAFFICTYPE)='DEFAULT-EX' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_DEFAULTEX
					, case when upper(TRAFFICTYPE)='DEFAULT-EX' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_DEFAULTEX
					, case when upper(TRAFFICTYPE)='DEFAULT-EX' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_DEFAULTEX

					, case when upper(TRAFFICTYPE)='TEMPORARY_SPEED' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_TEMP
					, case when upper(TRAFFICTYPE)='TEMPORARY_SPEED' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_TEMP
					, case when upper(TRAFFICTYPE)='TEMPORARY_SPEED' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_TEMP


					, ifnull(round(sum(MB_ADDON),2),0) as MB_ADDON

					-- , upper(TRAFFICTYPE) as TRAFFICTYPE
					-- , round(sum(MB_UL),2) as MB_UL, round(sum(MB_DL),2) as MB_DL, round(sum(MB_TOTAL),2) as MB_TOTAL 
					-- , round((sum(MB_UL)/1024),2) as GB_UL, round((sum(MB_DL)/1024),2) as GB_DL, round((sum(MB_TOTAL)/1024),2) as GB_TOTAL 

				from rcbill.clientcontractipusage c where year(USAGEDATE)=year(now())
				group by c.USAGEDATE, c.CLIENTCODE, c.CONTRACTCODE, c.PACKAGE , c.TRAFFICTYPE
				order by 1 desc
		) a 
		group by a.USAGEDATE,a.PACKAGE
		order by 1 desc
	
		
);


select count(*) as rep_dailypackageusage from rcbill_my.rep_dailypackageusage;

-- select * from rcbill_my.rep_dailypackageusage order by usagedate desc limit 1000;


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


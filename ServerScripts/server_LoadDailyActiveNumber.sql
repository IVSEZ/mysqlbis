use rcbill_my;
SET @@SESSION.sql_mode='ALLOW_INVALID_DATES';
SET SQL_SAFE_UPDATES = 0;

-- 	SET @rundate='2017-12-01'; SET @perioddate=str_to_date('2017-12-01','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-01;2017-12-01.csv'
-- 	SET @rundate='2017-12-02'; SET @perioddate=str_to_date('2017-12-02','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-02;2017-12-02.csv'
-- 	SET @rundate='2017-12-03'; SET @perioddate=str_to_date('2017-12-03','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-03;2017-12-03.csv'
-- 	SET @rundate='2017-12-04'; SET @perioddate=str_to_date('2017-12-04','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-04;2017-12-04.csv'
-- 	SET @rundate='2017-12-05'; SET @perioddate=str_to_date('2017-12-05','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-05;2017-12-05.csv'
-- 	SET @rundate='2017-12-06'; SET @perioddate=str_to_date('2017-12-06','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-06;2017-12-06.csv'
-- 	SET @rundate='2017-12-07'; SET @perioddate=str_to_date('2017-12-07','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-07;2017-12-07.csv'
-- 	SET @rundate='2017-12-08'; SET @perioddate=str_to_date('2017-12-08','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-08;2017-12-08.csv'
-- 	SET @rundate='2017-12-09'; SET @perioddate=str_to_date('2017-12-09','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-09;2017-12-09.csv'
-- 	SET @rundate='2017-12-10'; SET @perioddate=str_to_date('2017-12-10','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-10;2017-12-10.csv'
-- 	SET @rundate='2017-12-11'; SET @perioddate=str_to_date('2017-12-11','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-11;2017-12-11.csv'
-- 	SET @rundate='2017-12-12'; SET @perioddate=str_to_date('2017-12-12','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-12;2017-12-12.csv'
-- 	SET @rundate='2017-12-13'; SET @perioddate=str_to_date('2017-12-13','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-13;2017-12-13.csv'
-- 	SET @rundate='2017-12-14'; SET @perioddate=str_to_date('2017-12-14','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-14;2017-12-14.csv'
-- 	SET @rundate='2017-12-15'; SET @perioddate=str_to_date('2017-12-15','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-15;2017-12-15.csv'
-- 	SET @rundate='2017-12-16'; SET @perioddate=str_to_date('2017-12-16','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-16;2017-12-16.csv'
-- 	SET @rundate='2017-12-17'; SET @perioddate=str_to_date('2017-12-17','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-17;2017-12-17.csv'
-- 	SET @rundate='2017-12-18'; SET @perioddate=str_to_date('2017-12-18','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-18;2017-12-18.csv'
-- 	SET @rundate='2017-12-19'; SET @perioddate=str_to_date('2017-12-19','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-19;2017-12-19.csv'
-- 	SET @rundate='2017-12-20'; SET @perioddate=str_to_date('2017-12-20','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-20;2017-12-20.csv'
-- 	SET @rundate='2017-12-21'; SET @perioddate=str_to_date('2017-12-21','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-21;2017-12-21.csv'
-- 	SET @rundate='2017-12-22'; SET @perioddate=str_to_date('2017-12-22','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-22;2017-12-22.csv'
-- 	SET @rundate='2017-12-23'; SET @perioddate=str_to_date('2017-12-23','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-23;2017-12-23.csv'
-- 	SET @rundate='2017-12-24'; SET @perioddate=str_to_date('2017-12-24','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-24;2017-12-24.csv'
-- 	SET @rundate='2017-12-25'; SET @perioddate=str_to_date('2017-12-25','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-25;2017-12-25.csv'
 	SET @rundate='2017-12-26'; SET @perioddate=str_to_date('2017-12-26','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-26;2017-12-26.csv'
-- 	SET @rundate='2017-12-27'; SET @perioddate=str_to_date('2017-12-27','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-27;2017-12-27.csv'
-- 	SET @rundate='2017-12-28'; SET @perioddate=str_to_date('2017-12-28','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-28;2017-12-28.csv'
-- 	SET @rundate='2017-12-29'; SET @perioddate=str_to_date('2017-12-29','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-29;2017-12-29.csv'
-- 	SET @rundate='2017-12-30'; SET @perioddate=str_to_date('2017-12-30','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-30;2017-12-30.csv'
-- 	SET @rundate='2017-12-31'; SET @perioddate=str_to_date('2017-12-31','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201712/2017-12-31;2017-12-31.csv'


REPLACE INTO TABLE `rcbill_my`.`dailyactivenumber` CHARACTER SET LATIN1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n'

-- INTO TABLE rcbill_my.dailyactivenumber 
-- FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@activenumberid,
@clid,
@cid,
@contract,
@contractdate,
@validity,
@fromdate,
@todate,
@state,
@lastaction,
@lastchange,
@count,
@devicescount,
@promotion,
@clientcode,
@client,
@clientclassold,
@representative,
@phones,
@correspondenceaddress,
@service,
@servicetype,
@price,
@previousservicetype,
@regionallevel3,
@regionallevel2,
@regionallevel1,
@region
) 
set 
ACTIVENUMBERID=@activenumberid,							
PERIOD=@perioddate,							
periodday	=	(select	extract(day	from	period)),		
periodmth	=	(select	extract(month	from	period)),		
periodyear	=	(select	extract(year	from	period)),		
weekday=(select	dayname(period)),						
mthname=(select	monthname(period)),						
CLIENTID=@clid,							
CONTRACTID=@cid,							
CLIENTCODE=@clientcode,							
CONTRACTCODE=@contract,							
 CONTRACTDATE=str_to_date(@contractdate,'%m/%d/%Y %H:%i'),		
-- CONTRACTDATE=str_to_date(trim(@contractdate),'%d-%m-%y %H:%i'),							
VALIDITY=@validity,							
 CONTRACTSTARTDATE=str_to_date(@fromdate,'%m/%d/%Y %H:%i'),	
-- CONTRACTSTARTDATE=str_to_date(trim(@fromdate),'%d-%m-%y %H:%i'),							
 CONTRACTENDDATE=str_to_date(@todate,'%m/%d/%Y %H:%i'),	
-- CONTRACTENDDATE=str_to_date(trim(@todate),'%d-%m-%y %H:%i'),							
CONTRACTSTATE=@state,							
LASTACTION=@lastaction,							
 LASTCHANGE=str_to_date(@lastchange,'%m/%d/%Y %H:%i'),
-- LASTCHANGE=str_to_date(trim(@lastchange),'%d-%m-%y %H:%i'),							
ACTIVECOUNT=@count,							
DEVICESCOUNT=@devicescount,							
PROMOTION=@promotion,							
CLIENTNAME=@client,	
REPRESENTATIVE=@representative,							
PHONE=@phones,							
ADDRESS=@correspondenceaddress,							
SERVICE=@service,							
SERVICECATEGORY=(select servicecategory from rcbill_my.lkpbaseservice where service=@service),							
SERVICESUBCATEGORY=(select servicesubcategory from rcbill_my.lkpbaseservice where service=@service),							
							
							
-- SERVICETYPE=@servicetype,	

-- servicetypeold = @servicetypeold,
-- servicetypeold1 = (select servicenewtype from rcbill_my.lkpservicetype where servicetype=@servicetypeold),
SERVICETYPE = (select GetServiceType(@servicetypeold,(select servicenewtype from rcbill_my.lkpservicetype where servicetype=@servicetype),service)),
-- SERVICETYPE=(select servicenewtype from rcbill_my.lkpservicetype where servicetype=@servicetype),
PREVIOUSSERVICETYPE=(select GetServiceType(@servicetypeold,(select servicenewtype from rcbill_my.lkpservicetype where servicetype=@previousservicetype),service)),
-- PREVIOUSSERVICETYPE=(select servicenewtype from rcbill_my.lkpservicetype where servicetype=@previousservicetype),

						
CLIENTCLASSOLD=@clientclassold,					
CLIENTCLASS=@clientclass,							
CLIENTTYPE=@clienttype,							
CLIENTCLASS	=	(select	NewClientClass	from	rcbill_my.lkpclienttype	where	origclientclass=@clientclassold),
CLIENTTYPE	=	(select	clienttype	from	rcbill_my.lkpclienttype	where	origclientclass=@clientclassold),
							
							
PRICE=@price,							
REGIONALLEVEL1=@regionallevel1,							
REGIONALLEVEL2=@regionallevel2,							
REGIONALLEVEL3=@regionallevel3,							
REGION=@region,							

REPORTED = (select reported from rcbill_my.lkpreported where servicenewtype=servicetype)

;

/*
DROP INDEX `IDXdan1` ON rcbill_my.dailyactivenumber;
CREATE INDEX IDXdan1
ON rcbill_my.dailyactivenumber (period);
*/

/*
DROP INDEX `IDXdan2` ON rcbill_my.dailyactivenumber;
CREATE INDEX IDXdan2
ON rcbill_my.dailyactivenumber (clientcode);

DROP INDEX `IDXdan3` ON rcbill_my.dailyactivenumber;
CREATE INDEX IDXdan3
ON rcbill_my.dailyactivenumber (contractcode);
*/
/*
select period,  count(*) as rowcount, sum(activecount) as activecount from rcbill_my.dailyactivenumber
where reported='Y'
group by period
order by period desc
;

delete from rcbill_my.dailyactivenumber where period in ('2017-07-26');
--,'2017-05-20');
*/
/*


select period, reported, servicecategory, servicetype, sum(activecount), sum(devicescount) from dailyactivenumber where period=@rundate
group by period, reported, servicecategory, servicetype
;
*/

select * from rcbill_my.dailyactivenumber where period=@rundate and reported='Y';

-- select * from rcbill_my.dailyactivenumber where clientcode='I.000011750';

/*
select * from rcbill_my.dailyactivenumber where period=@rundate and devicescount>1
and clienttype='Residential'
and servicecategory<>'Voice' and servicetype<>'Device'
;
*/


##Client and Active Contracts per location
drop table if exists rcbill_my.activeccl; 

create table rcbill_my.activeccl as 
(
select 
a.period, a.periodday, a.periodmth, a.periodyear, a.clientcode, a.clientname, a.clientclass, a.clienttype, a.representative
, b.clientaddress, b.cl_location, b.cl_area 
, d.areaname as cl_areaname, d.latitude as cl_latitude, d.longitude as cl_longitude
, a.contractcode
, c.contractaddress, c.con_location , c.con_area
, e.areaname as con_areaname, e.latitude as con_latitude, e.longitude as con_longitude
, a.SERVICE
, a.servicecategory
, GetServiceCategory2(a.service) as servicecategory2
, a.servicesubcategory, a.servicetype as package 
, a.price, a.region, a.ACTIVECOUNT, a.DEVICESCOUNT, a.REPORTED
, rcbill_my.GetNetwork(@rundate, a.contractcode) as Network
from
rcbill_my.dailyactivenumber a
left join 
(
			SELECT clientcode, clientaddress, min(clientlocation) as cl_location, min(ClientArea) as cl_area
            FROM    rcbill.rcb_clientaddress
            GROUP BY clientcode
            order by clientcode
) b
on
a.clientcode=b.clientcode
left join
(
			SELECT contractcode, contractaddress, min(contractlocation) as con_location, min(ContractArea) as con_area
            FROM    rcbill.rcb_contractaddress
            GROUP BY ContractCode
            order by ContractCode
) c
on 
a.contractcode=c.contractcode
left join
(
		select distinct x.settlementname, x.areaname, y.latitude, y.longitude,
		y.geoname, y.featureclass,y.featurecode
		from 
		rcbill.rcb_address x 
		left join
		rcbill.geoname_sc y
		on
		-- x.settlementname=y.geoname
        (concat(x.settlementname," ",x.areaname)=y.geoname or x.settlementname=y.geoname)
		and 
		(y.featureclass in ('A') or y.featurecode in ('ISL','PPL','PPLC'))
		where
		x.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
		group by x.settlementname, x.areaname
		order by x.SETTLEMENTNAME
) d
on (b.cl_location=d.settlementname and b.cl_area=d.areaname)

left join
(
		select distinct x.settlementname, x.areaname, y.latitude, y.longitude,
		y.geoname, y.featureclass,y.featurecode
		from 
		rcbill.rcb_address x 
		left join
		rcbill.geoname_sc y
		on
		-- x.settlementname=y.geoname
        (concat(x.settlementname," ",x.areaname)=y.geoname or x.settlementname=y.geoname)
		and 
		(y.featureclass in ('A') or y.featurecode in ('ISL','PPL','PPLC'))
		where
		x.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
		group by x.settlementname, x.areaname
		order by x.SETTLEMENTNAME
) e
on (c.con_location=e.settlementname and c.con_area=e.areaname)

where a.period=@rundate and a.reported='Y'
)
;

-- CREATE INDEXES
CREATE INDEX IDXaccl1
ON rcbill_my.activeccl (clientcode);

CREATE INDEX IDXaccl2
ON rcbill_my.activeccl (ClientName);

CREATE INDEX IDXaccl3
ON rcbill_my.activeccl (contractcode);

CREATE INDEX IDXaccl4
ON rcbill_my.activeccl (package);

CREATE INDEX IDXaccl5
ON rcbill_my.activeccl (cl_latitude);

CREATE INDEX IDXaccl6
ON rcbill_my.activeccl (cl_longitude);


select count(*) from rcbill_my.customercontractactivity;
#now insert the daily activity table into the customer contract activity table. 
insert into rcbill_my.customercontractactivity
(
select * from rcbill_my.activeccl
)
;

-- delete from rcbill_my.customercontractactivity where period=@rundate;

select count(*) from rcbill_my.customercontractactivity;

-- select * from rcbill_my.customercontractactivity where period=@rundate and clientcode='I.000011750';

select period, count(*) from rcbill_my.customercontractactivity group by period order by period desc;

-- CREATE A CUSTOMER CONTRACT SNAPSHOT TABLE
drop table if exists rcbill_my.customercontractsnapshot;
-- duration 125.046 sec

create table rcbill_my.customercontractsnapshot as
(   

	select a.*
    -- ,  rcbill_my.GetActiveDaysForContract(a.clientcode,a.contractcode,a.package) as ActiveDaysForContract
    -- ,  rcbill_my.GetActiveDaysForClient(a.clientcode) as ActiveDaysForClient 
    from 
    (
		select distinct clientcode, clientname, clientclass, contractcode,servicecategory, package, region, network
		, min(period) as firstcontractdate, max(period) as lastcontractdate 
		-- , (sum(ACTIVECOUNT)/count(period)) as activecount
		, (datediff(max(period),min(period))+1) as DurationForContract
        , count(*) as ActiveDaysForContract
		-- , count(distinct a.period) as activedays 
		-- , rcbill_my.GetActiveDaysForContract(a.clientcode,a.contractcode,a.package) as ActiveDaysForContract
        -- , DEVICESCOUNT
		,
        case when servicesubcategory='ADDON' then 'ADDON'
			else 'STANDALONE'
        end as `PackageType`    
        ,
		case when max(period) = @rundate then 'Active' 
				else 'Not Active'
		end as `CurrentStatus`    
		
		from rcbill_my.customercontractactivity
		group by clientcode, clientname, clientclass, contractcode, package, region, network 
		order by clientcode, firstcontractdate
	) a

);

select * from rcbill_my.customercontractsnapshot;

/*
select clientcode, clientname, clienttype, clientaddress, cl_location, cl_latitude, cl_longitude from rcbill_my.activeccl
where 
cl_latitude=-4.68750 
and
cl_longitude=55.51667
; 
*/


-- select * from rcbill_my.activeccl where clientname like ('%bridget kelly%');
-- select * from rcbill_my.activeccl where cl_area='mahe' and cl_location like ('%grand%');
-- select * from rcbill_my.activeccl where cl_area='praslin' and cl_location like ('%baie%');


-- LOCATIONS FOR MAP
-- client summary
drop table if exists rcbill_my.activeccl_clsum;
create table rcbill_my.activeccl_clsum
as
(
	select period, clientclass, clienttype
	, cl_area
	, cl_location,cl_latitude,cl_longitude,
	count(distinct clientcode) as accounts
	from 
	rcbill_my.activeccl 
	group by 
	period, clientclass, clienttype 
	,cl_area 
	, cl_location,cl_latitude,cl_longitude
)
;

-- contract summary 
drop table if exists rcbill_my.activeccl_consum;
create table rcbill_my.activeccl_consum
as
(
select period, clientclass, clienttype, con_area, con_location, con_latitude, con_longitude
,servicecategory, servicecategory2, servicesubcategory, package, network
,
count(distinct contractcode) as contracts,
sum(activecount) as activesubs
from 
rcbill_my.activeccl 
group by 
period, clientclass, clienttype, con_area, con_location, con_latitude, con_longitude
,servicecategory, servicecategory2, servicesubcategory, package, network
)
;


select * from rcbill_my.activeccl_clsum;
select * from rcbill_my.activeccl_consum;
/*
select period, cl_location, cl_latitude, cl_longitude, CLIENTTYPE, sum(accounts) as accounts
from rcbill_my.activeccl_clsum
group by period,cl_location, cl_latitude, cl_longitude, CLIENTTYPE
order by cl_location
;


select cl_latitude, cl_longitude, sum(accounts) as accounts
from rcbill_my.activeccl_clsum
group by cl_latitude, cl_longitude
order by cl_latitude
;
*/

/*
select 
-- distinct 
a.period, 
-- a.clientclass, 
a.clienttype, 
-- a.servicecategory, 
-- a.servicecategory2,
-- a.network, 
-- a.package, 
a.cl_location, a.cl_latitude, a.cl_longitude,
-- count(a.clientcode) as clients, 
count(distinct a.clientcode) as distclient,
count(distinct a.CONTRACTCODE) as distcontracts,
sum(activecount) as activesubs
from 
rcbill_my.activeccl a
-- where servicesubcategory not in ('ADDON')
group by 
a.period, 
-- a.clientclass, 
a.clienttype, 
-- a.servicecategory, servicecategory2, 
-- a.network, 
-- a.package, 
a.cl_location, a.cl_latitude, a.cl_longitude
;
*/

-- select * from rcbill_my.activeccl where cl_location='ANSE AUX PINS' and servicesubcategory='ADDON';

/*
(


select 
a.period, a.contractcode, a.clientcode, a.clientname, a.clientclass, a.clienttype, a.representative, a.servicecategory, 
GetServiceCategory2(a.service) as servicecategory2,
a.servicesubcategory, a.servicetype as package, 
a.price, a.region, a.ACTIVECOUNT, a.DEVICESCOUNT, a.REPORTED
 , b.clientaddress, b.cl_location, b.cl_area 
 , d.areaname as cl_areaname, d.latitude as cl_latitude, d.longitude as cl_longitude
, c.contractaddress, c.con_location , c.con_area
, e.areaname as con_areaname, e.latitude as con_latidue, e.longitude as con_longitude

from
rcbill_my.dailyactivenumber a
left join 
(
			SELECT clientcode, clientaddress, min(clientlocation) as cl_location, min(ClientArea) as cl_area
            FROM    rcbill.rcb_clientaddress
            GROUP BY clientcode
            order by clientcode
) b
on
a.clientcode=b.clientcode
left join
(
			SELECT contractcode, contractaddress, min(contractlocation) as con_location, min(ContractArea) as con_area
            FROM    rcbill.rcb_contractaddress
            GROUP BY ContractCode
            order by ContractCode
) c
on 
a.contractcode=c.contractcode
left join
(
		select distinct x.settlementname, x.areaname, y.latitude, y.longitude,
		y.geoname, y.featureclass,y.featurecode
		from 
		rcbill.rcb_address x 
		left join
		rcbill.geoname_sc y
		on
		x.settlementname=y.geoname
		and 
		(y.featureclass in ('A') or y.featurecode in ('ISL','PPL','PPLC'))
		where
		x.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
		group by x.settlementname, x.areaname
		order by x.SETTLEMENTNAME
) d
on (b.cl_location=d.settlementname and b.cl_area=d.areaname)

left join
(
		select distinct x.settlementname, x.areaname, y.latitude, y.longitude,
		y.geoname, y.featureclass,y.featurecode
		from 
		rcbill.rcb_address x 
		left join
		rcbill.geoname_sc y
		on
		x.settlementname=y.geoname
		and 
		(y.featureclass in ('A') or y.featurecode in ('ISL','PPL','PPLC'))
		where
		x.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
		group by x.settlementname, x.areaname
		order by x.SETTLEMENTNAME
) e
on (c.con_location=e.settlementname and c.con_area=e.areaname)

where a.period=@rundate and a.reported='Y'
) a

group by 
a.period, 
-- a.clientclass, 
a.clienttype, 
a.servicecategory, servicecategory2, a.servicesubcategory, a.package, 
a.cl_location, a.cl_latitude, a.cl_longitude
;
*/



##Servicetype Group per location
/*
select distinct
a.period, a.clientclass, a.clienttype, a.servicecategory, a.servicesubcategory, a.servicetype, a.region
 , b.ClientLocation 
, c.ContractLocation 
, sum(activecount) as activecount
, sum(DEVICESCOUNT) as devicescount
, count(*) as contractcount
from
rcbill_my.dailyactivenumber a

left join 
rcbill.rcb_clientaddress b
on
a.clientcode=b.clientcode

left join
rcbill.rcb_contractaddress c
on 
a.contractcode=c.contractcode


where a.period=@rundate and reported='Y'

group by 
a.period, a.clientclass, a.clienttype, a.servicecategory, a.servicesubcategory, a.servicetype, a.region
 , b.ClientLocation 
, c.ContractLocation 
;
*/

##RETENTION CUSTOMER REPORT
drop table if exists rcbill_my.retentioncustomeractivity;

create table rcbill_my.retentioncustomeractivity as
(


select distinct
@rundate as ReportDate,
count(distinct a.contractcode) as ContractCount,
count(distinct a.period) as DaysActive,
min(a.period) as FirstActiveDate,
max(a.period) as LastActiveDate,
a.clientid as ClientId,
a.clientcode as ClientCode,
a.clientclass as ClientClass, 
a.clienttype as ClientType,
/*
b.firm as ClientName,
b.mphone as ClientPhone, 
b.memail as ClientEmail,
b.passno as ClientPassport,
b.Danno as ClientNIN,
b.moladdress as ClientAddress,
b.molregistrationaddress as RegistrationAddress,
*/

b.ClientName,
b.ClientPhone, 
b.ClientEmail,
b.ClientPassport,
b.ClientNIN,
b.ClientAddress,
b.RegistrationAddress,

now() as InsertedOn
/*
a.devicescount,
a.servicecategory,
a.servicesubcategory,
a.servicetype,
a.region,
a.address as ContractAddress,

count(a.period) as daysactive,
max(a.period) as lastactivedate,
@rundate as ReportDate,
now() as InsertedOn,

rcbill_my.GetIsContractActiveOnDate(a.CONTRACTCODE,@rundate) as IsContractActiveOnReportDate
*/

from 

rcbill_my.dailyactivenumber a 

inner join
(
	select id,
	firm as ClientName,
	mphone as ClientPhone, 
	memail as ClientEmail,
	passno as ClientPassport,
	Danno as ClientNIN,
	moladdress as ClientAddress,
	molregistrationaddress as RegistrationAddress
	from rcbill.rcb_tclients
	where 
	firm like '%retention%'
) b
-- rcbill.rcb_tclients b

on a.clientid=b.id

group by
a.clientid,
a.clientcode,
a.clientclass, a.clienttype,
b.ClientName,
b.ClientPhone, 
b.ClientEmail,
b.ClientPassport,
b.ClientNIN,
b.ClientAddress,
b.RegistrationAddress
/*
a.contractid, 
a.contractcode,
a.activecount,
a.devicescount,
a.servicecategory,
a.servicesubcategory,
a.servicetype,
a.region,
a.address
*/
order by max(a.period) asc


)
;

select * from rcbill_my.retentioncustomeractivity;



-- select * from dailyactivenumber where servicetype='Crimson' and period=@rundate order by activenumberid;
/*
select period, contractcode, clientcode, clientname, contractstate, lastaction, servicetype, previousservicetype, clientclass
from dailyactivenumber
where 
-- period > '2017-03-24'
-- and 
servicecategory='Internet'
-- (servicetype='Crimson' or previousservicetype='Crimson') 
order by clientcode, period, clientname; 
*/
-- select * from dailyactivenumber where activenumberid like '%3799864%';
-- select * from dailyactivenumber where activenumberid like '%3799865%';
-- select * from dailyactivenumber where activenumberid like '%3799863%';
/*
select distinct period, count(*) from dailyactivenumber group by period;
SELECT * from dailyactivenumber where period in ('2017-07-05') and address like '%Eden island%';
SELECT distinct clientname, address from dailyactivenumber where period in ('2017-07-05') and address like '%Eden island%' order by clientname;

SELECT clientclass, clienttype, reported, count(*), sum(activecount) as activecount, sum(devicescount) as devicescount from dailyactivenumber where period in ('2017-04-02')
and servicetype='Crimson'
group by 
clientclass, clienttype, reported
;

delete from dailyactivenumber where period in ('2017-03-15','2017-03-16','2017-03-17');
delete from dailyactivenumber where period in ('2017-03-20');
delete from dailyactivenumber where period in ('2017-06-14','2017-06-15');
select reported, servicetype,  sum(activecount) as active from dailyactivenumber  where period in ('2017-03-15')
group by reported,  servicetype
;
select reported, servicetype,  sum(activecount) as active from dailyactivenumber  where period in ('2016-08-31')
group by reported,  servicetype
;

select reported, SERVICECATEGORY, SERVICESUBCATEGORY, sum(activecount) as active from dailyactivenumber  where period in ('2016-08-31')
group by reported,  SERVICECATEGORY, SERVICESUBCATEGORY
;

select reported,  sum(activecount) as active from dailyactivenumber  where period in ('2016-06-03')
group by reported
;

select reported,  sum(activecount) as active from dailyactivenumber  where period in ('2017-03-15')
group by reported
;
select reported,  sum(activecount) as active from dailyactivenumber  where period in ('2017-03-16')
group by reported
;
select reported,  sum(activecount) as active from dailyactivenumber  where period in ('2017-03-17')
group by reported
;

select * from dailyactivenumber  where period in ('2016-03-31');
*/

-- select * from dailyactivenumber where clientname='LOUINA DIDON';
-- select count(*) from dailyactivenumber;
-- select sum(activecount) as totalactivecount from dailyactivenumber where periodmth=08 and periodyear=2016;

-- select distinct servicetype from dailyactivenumber where reported is null;
/*
select count(*) from dailyactivenumber;

select period,  count(*) as rowcount, sum(activecount) as activecount from dailyactivenumber
where reported='Y'
group by period
order by period desc
;
*/
/*
select distinct period, CONTRACTSTATE, count(*) as STATECOUNT from dailyactivenumber
group by period, contractstate
order by period
;

truncate table dailyactivenumber;

select * from dailyactivenumber;
select * from dailyactivenumber where clientcode='I.000011354' and contractcode='I.000196110' order by period, contractcode;
*/
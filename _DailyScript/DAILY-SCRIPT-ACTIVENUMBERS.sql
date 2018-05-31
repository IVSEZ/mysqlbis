use rcbill_my;

## change dates on csv 1 file
## uncomment line to run daily active number
## change date in call sp_ActiveNumber(

-- use rcbill_my;
 SET @rundate='2018-05-30';
-- SET @rundate='2017-12-26';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/activenumber/DailySubscriptionStats-05052018-06052018.csv'

 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/activenumber/DailySubscriptionStats-30052018.csv'

INTO TABLE rcbill_my.activenumber 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@periodorig,
@baseservice,
@service,
@servicetypeold,
@clientclassold,
@regionallevel3,
@regionallevel2,
@regionallevel1,
@regionold,
@distributor,
@promotion,
@validity,
@open,
@new,
@newconverted,
@renew,
@closed,
@closednonpayment,
@suspended,
@closedconverted,
@closedother,
@disconnected,
@disconnectedtotal,
@disconnectedall,
@connected,
@connectedtotal,
@pendingorders
) 
set 
activenumberid=null,
periodorig = @periodorig,
period = (select substring_index(@periodorig,';',1)),
periodday = (select extract(day from period)),
periodmth = (select extract(month from period)),
periodyear = (select extract(year from period)),
weekday=(select dayname(period)),
mthname=(select monthname(period)),
baseservice = @baseservice,
service = @service,
servicecategory = (select servicecategory from rcbill_my.lkpbaseservice where service=@service),
servicesubcategory = (select servicesubcategory from rcbill_my.lkpbaseservice where service=@service),

servicetypeold = @servicetypeold,
servicetypeold1 = (select servicenewtype from rcbill_my.lkpservicetype where servicetype=@servicetypeold),
servicetype = (select GetServiceType(servicetypeold,servicetypeold1,service)),

clientclassold = @clientclassold,
clientclass = (select NewClientClass from rcbill_my.lkpclienttype where origclientclass=@clientclassold),
clienttype = (select clienttype from rcbill_my.lkpclienttype where origclientclass=@clientclassold),

regionallevel1 = @regionallevel1,
regionallevel2 = @regionallevel2,
regionallevel3 = @regionallevel3,
regionold = @regionold,
region = (select newregion from rcbill_my.lkpregion where origregion=@regionold),

distributor = @distributor,
promotion = @promotion,
validity = @validity,

open = @open,
new = @new,
newconverted = @newconverted,
renew = @renew,
closed = @closed,
closednonpayment = @closednonpayment,
suspended = @suspended,
closedconverted = @closedconverted,
closedother = @closedother,
disconnected = @disconnected,
disconnectedtotal = @disconnectedtotal,
disconnectedall = @disconnectedall,
connected = @connected,
connectedtotal = @connectedtotal,
pendingorders = @pendingorders,

totalopened = (new+newconverted+renew),
totalclosed = (closed+suspended+closednonpayment+closedconverted+closedother),
difference = (totalopened - totalclosed),
totalcheck = (open+new+newconverted+renew+closed+closednonpayment+suspended+closedconverted+closedother+disconnected+disconnectedtotal+disconnectedall+connected+connectedtotal),
decommissioned = (select IsDecom(totalcheck)),
reported = (select reported from rcbill_my.lkpreported where servicenewtype=servicetype)
;


drop table if exists rcbill_my.packagelist;

create table rcbill_my.packagelist as
(
select distinct servicecategory, GetServiceCategory2(service) as servicecategory2, service, getcleanstring(servicetypeold) as package, servicetype,  servicesubcategory, rcbill.GetServicePrice(service,getcleanstring(servicetypeold)) as packageprice
from rcbill_my.activenumber
where reported='Y' and decommissioned='N'
and period=@rundate
group by 
servicecategory, GetServiceCategory2(servicecategory), service, package, servicetype,  servicesubcategory
order by 
servicecategory
);

select servicecategory, servicecategory2, service, package, servicetype, servicesubcategory, packageprice from rcbill_my.packagelist;

select * from rcbill_my.activenumber where period=@rundate and reported='Y' and decommissioned='N';

select period, count(1) from rcbill_my.activenumber group by period order by period desc;

-- select * from rcbill_my.activenumber where period=@rundate and reported='Y';
-- delete from rcbill_my.activenumber where period=@rundate;


################################################################################


use rcbill_my;
SET @@SESSION.sql_mode='ALLOW_INVALID_DATES';
SET SQL_SAFE_UPDATES = 0;

-- 	SET @rundate='2018-05-01'; SET @perioddate=str_to_date('2018-05-01','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-01;2018-05-01.csv'
-- 	SET @rundate='2018-05-02'; SET @perioddate=str_to_date('2018-05-02','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-02;2018-05-02.csv'
-- 	SET @rundate='2018-05-03'; SET @perioddate=str_to_date('2018-05-03','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-03;2018-05-03.csv'
-- 	SET @rundate='2018-05-04'; SET @perioddate=str_to_date('2018-05-04','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-04;2018-05-04.csv'
-- 	SET @rundate='2018-05-05'; SET @perioddate=str_to_date('2018-05-05','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-05;2018-05-05.csv'
-- 	SET @rundate='2018-05-06'; SET @perioddate=str_to_date('2018-05-06','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-06;2018-05-06.csv'
-- 	SET @rundate='2018-05-07'; SET @perioddate=str_to_date('2018-05-07','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-07;2018-05-07.csv'
-- 	SET @rundate='2018-05-08'; SET @perioddate=str_to_date('2018-05-08','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-08;2018-05-08.csv'
-- 	SET @rundate='2018-05-09'; SET @perioddate=str_to_date('2018-05-09','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-09;2018-05-09.csv'
-- 	SET @rundate='2018-05-10'; SET @perioddate=str_to_date('2018-05-10','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-10;2018-05-10.csv'
-- 	SET @rundate='2018-05-11'; SET @perioddate=str_to_date('2018-05-11','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-11;2018-05-11.csv'
-- 	SET @rundate='2018-05-12'; SET @perioddate=str_to_date('2018-05-12','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-12;2018-05-12.csv'
-- 	SET @rundate='2018-05-13'; SET @perioddate=str_to_date('2018-05-13','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-13;2018-05-13.csv'
-- 	SET @rundate='2018-05-14'; SET @perioddate=str_to_date('2018-05-14','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-14;2018-05-14.csv'
-- 	SET @rundate='2018-05-15'; SET @perioddate=str_to_date('2018-05-15','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-15;2018-05-15.csv'
-- 	SET @rundate='2018-05-16'; SET @perioddate=str_to_date('2018-05-16','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-16;2018-05-16.csv'
-- 	SET @rundate='2018-05-17'; SET @perioddate=str_to_date('2018-05-17','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-17;2018-05-17.csv'
-- 	SET @rundate='2018-05-18'; SET @perioddate=str_to_date('2018-05-18','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-18;2018-05-18.csv'
-- 	SET @rundate='2018-05-19'; SET @perioddate=str_to_date('2018-05-19','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-19;2018-05-19.csv'
-- 	SET @rundate='2018-05-20'; SET @perioddate=str_to_date('2018-05-20','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-20;2018-05-20.csv'
-- 	SET @rundate='2018-05-21'; SET @perioddate=str_to_date('2018-05-21','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-21;2018-05-21.csv'
-- 	SET @rundate='2018-05-22'; SET @perioddate=str_to_date('2018-05-22','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-22;2018-05-22.csv'
-- 	SET @rundate='2018-05-23'; SET @perioddate=str_to_date('2018-05-23','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-23;2018-05-23.csv'
-- 	SET @rundate='2018-05-24'; SET @perioddate=str_to_date('2018-05-24','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-24;2018-05-24.csv'
-- 	SET @rundate='2018-05-25'; SET @perioddate=str_to_date('2018-05-25','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-25;2018-05-25.csv'
-- 	SET @rundate='2018-05-26'; SET @perioddate=str_to_date('2018-05-26','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-26;2018-05-26.csv'
-- 	SET @rundate='2018-05-27'; SET @perioddate=str_to_date('2018-05-27','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-27;2018-05-27.csv'
-- 	SET @rundate='2018-05-28'; SET @perioddate=str_to_date('2018-05-28','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-28;2018-05-28.csv'
-- 	SET @rundate='2018-05-29'; SET @perioddate=str_to_date('2018-05-29','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-29;2018-05-29.csv'
 	SET @rundate='2018-05-30'; SET @perioddate=str_to_date('2018-05-30','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-30;2018-05-30.csv'
-- 	SET @rundate='2018-05-31'; SET @perioddate=str_to_date('2018-05-31','%Y-%m-%d');	LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ActiveContractsList/201805/2018-05-31;2018-05-31.csv'


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


select * from rcbill_my.dailyactivenumber where period=@rundate and reported='Y';
-- delete from rcbill_my.dailyactivenumber where period=@rundate;

/*
select * from rcbill_my.dailyactivenumber where period in ('2018-04-02','2018-04-03','2018-04-04','2018-04-05','2018-04-06','2018-04-07','2018-04-08','2018-04-09','2018-04-10')

delete from rcbill_my.dailyactivenumber where period in ('2018-04-02','2018-04-03','2018-04-04','2018-04-05','2018-04-06','2018-04-07','2018-04-08','2018-04-09','2018-04-10')

*/


select period, count(1) from rcbill_my.dailyactivenumber group by period order by period desc;

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


select count(1) from rcbill_my.customercontractactivity;
#now insert the daily activity table into the customer contract activity table. 
insert into rcbill_my.customercontractactivity
(
select * from rcbill_my.activeccl
)
;

-- delete from rcbill_my.customercontractactivity where period=@rundate;
/*
select * from rcbill_my.customercontractactivity where period in ('2018-04-02','2018-04-03','2018-04-04','2018-04-05','2018-04-06','2018-04-07','2018-04-08','2018-04-09','2018-04-10')

delete from rcbill_my.customercontractactivity where period in ('2018-04-02','2018-04-03','2018-04-04','2018-04-05','2018-04-06','2018-04-07','2018-04-08','2018-04-09','2018-04-10')

*/

select count(1) from rcbill_my.customercontractactivity;

-- select * from rcbill_my.customercontractactivity where period=@rundate and clientcode='I.000011750';

select period, count(1) from rcbill_my.customercontractactivity group by period order by period desc;

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
        , count(1) as ActiveDaysForContract
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
	upper(firm) like '%RETENTION%'
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

##############################################################

#CLIENT STATS




/*
select * from rcbill_my.anreport;

select * from rcbill_my.customercontractactivity 
where period=@rundate and reported='Y'
;

select * from rcbill.clientcontractdiscounts;


select a.*,b.percent,b.amount,b.servicename 
from rcbill_my.customercontractactivity a 
inner join 
rcbill.clientcontractdiscounts b 
on 
a.clientcode=b.clientcode and a.contractcode=b.contractcode
where a.period=@rundate and a.reported='Y'
;


select * from rcbill_my.dailyactivenumber 
where period=@rundate and reported='Y'
;

select distinct package from rcbill_my.customercontractactivity 
where period=@rundate and reported='Y'
order by package
;


select clientcode, contractcode, clientname, clientclass, clienttype, region, servicecategory
, count(1)
-- servicesubcategory, 
, GetNetwork(@rundate,contractcode) as Network
from rcbill_my.customercontractactivity 
where period=@rundate
group by clientcode, contractcode, clientname, clientclass, clienttype, region, servicecategory, GetNetwork(@rundate,contractcode)
order by clientname
;
*/

drop table if exists rcbill_my.clientnetworkservicepkg;
create table rcbill_my.clientnetworkservicepkg as
(
select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, a.service
, a.network, a.package, a.servicecategory
,a.contractcode
, count(distinct a.period) as ServiceCount, sum(distinct a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a
where a.period=@rundate and a.reported='Y'
group by 1,2,3,4,5,6,7,8,9,10,11
order by a.clientname

/*
select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, trim(upper(b.Service)) as Service
, GetNetwork(@rundate,a.contractcode) as Network, a.package, a.servicecategory
,a.contractcode
, count(distinct a.period) as ServiceCount, sum(distinct a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a
inner join
rcbill_my.dailyactivenumber b
on a.clientcode=b.clientcode and a.contractcode=b.contractcode and a.period=b.period and a.package=b.servicetype
where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, 8, a.package, a.servicecategory
,a.contractcode
order by a.clientname
*/

/*

select tb1.*, trim(upper(tb2.Service)) as Service
from 
(
select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region
,a.network
, a.package, a.servicecategory
,a.contractcode
, count(a.period) as ServiceCount, sum(a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a

where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, a.package, a.servicecategory
,a.contractcode
order by a.clientname

) tb1
inner join 
(
select clientcode,contractcode,period,servicetype,service from rcbill_my.dailyactivenumber 
where period=@rundate and reported='Y' 
) tb2
on
tb1.clientcode=tb2.clientcode and tb1.contractcode=tb2.contractcode 
and tb1.period=tb2.period 
and tb1.package=tb2.servicetype
;


-- select service from rcbill_my.dailyactivenumber where clientcode='I9987' and contractcode='I37042.1' and servicetype='Intel Voice 10' and period='2017-10-07' and reported='Y';

select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region
, a.network, a.package, a.servicecategory
,a.contractcode
, count(a.period) as ServiceCount, sum(a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a

where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, a.package, a.servicecategory
,a.contractcode
order by a.clientname



select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region
, GetNetwork(@rundate,a.contractcode) as Network, a.package, a.servicecategory
,a.contractcode
, count(a.period) as ServiceCount, sum(a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a

where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, a.package, a.servicecategory
,a.contractcode
order by a.clientname
*/
)
;



select * from rcbill_my.clientnetworkservicepkg;

/*
select clientcode, clientname, clientclass, clienttype, region, network, 
case when servicecategory='TV' then ServiceCount end as TV,
case when servicecategory='Internet' then ServiceCount end as Internet,
case when servicecategory='Voice' then ServiceCount end as Voice
from rcbill_my.clientnetworkservicepkg;
*/

drop table if exists rcbill_my.clientnetworkservicesum;

create table rcbill_my.clientnetworkservicesum as
(
select period, clientcode, clientname, clientclass, clienttype, region, network, sum(ActiveCount) as ActiveCount
,count(distinct contractcode) as contractcount,  ifnull(sum(tv),0) as tv, ifnull(sum(internet),0) as internet, ifnull(sum(voice),0) as voice
from 
(
select period, clientcode, clientname, clientclass, clienttype, region, network, ActiveCount, contractcode,
-- count(distinct contractcode) as contractcount,
case when servicecategory='TV' then ServiceCount end as TV,
case when servicecategory='Internet' then ServiceCount end as Internet,
case when servicecategory='Voice' then ServiceCount end as Voice
from rcbill_my.clientnetworkservicepkg
) cns
group by period, clientcode, clientname, clientclass, clienttype, region, network
);

select * from rcbill_my.clientnetworkservicesum;

-- select distinct package from rcbill_my.clientnetworkservicesum;


drop table if exists rcbill_my.clientnetworkservicestats;

create table rcbill_my.clientnetworkservicestats as
(
select period, clientcode, clientname, clientclass, clienttype, region, network, ActiveCount,contractcount,
case 
when tv>0 and internet>0 and voice>0 then 'All' 
when tv>0 and internet>0 and voice=0 then 'TV & Internet'
when tv>0 and internet=0 and voice=0 then 'TV Only'
when tv=0 and internet>0 and voice=0 then 'Internet Only'
when tv=0 and internet=0 and voice>0 then 'Voice Only'
when tv>0 and internet=0 and voice>0 then 'TV & Voice'
when tv=0 and internet>0 and voice>0 then 'Internet & Voice'
end as Services
from
rcbill_my.clientnetworkservicesum
)
;

select * from rcbill_my.clientnetworkservicestats;


drop table if exists rcbill_my.clientpackagestats;

create table rcbill_my.clientpackagestats as
(

	select period, clientcode, clientname, region, network, 
	ifnull(sum(`10GB`),0) as `10GB`,
	ifnull(sum(`20GB`),0) as `20GB`,
	ifnull(sum(`40GB`),0) as `40GB`,
    ifnull(sum(`Amber`),0) as `Amber`,
	ifnull(sum(`Basic`),0) as `Basic`,
	ifnull(sum(`Business Unlimited-1`),0) as `Business Unlimited-1`,
	ifnull(sum(`Business Unlimited-2`),0) as `Business Unlimited-2`,
	ifnull(sum(`Business Unlimited-6`),0) as `Business Unlimited-6`,
	ifnull(sum(`Business Unlimited-8`),0) as `Business Unlimited-8`,
	ifnull(sum(`Business Unlimited-8-daytime`),0) as `Business Unlimited-8-daytime`,
	ifnull(sum(Crimson),0) as `Crimson`,
	ifnull(sum(`Crimson Corporate`),0) as `Crimson Corporate`,
	ifnull(sum(`Dedicated Custom`),0) as `Dedicated Custom`,
	ifnull(sum(`Dedicated Plus`),0) as `Dedicated Plus`,
	ifnull(sum(`DualView`),0) as `DualView`,
	ifnull(sum(`MultiView`),0) as `MultiView`,
	ifnull(sum(Elite),0) as `Elite`,
	ifnull(sum(Executive),0) as `Executive`,
	ifnull(sum(Extravagance),0) as `Extravagance`,
	ifnull(sum(`Extravagance Corporate`),0) as `Extravagance Corporate`,
	ifnull(sum(Extreme),0) as `Extreme`,
	ifnull(sum(`Extreme Plus`),0) as `Extreme Plus`,
	ifnull(sum(French),0) as `French`,
	ifnull(sum(`Hotels/Channels`),0) as `Hotels/Channels`,
	ifnull(sum(`Hotels/Decoder`),0) as `Hotels/Decoder`,
	ifnull(sum(Indian),0) as `Indian`,
	ifnull(sum(`Indian Corporate`),0) as `Indian Corporate`,
	ifnull(sum(`Intel Data 10`),0) as `Intel Data 10`,
	ifnull(sum(`Intel Voice 10`),0) as `Intel Voice 10`,
	ifnull(sum(`Intel Voice 20`),0) as `Intel Voice 20`,
	ifnull(sum(Intelenovela),0) as `Intelenovela`,
	ifnull(sum(PBX),0) as `PBX`,
	ifnull(sum(Performance),0) as `Performance`,
	ifnull(sum(`Performance Plus`),0) as `Performance Plus`,
	ifnull(sum(Prepaid),0) as `Prepaid`,
	ifnull(sum(`Prepaid Data`),0) as `Prepaid Data`,
	ifnull(sum(Prestige),0) as `Prestige`,
	ifnull(sum(Starter),0) as `Starter`,
	ifnull(sum(`Turquoise High Tide`),0) as `Turquoise High Tide`,
	ifnull(sum(`Turquoise Low Tide`),0) as `Turquoise Low Tide`,
	ifnull(sum(TurquoiseTV),0) as `TurquoiseTV`,
	ifnull(sum(Value),0) as `Value`,
	ifnull(sum(`Voice Plus`),0) as `Voice Plus`,
	ifnull(sum(VPN),0) as `VPN`


	from 
	(
		select period, clientcode, clientname, region, network,
		case when package='10GB' then packagecount end as `10GB`,
		case when package='20GB' then packagecount end as `20GB`,
		case when package='40GB' then packagecount end as `40GB`,
		case when package='Amber' then packagecount end as `Amber`,
		case when package='Basic' then packagecount end as `Basic`,
		case when package='Business Unlimited-1' then packagecount end as `Business Unlimited-1`,
		case when package='Business Unlimited-2' then packagecount end as `Business Unlimited-2`,
		case when package='Business Unlimited-6' then packagecount end as `Business Unlimited-6`,
		case when package='Business Unlimited-8' then packagecount end as `Business Unlimited-8`,
		case when package='Business Unlimited-8-daytime' then packagecount end as `Business Unlimited-8-daytime`,
		case when package='Crimson' then packagecount end as `Crimson`,
		case when package='Crimson Corporate' then packagecount end as `Crimson Corporate`,
		case when package='Dedicated Custom' then packagecount end as `Dedicated Custom`,
		case when package='Dedicated Plus' then packagecount end as `Dedicated Plus`,
        
		case when package='DualView' then packagecount end as `DualView`,
        case when package='MultiView' then packagecount end as `MultiView`,
        
		case when package='Elite' then packagecount end as `Elite`,
		case when package='Executive' then packagecount end as `Executive`,
		case when package='Extravagance' then packagecount end as `Extravagance`,
		case when package='Extravagance Corporate' then packagecount end as `Extravagance Corporate`,
		case when package='Extreme' then packagecount end as `Extreme`,
		case when package='Extreme Plus' then packagecount end as `Extreme Plus`,
		case when package='French' then packagecount end as `French`,
		case when package='Hotels/Channels' then packagecount end as `Hotels/Channels`,
		case when package='Hotels/Decoder' then packagecount end as `Hotels/Decoder`,
		case when package='Indian' then packagecount end as `Indian`,
		case when package='Indian Corporate' then packagecount end as `Indian Corporate`,
		case when package='Intel Data 10' then packagecount end as `Intel Data 10`,
		case when package='Intel Voice 10' then packagecount end as `Intel Voice 10`,
		case when package='Intel Voice 20' then packagecount end as `Intel Voice 20`,
		case when package='Intelenovela' then packagecount end as `Intelenovela`,
		case when package='PBX' then packagecount end as `PBX`,
		case when package='Performance' then packagecount end as `Performance`,
		case when package='Performance Plus' then packagecount end as `Performance Plus`,
		case when package='Prepaid' then packagecount end as `Prepaid`,
		case when package='Prepaid Data' then packagecount end as `Prepaid Data`,
		case when package='Prestige' then packagecount end as `Prestige`,
		case when package='Starter' then packagecount end as `Starter`,
		case when package='Turquoise High Tide' then packagecount end as `Turquoise High Tide`,
		case when package='Turquoise Low Tide' then packagecount end as `Turquoise Low Tide`,
		case when package='TurquoiseTV' then packagecount end as `TurquoiseTV`,
		case when package='Value' then packagecount end as `Value`,
		case when package='Voice Plus' then packagecount end as `Voice Plus`,
		case when package='VPN' then packagecount end as `VPN`

		from 
		(
			/*
			select period, clientcode, clientname, package, region, GetNetwork(@rundate,contractcode) as network, count(1) as packagecount from rcbill_my.customercontractactivity where period=@rundate and clientcode in 
			(
            select clientcode from rcbill_my.clientnetworkservicestats 
            -- where services = 'TV & Internet' 
			-- and clienttype='Residential'
			) 
			group by period, clientcode, clientname, package, region, GetNetwork(@rundate,contractcode)
			order by clientcode
            */
            -- select * from rcbill_my.clientnetworkservicepkg
            
            select period, clientcode, clientname, package, region, network, count(1) as packagecount from rcbill_my.clientnetworkservicepkg where period=@rundate
            group by period, clientcode, clientname, package, region, network
			
        ) a
	) b 

	group by period, clientcode, clientname,region, network
	order by clientname

);

select * from rcbill_my.clientpackagestats;

drop table if exists rcbill_my.clientstats;

create table rcbill_my.clientstats 
(INDEX idxcs1 (clientcode)) as
(
select 
-- a.period as a_period, a.clientcode as a_clientcode, a.clientname as a_clientname, a.region as a_region, a.network as a_network
-- , 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount
, b.* from
rcbill_my.clientnetworkservicestats a 
inner join
rcbill_my.clientpackagestats b
on 
a.clientcode=b.clientcode
and 
a.region=b.region
and
a.network=b.network
order by b.clientcode
)

;

select * from rcbill_my.clientstats;


select coalesce(services,"GRAND TOTAL") as services, sum(activecount) as activecount, count(clientcode) as allaccounts
, count(distinct clientcode) as uniqueaccounts 
, sum(contractcount) as uniquecontracts
from
rcbill_my.clientstats
group by services
 with rollup 
;

select coalesce(network,"GRAND TOTAL") as network, sum(activecount) as activecount, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts
, sum(contractcount) as uniquecontracts
 from
rcbill_my.clientstats
group by network
 with rollup
;

select coalesce(network,"GRAND TOTAL") as network, coalesce(services,"Services Total") as services, sum(activecount) as activecount
, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts 
, sum(contractcount) as uniquecontracts
from
rcbill_my.clientstats
group by network, services
 with rollup
;

select coalesce(region,"GRAND TOTAL") as region, coalesce(network,"Network Total") as network, coalesce(services,"Services Total") as services, sum(activecount) as activecount
, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts 
, sum(contractcount) as uniquecontracts
from
rcbill_my.clientstats
group by region, network, services
 with rollup
;

##CREATE ACTIVE CUSTOMER CONTRACT DISCOUNTS
drop table if exists rcbill_my.activediscounts;
create table rcbill_my.activediscounts as
(
	select 
	tb1.*, tb2.clientid, tb2.contractid, tb2.serviceid,tb2.percent,tb2.amount,tb2.upddate,tb2.approved,tb2.approvalreason
	from 
	(
		select a.*, b.*
		from rcbill_my.clientnetworkservicepkg a 
		left join
		rcbill.clientcontractlastdiscount b
		on 
		a.clientcode=b.b_clientcode
		and
		a.contractcode=b.b_contractcode
		order by a.clientcode, a.contractcode
	) as tb1
	left join
	rcbill.clientcontractdiscounts tb2
	on
	tb1.clientcode=tb2.clientcode
	and
	tb1.contractcode=tb2.contractcode
	and
	tb1.b_upddate=tb2.upddate
	and tb1.service=tb2.servicename
)
;



-- CLIENT CONTRACT DISCOUNTS
drop table if exists rcbill_my.activediscounts2;
create table rcbill_my.activediscounts2 as 
(

	select a.*,b.percent,b.amount,b.servicename,b.upddate 
	from 
	(
		select a.*
		-- , b.service
		from 
		rcbill_my.customercontractactivity a 
		/*
		inner join 
		rcbill_my.dailyactivenumber b 
		on 
		a.period=b.period and a.contractcode=b.contractcode and a.clientcode=b.clientcode and a.servicesubcategory=b.servicesubcategory and a.package=b.servicetype
		and a.servicecategory=b.servicecategory
		*/
		where a.period=@rundate and a.reported='Y' 
	) a
	inner join
	( 
		-- rcbill.clientcontractdiscounts b 
		select a.*,b.b_upddate, b.b_clientcode, b.b_contractcode
		from 
		rcbill.clientcontractdiscounts a
		inner join 
		rcbill.clientcontractlastdiscount b 
		on 
		a.clientcode=b.b_clientcode and a.contractcode=b.b_contractcode and a.upddate=b.b_upddate

	) b
	on 
	a.clientcode=b.clientcode 
	and a.contractcode=b.contractcode
	and upper(trim(a.service))=upper(trim(b.servicename))
	-- where a.period=@rundate and a.reported='Y' 
)
;

select * from rcbill_my.activediscounts2;

select * from rcbill_my.activediscounts where percent>0 or amount>0;


select distinct clientcode from rcbill_my.activediscounts2;
select distinct contractcode from rcbill_my.activediscounts2;

select clientclass, count(distinct clientcode) as clients, count(distinct contractcode) contracts from rcbill_my.activediscounts2
group by clientclass
with rollup
;


###################################################################

call sp_ActiveNumber2();


/*
call sp_ActiveNumber(02,04,2018,'','');
call sp_ActiveNumber(03,04,2018,'','');
call sp_ActiveNumber(04,04,2018,'','');
call sp_ActiveNumber(05,04,2018,'','');
call sp_ActiveNumber(06,04,2018,'','');
call sp_ActiveNumber(07,04,2018,'','');
call sp_ActiveNumber(08,04,2018,'','');


call sp_GetActiveNumberFromTo('2018-04-02','2018-04-08');
*/

call sp_ActiveNumber(30,05,2018,'','');

call sp_GetActiveNumberFromTo('2018-05-28','2018-05-30');


SET @IP='197.234.0.223';
set @bytelimit = 52428800; ## 50MB in a month
-- set @bytelimit = 31457280;

select * from rcbill_my.dailygamingusage where TOTALBYTES>=@bytelimit;
select * from rcbill.clientcontractipmonth;

select * from rcbill_my.dailygamingusage where IP=@ip;
select * from rcbill.rcb_ipusage where processedclientip=@ip;
select * from rcbill.clientcontractip where processedclientip=@ip;
select * from rcbill.clientcontractipmonth where processedclientip=@ip;


drop table if exists rcbill_my.temp_dailygamingusage;
create table rcbill_my.temp_dailygamingusage
(INDEX idxtdgu1 (ip), INDEX idxtdgu2(start_yr), INDEX idxtdgu3(end_yr))
 as
(
  select distinct GAMINGCATEGORY, GAMINGNAME, IP, MONTH(DATESTART) AS START_MTH, YEAR(DATESTART) AS START_YR, MONTH(DATEEND) AS END_MTH, YEAR(DATEEND) AS END_YR
  from 
  rcbill_my.dailygamingusage
  where TOTALBYTES>=@bytelimit
  group by 1,2,3,4,5,6,7
)
;

select * from rcbill_my.temp_dailygamingusage;


show index from rcbill_my.temp_dailygamingusage;
show index from rcbill.clientcontractipmonth;



select 
-- a.*
-- ,b.*
-- distinct
 a.START_MTH, a.START_YR, a.END_MTH, a.END_YR, a.GAMINGCATEGORY, a.GAMINGNAME, a.IP
  -- , a.TOTALBYTES
, b.CLIENTCODE
, b.CLIENTID
, b.CLIENTNAME
, b.CONTRACTCODE

from 
rcbill_my.temp_dailygamingusage a 

left join 
-- rcbill.rcb_ipusage b
rcbill.clientcontractipmonth b 
on 
a.IP=b.processedclientip
and
(
-- 	(a.datestart<=b.USAGEDATE) and (a.dateend>=b.USAGEDATE)
	(a.START_MTH=b.USAGE_MTH) and (a.END_MTH=b.USAGE_MTH)
    and
	(a.START_YR=b.USAGE_YR) and (a.END_YR=b.USAGE_YR)
)
where 
-- a.TOTALBYTES>=@bytelimit
-- and
a.ip=@ip
;


select a.*
-- ,b.package,b.region
, (select distinct package from rcbill_my.customercontractactivity where clientcode=a.CLIENTCODE and contractcode=a.CONTRACTCODE limit 1) as package
, (select distinct network from rcbill_my.customercontractactivity where clientcode=a.CLIENTCODE and contractcode=a.CONTRACTCODE limit 1) as network
from 
(
		select 
		-- a.*
		-- ,b.*
		-- distinct
		 a.START_MTH, a.START_YR, a.END_MTH, a.END_YR, a.GAMINGCATEGORY, a.GAMINGNAME, a.IP
		  -- , a.TOTALBYTES
		, b.CLIENTCODE
		, b.CLIENTID
		, b.CLIENTNAME
		, b.CONTRACTCODE

		from 
		rcbill_my.temp_dailygamingusage a 

		inner join 
		-- rcbill.rcb_ipusage b
		rcbill.clientcontractipmonth b 
		on 
		a.IP=b.processedclientip

		and
		(
		-- 	(a.datestart<=b.USAGEDATE) and (a.dateend>=b.USAGEDATE)
			(a.START_MTH=b.USAGE_MTH) and (a.END_MTH=b.USAGE_MTH)
			and
			(a.START_YR=b.USAGE_YR) and (a.END_YR=b.USAGE_YR)
		)
) a 

 
;







######################################################################



/*
-- show index from rcbill.rcb_ipusage;
select 
a.*
,b.*
from 
rcbill_my.dailygamingusage a 

-- (
-- 	select * from rcbill_my.dailygamingusage where TOTALBYTES>=@bytelimit
-- ) a

left join 
rcbill.rcb_ipusage b
-- rcbill.clientcontractip b 
on 
a.IP=b.processedclientip
and
(
	(a.datestart<=b.USAGEDATE) and (a.dateend>=b.USAGEDATE)
)
where 
a.TOTALBYTES>=@bytelimit
 and
 a.ip=@ip
;
*/



select 
-- a.*
-- ,b.*
-- distinct
 a.DATESTART, a.DATEEND, a.GAMINGCATEGORY, a.GAMINGNAME, a.IP
  -- , a.TOTALBYTES
, b.CLIENTCODE
, b.CLIENTID
, b.CLIENTNAME
, b.CONTRACTCODE

-- , b.USAGEDATE
from 
rcbill_my.dailygamingusage a 
left join 
-- rcbill.rcb_ipusage b
rcbill.clientcontractipmonth b 
on 
a.IP=b.processedclientip
and
(
-- 	(a.datestart<=b.USAGEDATE) and (a.dateend>=b.USAGEDATE)
	(month(a.datestart)=b.USAGE_MTH) and (month(a.dateend)=b.USAGE_MTH)
    and
	(year(a.datestart)=b.USAGE_YR) and (year(a.dateend)=b.USAGE_YR)
)
where 
a.TOTALBYTES>=@bytelimit
 and
 a.ip=@ip

-- group by 
-- a.DATESTART, a.DATEEND, a.GAMINGCATEGORY, a.GAMINGNAME, a.IP
 
;
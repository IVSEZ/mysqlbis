

use rcbill_my;
-- set @periodstart='2018-01-01';
-- set @periodend='2018-01-31';
-- set @periodstart='2018-02-01';
-- set @periodend='2018-02-28';
-- set @periodstart='2018-03-01';
-- set @periodend='2018-03-31';
-- set @periodstart='2018-04-01';
-- set @periodend='2018-04-30';
-- set @periodstart='2018-05-01';
-- set @periodend='2018-05-31';
-- set @periodstart='2018-06-01';
-- set @periodend='2018-06-30';
-- set @periodstart='2018-07-01';
-- set @periodend='2018-07-31';
-- set @periodstart='2018-08-01';
-- set @periodend='2018-08-31';
 set @periodstart='2018-09-01';
 set @periodend='2018-09-30';

## change dates on csv 4 files

set @gamingcategory='Playstation';

set @gamingname='Playstation.net content download';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Playstation.net content download.csv'
REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()
;


###################################################################

set @gamingcategory='Playstation';

set @gamingname='Playstation game';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Playstation game.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @gamingcategory='Playstation';
set @gamingname='Playstation.net';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Playstation.net.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @gamingcategory='Playstation';
set @gamingname='Playstation';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Playstation.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;



###################################################################

set @gamingcategory='XBox';
set @gamingname='Xbox Live TLS';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Xbox Live TLS.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @gamingcategory='Steam';
set @gamingname='Steam Client';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Steam Client.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;

###################################################################



set @gamingcategory='Twitch';
set @gamingname='Twitch';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Twitch.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

select count(*) from rcbill_my.dailygamingusage;

select * from rcbill_my.dailygamingusage;

### only records where usage is > 50MB 
set @bytelimit = 52428800;
-- set @bytelimit = 31457280;

### EXPORTED FOR GAMING REPORT
select * from rcbill_my.dailygamingusage where TOTALBYTES>=@bytelimit;

#######################################
## GAMING ANALYSIS SCRIPT


-- set @bytelimit = 52428800; ## 50MB in a month


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


select a.*
, (select distinct package from rcbill_my.customercontractactivity where clientcode=a.CLIENTCODE and contractcode=a.CONTRACTCODE limit 1) as package
, (select distinct network from rcbill_my.customercontractactivity where clientcode=a.CLIENTCODE and contractcode=a.CONTRACTCODE limit 1) as network
from 
(
		select 
		 a.START_MTH, a.START_YR, a.END_MTH, a.END_YR, a.GAMINGCATEGORY, a.GAMINGNAME, a.IP
		, b.CLIENTCODE
		, b.CLIENTID
		, b.CLIENTNAME
		, b.CONTRACTCODE
		from 
		rcbill_my.temp_dailygamingusage a 
		inner join 
		rcbill.clientcontractipmonth b 
		on 
		a.IP=b.processedclientip
		and
		(
			(a.START_MTH=b.USAGE_MTH) and (a.END_MTH=b.USAGE_MTH)
			and
			(a.START_YR=b.USAGE_YR) and (a.END_YR=b.USAGE_YR)
		)
) a 
;





#######################################


-- select * from rcbill_my.dailyusage where clientcode='I.000010761';

-- select * from rcbill_my.dailyusage where clientcode='I.000011750';

select *,((totalbytes/1024)/1024) as TOTALMB, (((totalbytes/1024)/1024)/1024) as TOTALGB from rcbill_my.dailygamingusage order by 8 desc;

select *,(totalbytes/1048576) as TOTALMB, (totalbytes/1073741824) as TOTALGB from rcbill_my.dailygamingusage order by 8 desc;

select distinct ip, count(*) as countip, (sum(totalbytes)/1048576) as TOTALMB, (sum(totalbytes)/1073741824) as TOTALGB 
from rcbill_my.dailygamingusage
group by ip order by 4 desc;

select distinct GAMINGCATEGORY, month(DATESTART) as monthstart, count(*) as records, count(distinct ip) as ipcount, (sum(totalbytes)/1048576) as TOTALMB, (sum(totalbytes)/1073741824) as TOTALGB 
from rcbill_my.dailygamingusage
group by GAMINGCATEGORY, 2 order by 5 desc;



select distinct GAMINGCATEGORY, GAMINGNAME, month(DATESTART) as monthstart, count(*) as records, count(distinct ip) as ipcount, (sum(totalbytes)/1048576) as TOTALMB, (sum(totalbytes)/1073741824) as TOTALGB 
from rcbill_my.dailygamingusage
group by GAMINGCATEGORY, GAMINGNAME, 3 order by 6 desc;





###################################################################



set @gamingcategory='XBox';
set @gamingname='Xbox Live update';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Xbox Live update.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;



###################################################################


set @gamingcategory='XBox';
set @gamingname='Xbox Live';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Xbox Live.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @gamingcategory='Steam';
set @gamingname='Steam Game';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Steam Game.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################


set @gamingcategory='Counter-Strike';
set @gamingname='Counter-Strike Global Offensive';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Gaming\\201809-Counter-Strike Global Offensive.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
GAMINGCATEGORY=@gamingcategory ,
GAMINGNAME=@gamingname ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################
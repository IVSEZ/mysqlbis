

use rcbill_my;
-- set @periodstart='2019-01-01';
-- set @periodend='2019-02-15';

-- set @periodstart='2019-02-16';
-- set @periodend='2019-03-15';

-- set @periodstart='2019-03-16';
-- set @periodend='2019-04-15';

-- set @periodstart='2019-04-16';
-- set @periodend='2019-05-15';

-- set @periodstart='2019-05-16';
-- set @periodend='2019-06-15';

-- set @periodstart='2019-06-16';
-- set @periodend='2019-07-15';

-- set @periodstart='2019-07-16';
-- set @periodend='2019-08-15';

-- set @periodstart='2019-08-16';
-- set @periodend='2019-09-15';

-- set @periodstart='2019-09-16';
-- set @periodend='2019-10-15';

-- set @periodstart='2019-10-16';
-- set @periodend='2019-12-31';

set @periodstart='2019-01-01';
set @periodend='2019-12-31';

## change dates on csv 4 files

set @streamingcategory='STREAMING';
-- set @streamingname='NETFLIX';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-01012019-15022019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16022019-15032019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16032019-15042019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16042019-15052019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16052019-15062019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16062019-15072019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16072019-15082019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16082019-15092019.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16092019-15102019.csv'

-- set @streamingname='YOUTUBE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Streaming\\YouTube-01012019-31122019.csv'
-- set @streamingname='FACEBOOK VIDEO'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Streaming\\FBVideo-01012019-31122019.csv'


-- set @streamingname='NETFLIX'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-16102019-31122019.csv'
-- set @streamingname='NETFLIX'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Netflix\\Netflix-01012020-17082020.csv'

-- set @streamingname='YOUTUBE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Streaming\\YouTube-01012020-17082020.csv'
-- set @streamingname='FACEBOOK VIDEO'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Streaming\\FBVideo-01012020-17082020.csv'



REPLACE INTO TABLE `rcbill_my`.`dailystreamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(
@ip ,
@incomingbytes,
@outgoingbytes,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
STREAMINGCATEGORY=@streamingcategory ,
STREAMINGNAME=@streamingname ,
IP=@ip ,
INCOMINGBYTES=@incomingbytes,
OUTGOINGBYTES=@outgoingbytes,
TOTALBYTES=@totalbytes,
INSERTEDON=now()
;


###################################################################

-- SELECT * FROM rcbill_my.dailystreamingusage ;
select datestart, dateend, STREAMINGNAME, count(*) from rcbill_my.dailystreamingusage
group by datestart, dateend, STREAMINGNAME
;

select datestart, dateend, STREAMINGNAME, sum(INCOMINGBYTES) as INCOMINGBYTES, sum(OUTGOINGBYTES) as OUTGOINGBYTES, sum(TOTALBYTES) as TOTALBYTES 
, (sum(INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
, (sum(OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB, (sum(TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB
from rcbill_my.dailystreamingusage
group by datestart, dateend, STREAMINGNAME
;

select year(DATESTART) as DATE_YEAR, STREAMINGNAME
-- , sum(INCOMINGBYTES) as INCOMINGBYTES, sum(OUTGOINGBYTES) as OUTGOINGBYTES, sum(TOTALBYTES) as TOTALBYTES 
, (sum(INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
, (sum(OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB, (sum(TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB
-- , count(ip) as IP_COUNT
, count(distinct IP) as D_IP_COUNT
from rcbill_my.dailystreamingusage
group by 1, STREAMINGNAME
;


select year(DATESTART) as DATE_YEAR, STREAMINGNAME
-- , sum(INCOMINGBYTES) as INCOMINGBYTES, sum(OUTGOINGBYTES) as OUTGOINGBYTES, sum(TOTALBYTES) as TOTALBYTES 
-- , (sum(INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
-- , (sum(OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
-- , (sum(TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB
, (sum(INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
, (sum(OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
, (sum(TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB
-- , count(ip) as IP_COUNT
, count(distinct IP) as D_IP_COUNT
from rcbill_my.dailystreamingusage
group by 1, STREAMINGNAME
;

-- SELECT * FROM rcbill.clientcontractipmonth;


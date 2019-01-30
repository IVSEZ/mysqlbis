#################################################################

# VOD TELEMETRY


use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-29012019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
( 
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
)
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()
;

explain select count(1) as vodtelemetry from rcb_vodtelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_vodtelemetry
group by 1
order by 1 desc
limit 5
;

select * from rcbill.rcb_vodtelemetry order by insertedon desc limit 100;
set SQL_SAFE_UPDATES=0;
delete from rcbill.rcb_vodtelemetry where InsertedOn = '2018-08-22 09:13:57';
delete from rcbill.rcb_vodtelemetry where date(InsertedOn) = '2018-11-03';

*/

################################################################
#################################################################

# VOD TELEMETRY MISSING DAILY


use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-Missing-Daily-29012019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
( 
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd ,
@SessionStart2 ,
@SessionEnd2 
)
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart2 ,
SESSIONEND=@SessionEnd2 ,

INSERTEDON=now()
;

explain select count(1) as vodtelemetry from rcb_vodtelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_vodtelemetry
group by 1
order by 1 desc
limit 5
;

select * from rcbill.rcb_vodtelemetry order by insertedon desc limit 100;
set SQL_SAFE_UPDATES=0;
delete from rcbill.rcb_vodtelemetry where InsertedOn = '2018-09-25 07:12:50';
*/

########################################################

# TS TELEMETRY

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-29012019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tstelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
)
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()
;

explain select count(1) as tstelemetry from rcbill.rcb_tstelemetry;

-- show index from rcbill.rcb_tstvtelemetry;
-- select * from rcbill.rcb_tstelemetry order by insertedon desc limit 10000;
/*
select * from rcbill.rcb_tstelemetry order by insertedon desc limit 100;
set SQL_SAFE_UPDATES=0;
delete from rcbill.rcb_tstelemetry where InsertedOn = '2018-08-22 09:13:57';
*/
/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_tstelemetry
group by 1
order by 1 desc
limit 5
;
*/
##############################################################################


#################################################################

# LIVE TV TELEMETRY

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllLIVETVTelemetry-29012019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_livetvtelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
)
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()


;

explain select count(1) as livetvtelemetry from rcbill.rcb_livetvtelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_livetvtelemetry
group by 1
order by 1 desc
limit 5
;
*/
/*
select * from rcbill.rcb_livetvtelemetry order by insertedon desc limit 100;
set SQL_SAFE_UPDATES=0;
delete from rcbill.rcb_livetvtelemetry where InsertedOn = '2018-08-22 09:13:57';
*/
########################################################

# RADIO TELEMETRY

use rcbill;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllRADIOTelemetry-29012019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_radiotelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
)
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()
;

explain select count(1) as radiotelemetry from rcbill.rcb_radiotelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_radiotelemetry
group by 1
order by 1 desc
limit 5
;
*/
##############################################################################
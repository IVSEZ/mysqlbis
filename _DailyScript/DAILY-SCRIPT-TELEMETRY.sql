#################################################################

# VOD TELEMETRY


use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-29072018.csv' 
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

select count(1) as vodtelemetry from rcb_vodtelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_vodtelemetry
group by 1
order by 1 desc
limit 5
;

select * from rcbill.rcb_vodtelemetry order by insertedon desc;
set SQL_SAFE_UPDATES=0;
delete from rcbill.rcb_vodtelemetry where InsertedOn = '2018-07-25 08:06:19';
*/

########################################################

# TS TELEMETRY

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-29072018.csv' 
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

select count(1) as tstelemetry from rcbill.rcb_tstelemetry;

-- show index from rcbill.rcb_tstvtelemetry;
-- select * from rcbill.rcb_tstelemetry order by insertedon desc limit 100;
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

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllLIVETVTelemetry-29072018.csv' 
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

select count(1) as livetvtelemetry from rcbill.rcb_livetvtelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_livetvtelemetry
group by 1
order by 1 desc;
*/

########################################################

# RADIO TELEMETRY

use rcbill;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllRADIOTelemetry-29072018.csv' 
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

select count(1) as radiotelemetry from rcbill.rcb_radiotelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_radiotelemetry
group by 1
order by 1 desc;
*/
##############################################################################